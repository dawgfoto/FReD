//Written in the D programming language
/**
    gen_uni is a quick & dirty source code generator for unicode datastructures
*/
import fred;
import std.ascii, std.stdio, std.conv, std.algorithm, std.array, std.format, std.string;

Charset[int] casefold;//entries by delta
uint[] lowIrreg;//that low/high doesn't mean they are all _letters_!
uint[] highIrreg; //so we check that ;)
Charset[string] props;
string[string] aliases;
string[] blacklist = [ "Lu", "Ll" ];
uint[] globalIndex;

void scanUniData(alias Fn)(string name, Regex!char r)
{
    foreach(line; File(name).byLine)
	{
        auto m = match(line, r);
        if(!m.empty)
            Fn(m);
    }
}

void main(string[] argv)
{
    writeln("//Written in the D programming language
/**
 * Fast Regular expressions for D
 *
 * License: $(WEB boost.org/LICENSE_1_0.txt, Boost License 1.0).
 *
 * Authors: Dmitry Olshansky
 *
 */
//Automatically generated from Unicode Character Database files
import fred;");
    loadGlobalIndex("Global.txt");
    loadCaseFolding("Casefolding.txt");
    loadBlocks("Blocks.txt");
    loadProperties("PropList.txt");
    loadProperties("DerivedGeneralCategory.txt");
    loadProperties("Scripts.txt");
    testCasingIrregular();
    writeCaseFolding();
    writeProperties();
}

void testCasingIrregular()
{
    auto lowSet = props["Ll"].dup;
    Charset irreg;
    foreach(ch; lowIrreg)
            irreg.add(ch);
    foreach(ch; highIrreg)
            irreg.add(ch);
    lowSet.intersect(irreg);
    uint array[];
    foreach(ival; lowSet.intervals)
    {
        for(uint ch=ival.begin; ch<=ival.end; ch++)
            array ~= ch;
    }
    assert(equal(sort(array),sort(lowIrreg.dup)));
    auto upperSet = props["Lu"].dup;
    upperSet.intersect(irreg);
    array.length = 0;
    foreach(ival; upperSet.intervals)
    {
        for(uint ch=ival.begin; ch<=ival.end; ch++)
            array ~= ch;
    }
    assert(equal(sort(array),sort(highIrreg.dup)));
}

void loadGlobalIndex(string name)
{
    File f = File(name);
    foreach(line; f.byLine)
	{
        if(!line.empty)
            globalIndex ~= to!uint(strip(line));
    }
}

void loadCaseFolding(string name)
{
	uint[uint] hash;
	auto r = regex("([^;]*); [CS];\\s*([^;]*);");
	foreach(line; File(name).byLine)
	{
		auto m = match(line, r);
		if(!m.empty)
		{
			auto s1 = m.captures[1];
			auto s2 = m.captures[2];
			auto a1 = parse!uint(s1, 16);
			auto a2 = parse!uint(s2, 16);
			hash[a1] = a2;
		}
	}
	foreach(k, v; hash)
	{
		auto d = cast(int)k - cast(int)v;
		uint val;
		if(d > 0 )
            val = v;
        else
        {
             val = k;
             d = -d;
        }
        //store as lesser codepoint interval + positive delta
		if(d !in casefold)
			casefold[d] = Charset.init;
		casefold[d].add(val);
	}
	auto copy =  casefold[1].intervals.dup;
	foreach(ival;  copy)
        for(uint ch = ival.begin; ch<=ival.end; ch++)
        {
            casefold[1].add(1 + ch);
        }
}

void loadBlocks(string f)
{
	auto r = regex(`^([0-9A-F]+)\.\.([0-9A-F]+);\s*(.*)\s*$`);
	scanUniData!((m){
			auto s1 = m.captures[1];
			auto s2 = m.captures[2];
			auto a1 = parse!uint(s1, 16);
			auto a2 = parse!uint(s2, 16);
			props["In"~to!string(m.captures[3])] = Charset([Interval(a1, a2)]);
	})(f, r);
}

void loadProperties(string inp)
{
    auto r = regex(`^(?:(?:([0-9A-F]+)\.\.([0-9A-F]+)|([0-9A-F]+))\s*;\s*([^ ]*)\s*#|# (?:\w|_)+=((?:\w|_)+))`);
    string aliasStr;
	scanUniData!((m){
        auto name = to!string(m.captures[4]);
        if(!m.captures[5].empty)
            aliasStr = to!string(m.captures[5]);
		else if(!m.captures[1].empty)
        {
            auto sa = m.captures[1];
            auto sb = m.captures[2];
            uint a = parse!uint(sa, 16);
            uint b = parse!uint(sb, 16);
            if(name !in props)
                props[name] = Charset.init;
            props[name].add(Interval(a,b));
            if(!aliasStr.empty)
            {
                aliases[name] = aliasStr;
                aliasStr = "";
            }
        }
        else if(!m.captures[3].empty)
        {
            auto sx = m.captures[3];
            uint x = parse!uint(sx, 16);
            if(name !in props)
                props[name] = Charset.init;
            props[name].add(x);
            if(!aliasStr.empty)
            {
                aliases[name] = aliasStr;
                aliasStr = "";
            }
        }
	})(inp, r);
}

string charsetString(in Charset set, string sep=";\n")
{
    auto app = appender!(char[])();
	formattedWrite(app,"Charset([\n");
	foreach(i; set.intervals)
		formattedWrite(app, "    Interval(0x%05x,0x%05x),\n", i.begin, i.end);
	formattedWrite(app, "])%s\n",sep);
    return cast(string)app.data;
}

void writeCaseFolding()
{
    write("//any codepoint in these intervals is trivially uppercased/lowercased"
" (lowest bit set -> lower)\nimmutable evenUpper = ");
	write(charsetString(casefold[1]));
	writeln("struct CommonCaseEntry
{
    short delta;
    Charset set;

}
//these are a bit harder to lowercase/uppercase lower: +- delta
immutable commonCaseTable = [");
    auto keys =casefold.keys();
    sort!"abs(a) < abs(b)"(keys);
	foreach(k; keys)
	{
		if(k > 1)
		{
			auto app = appender!(char[])();
			bool notEmpty = false;
			formattedWrite(app, "CommonCaseEntry(%d, Charset([", k);
			foreach(i; casefold[k].intervals)
			{
				if(i.begin == i.end)
				{
					lowIrreg ~= i.begin;
					highIrreg ~= i.begin+k;
				}
				else
				{
					formattedWrite(app, "Interval(0x%05x, 0x%05x),",i.begin, i.end);
					notEmpty = true;
				}

			}
			formattedWrite(app, "])),");
			if(notEmpty)
				writeln(app.data);
			app.clear();
			notEmpty  = false;
			formattedWrite(app,"CommonCaseEntry(%d, Charset([", -k);
			foreach(i; casefold[k].intervals)
			{
				if(i.begin != i.end)
				{
					formattedWrite(app,"Interval(0x%05x, 0x%05x),",i.begin+k, i.end+k);
					notEmpty = true;
				}

			}
			formattedWrite(app, "])),");
			if(notEmpty)
				writeln(app.data);
		}
	}
	writeln("];\n");
	auto index = new uint[lowIrreg.length];
	assert(lowIrreg.length == highIrreg.length);
	makeIndex(lowIrreg, index);
	writeln("//horrible irregularities are stockpiled here as equivalent pairs"
            " (note  it's not a 1:1 mapping, more like n:m)\n"
            "immutable(uint)[] casePairs = [");
	foreach(i; index)
		writefln("0x%05x, 0x%05x,",lowIrreg[i], highIrreg[i]);
	writeln("];");
}

string identName(string s)
{
    auto app = appender!(char[])();
    foreach(c; s)
        if(c == '-' || c == ' ')
            app.put('_');
        else
            app.put(c);
    return cast(string)app.data;
}

string uniformName(string s)
{
    auto app = appender!(char[])();
    foreach(c; s)
        if(c != '-' && c != ' ' && c != '_')
            app.put(toLower(c));
    return cast(string)app.data;
}


void writeProperties()
{
    File hashf = File("HashKeys.txt", "wb");
    writeln("struct UnicodeProperty
{
    string name;
    immutable Charset set;
}");
    foreach(k, v; props)
    {
        if(countUntil(blacklist, k) < 0)
        {
            writef("immutable(Charset) unicode%s = ", identName(k));
            write(charsetString(v));
        }
    }
    write("immutable(UnicodeProperty)[] unicodeProperties = [\n");
    string[] lines;
    string[] hashLines;
    auto app = appender!(char[])();
    auto keys = props.keys;
    
    foreach(k; keys)
    {
        if(countUntil(blacklist, k) < 0)
        {
            formattedWrite(app, "UnicodeProperty(\"%s\", unicode%s),\n", k, identName(k));
            lines ~= app.data.idup;
            hashLines ~= uniformName(k);
            app.shrinkTo(0);
            if(k in aliases)
            {
                stderr.writeln(aliases[k]);
                formattedWrite(app, "UnicodeProperty(\"%s\", unicode%s),\n",aliases[k], identName(k));
                lines ~= app.data.idup;
                hashLines ~= uniformName(aliases[k]);
                app.shrinkTo(0);
            }
            
        }
    }
    assert(hashLines.length ==lines.length);
    int[] index = new int[lines.length];
    makeIndex!propertyNameLess(lines, index);
    foreach(i, v; lines)
    {
        //auto j = countUntil(globalIndex, i);
        //write(lines[j]);
        write(lines[index[i]]);
        hashf.writeln(hashLines[index[i]]);
    }
        
    writeln("];");
}
