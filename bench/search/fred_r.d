//
//when doing C-T regexes, use -J.; pattern for C-T regex is located in file ct_pattern !
module main;

import std.file;
import std.stdio;
import std.datetime;
import std.conv;

import fred;
version(backtracking)
	alias bmatch matchFn;
else version(thompson)	
	alias match matchFn;
else version(ct_regex)
	alias match matchFn;
else	
	static assert(0, "Use -version=backtracking or -version=thompson or -version=ct_regex");
version(Wchar)
	alias wstring String;
else version(Dchar)
	alias dstring String;
else
	alias string String;
	
int main(string[] argv)
{
    if(argv.length < 3){
        writefln("Usage %s <re> file [print]",argv[0]);
        return 1;
    }
    version(ct_regex)
        auto engine = ctRegex!(to!String(import("ct_pattern")),"g");
    else
        auto engine = regex(to!String(argv[1]),"g");
    auto raw = cast(char[])std.file.read(argv[2]);
    auto data = to!String(raw);
    size_t count=0;
    StopWatch sw;
    sw.start();
    if(argv.length == 4 && argv[3] =="print")
        foreach(m; matchFn(data,engine)){
            writeln(m.hit);
            count++;
        }
    else
        foreach(m; matchFn(data,engine)){
            count++;
        }
    sw.stop();
    auto dt = sw.peek().msecs;
    writefln("Total matches %s.\nTime elapsed %s sec",count,dt/1000.0);
    return 0;
}
