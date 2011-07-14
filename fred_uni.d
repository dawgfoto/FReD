//Written in the D programming language
/**
 * Fast Regular expressions for D
 *
 * License: $(WEB boost.org/LICENSE_1_0.txt, Boost License 1.0).
 *
 * Authors: Dmitry Olshansky
 *
 */
//Automatically generated from Unicode Character Database files
import fred;
//any codepoint in these intervals is trivially uppercased/lowercased (lowest bit set -> lower)
immutable evenUpper = Charset([
    Interval(0x00100,0x0012f),
    Interval(0x00132,0x00137),
    Interval(0x00139,0x00148),
    Interval(0x0014a,0x00177),
    Interval(0x00179,0x0017e),
    Interval(0x00182,0x00185),
    Interval(0x00187,0x00188),
    Interval(0x0018b,0x0018c),
    Interval(0x00191,0x00192),
    Interval(0x00198,0x00199),
    Interval(0x001a0,0x001a5),
    Interval(0x001a7,0x001a8),
    Interval(0x001ac,0x001ad),
    Interval(0x001af,0x001b0),
    Interval(0x001b3,0x001b6),
    Interval(0x001b8,0x001b9),
    Interval(0x001bc,0x001bd),
    Interval(0x001c5,0x001c6),
    Interval(0x001c8,0x001c9),
    Interval(0x001cb,0x001dc),
    Interval(0x001de,0x001ef),
    Interval(0x001f2,0x001f5),
    Interval(0x001f8,0x0021f),
    Interval(0x00222,0x00233),
    Interval(0x0023b,0x0023c),
    Interval(0x00241,0x00242),
    Interval(0x00246,0x0024f),
    Interval(0x00370,0x00373),
    Interval(0x00376,0x00377),
    Interval(0x003c2,0x003c3),
    Interval(0x003d8,0x003ef),
    Interval(0x003f7,0x003f8),
    Interval(0x003fa,0x003fb),
    Interval(0x00460,0x00481),
    Interval(0x0048a,0x004bf),
    Interval(0x004c1,0x004ce),
    Interval(0x004d0,0x00527),
    Interval(0x01e00,0x01e95),
    Interval(0x01ea0,0x01eff),
    Interval(0x02183,0x02184),
    Interval(0x02c60,0x02c61),
    Interval(0x02c67,0x02c6c),
    Interval(0x02c72,0x02c73),
    Interval(0x02c75,0x02c76),
    Interval(0x02c80,0x02ce3),
    Interval(0x02ceb,0x02cee),
    Interval(0x0a640,0x0a66d),
    Interval(0x0a680,0x0a697),
    Interval(0x0a722,0x0a72f),
    Interval(0x0a732,0x0a76f),
    Interval(0x0a779,0x0a77c),
    Interval(0x0a77e,0x0a787),
    Interval(0x0a78b,0x0a78c),
    Interval(0x0a790,0x0a791),
    Interval(0x0a7a0,0x0a7a9),
]);

struct CommonCaseEntry
{
    short delta;
    Charset set;

}
//these are a bit harder to lowercase/uppercase lower: +- delta
immutable commonCaseTable = [
CommonCaseEntry(8, Charset([Interval(0x01f00, 0x01f07),Interval(0x01f10, 0x01f15),Interval(0x01f20, 0x01f27),Interval(0x01f30, 0x01f37),Interval(0x01f40, 0x01f45),Interval(0x01f60, 0x01f67),Interval(0x01f80, 0x01f87),Interval(0x01f90, 0x01f97),Interval(0x01fa0, 0x01fa7),Interval(0x01fb0, 0x01fb1),Interval(0x01fd0, 0x01fd1),])),
CommonCaseEntry(-8, Charset([Interval(0x01f08, 0x01f0f),Interval(0x01f18, 0x01f1d),Interval(0x01f28, 0x01f2f),Interval(0x01f38, 0x01f3f),Interval(0x01f48, 0x01f4d),Interval(0x01f68, 0x01f6f),Interval(0x01f88, 0x01f8f),Interval(0x01f98, 0x01f9f),Interval(0x01fa8, 0x01faf),Interval(0x01fb8, 0x01fb9),Interval(0x01fd8, 0x01fd9),])),
CommonCaseEntry(16, Charset([Interval(0x02160, 0x0216e),])),
CommonCaseEntry(-16, Charset([Interval(0x02170, 0x0217e),])),
CommonCaseEntry(26, Charset([Interval(0x024b6, 0x024cf),])),
CommonCaseEntry(-26, Charset([Interval(0x024d0, 0x024e9),])),
CommonCaseEntry(32, Charset([Interval(0x00041, 0x0005a),Interval(0x000c0, 0x000d6),Interval(0x000d8, 0x000de),Interval(0x00391, 0x003a1),Interval(0x003a3, 0x003ab),Interval(0x00410, 0x0042f),Interval(0x0ff21, 0x0ff3a),])),
CommonCaseEntry(-32, Charset([Interval(0x00061, 0x0007a),Interval(0x000e0, 0x000f6),Interval(0x000f8, 0x000fe),Interval(0x003b1, 0x003c1),Interval(0x003c3, 0x003cb),Interval(0x00430, 0x0044f),Interval(0x0ff41, 0x0ff5a),])),
CommonCaseEntry(37, Charset([Interval(0x00388, 0x0038a),])),
CommonCaseEntry(-37, Charset([Interval(0x003ad, 0x003af),])),
CommonCaseEntry(40, Charset([Interval(0x10400, 0x10427),])),
CommonCaseEntry(-40, Charset([Interval(0x10428, 0x1044f),])),
CommonCaseEntry(48, Charset([Interval(0x00531, 0x00556),Interval(0x02c00, 0x02c11),])),
CommonCaseEntry(-48, Charset([Interval(0x00561, 0x00586),Interval(0x02c30, 0x02c41),])),
CommonCaseEntry(63, Charset([Interval(0x0038e, 0x0038f),])),
CommonCaseEntry(-63, Charset([Interval(0x003cd, 0x003ce),])),
CommonCaseEntry(74, Charset([Interval(0x01f70, 0x01f71),])),
CommonCaseEntry(-74, Charset([Interval(0x01fba, 0x01fbb),])),
CommonCaseEntry(80, Charset([Interval(0x00400, 0x0040f),])),
CommonCaseEntry(-80, Charset([Interval(0x00450, 0x0045f),])),
CommonCaseEntry(86, Charset([Interval(0x01f72, 0x01f75),])),
CommonCaseEntry(-86, Charset([Interval(0x01fc8, 0x01fcb),])),
CommonCaseEntry(100, Charset([Interval(0x01f76, 0x01f77),])),
CommonCaseEntry(-100, Charset([Interval(0x01fda, 0x01fdb),])),
CommonCaseEntry(112, Charset([Interval(0x01f7a, 0x01f7b),])),
CommonCaseEntry(-112, Charset([Interval(0x01fea, 0x01feb),])),
CommonCaseEntry(126, Charset([Interval(0x01f7c, 0x01f7d),])),
CommonCaseEntry(-126, Charset([Interval(0x01ffa, 0x01ffb),])),
CommonCaseEntry(128, Charset([Interval(0x01f78, 0x01f79),])),
CommonCaseEntry(-128, Charset([Interval(0x01ff8, 0x01ff9),])),
CommonCaseEntry(130, Charset([Interval(0x0037b, 0x0037d),])),
CommonCaseEntry(-130, Charset([Interval(0x003fd, 0x003ff),])),
CommonCaseEntry(205, Charset([Interval(0x00189, 0x0018a),])),
CommonCaseEntry(-205, Charset([Interval(0x00256, 0x00257),])),
CommonCaseEntry(217, Charset([Interval(0x001b1, 0x001b2),])),
CommonCaseEntry(-217, Charset([Interval(0x0028a, 0x0028b),])),
CommonCaseEntry(7264, Charset([Interval(0x010a0, 0x010b7),])),
CommonCaseEntry(-7264, Charset([Interval(0x02d00, 0x02d17),])),
CommonCaseEntry(10815, Charset([Interval(0x0023f, 0x00240),])),
CommonCaseEntry(-10815, Charset([Interval(0x02c7e, 0x02c7f),])),
];

//horrible irregularities are stockpiled here as equivalent pairs (note  it's not a 1:1 mapping, more like n:m)
immutable(uint)[] casePairs = [
0x0006b, 0x0212a,
0x00073, 0x0017f,
0x000b5, 0x003bc,
0x000df, 0x01e9e,
0x000e5, 0x0212b,
0x000ff, 0x00178,
0x00180, 0x00243,
0x00181, 0x00253,
0x00186, 0x00254,
0x0018e, 0x001dd,
0x0018f, 0x00259,
0x00190, 0x0025b,
0x00193, 0x00260,
0x00194, 0x00263,
0x00195, 0x001f6,
0x00196, 0x00269,
0x00197, 0x00268,
0x0019a, 0x0023d,
0x0019c, 0x0026f,
0x0019d, 0x00272,
0x0019e, 0x00220,
0x0019f, 0x00275,
0x001a6, 0x00280,
0x001a9, 0x00283,
0x001ae, 0x00288,
0x001b7, 0x00292,
0x001bf, 0x001f7,
0x001c4, 0x001c6,
0x001c7, 0x001c9,
0x001ca, 0x001cc,
0x001f1, 0x001f3,
0x0023a, 0x02c65,
0x0023e, 0x02c66,
0x00244, 0x00289,
0x00245, 0x0028c,
0x00250, 0x02c6f,
0x00251, 0x02c6d,
0x00252, 0x02c70,
0x00265, 0x0a78d,
0x0026b, 0x02c62,
0x00271, 0x02c6e,
0x0027d, 0x02c64,
0x00345, 0x003b9,
0x00386, 0x003ac,
0x0038c, 0x003cc,
0x003b2, 0x003d0,
0x003b5, 0x003f5,
0x003b8, 0x003f4,
0x003b8, 0x003d1,
0x003b9, 0x01fbe,
0x003ba, 0x003f0,
0x003c0, 0x003d6,
0x003c1, 0x003f1,
0x003c6, 0x003d5,
0x003c9, 0x02126,
0x003cf, 0x003d7,
0x003f2, 0x003f9,
0x004c0, 0x004cf,
0x01d79, 0x0a77d,
0x01d7d, 0x02c63,
0x01e61, 0x01e9b,
0x01f51, 0x01f59,
0x01f53, 0x01f5b,
0x01f55, 0x01f5d,
0x01f57, 0x01f5f,
0x01fb3, 0x01fbc,
0x01fc3, 0x01fcc,
0x01fe0, 0x01fe8,
0x01fe1, 0x01fe9,
0x01fe5, 0x01fec,
0x01ff3, 0x01ffc,
0x02132, 0x0214e,
];
struct UnicodeProperty
{
    string name;
    immutable Charset set;
}
immutable(Charset) unicodeInCombining_Diacritical_Marks_Supplement = Charset([
    Interval(0x01dc0,0x01dff),
]);

immutable(Charset) unicodeInCJK_Radicals_Supplement = Charset([
    Interval(0x02e80,0x02eff),
]);

immutable(Charset) unicodeInEthiopic_Supplement = Charset([
    Interval(0x01380,0x0139f),
]);

immutable(Charset) unicodeInPhags_pa = Charset([
    Interval(0x0a840,0x0a87f),
]);

immutable(Charset) unicodeInSyriac = Charset([
    Interval(0x00700,0x0074f),
]);

immutable(Charset) unicodeInGujarati = Charset([
    Interval(0x00a80,0x00aff),
]);

immutable(Charset) unicodeOther_ID_Start = Charset([
    Interval(0x02118,0x02118),
    Interval(0x0212e,0x0212e),
    Interval(0x0309b,0x0309c),
]);

immutable(Charset) unicodeInKharoshthi = Charset([
    Interval(0x10a00,0x10a5f),
]);

immutable(Charset) unicodeInHangul_Jamo = Charset([
    Interval(0x01100,0x011ff),
]);

immutable(Charset) unicodeRunic = Charset([
    Interval(0x016a0,0x016ea),
    Interval(0x016ee,0x016f0),
]);

immutable(Charset) unicodeInKayah_Li = Charset([
    Interval(0x0a900,0x0a92f),
]);

immutable(Charset) unicodeOther_Default_Ignorable_Code_Point = Charset([
    Interval(0x0034f,0x0034f),
    Interval(0x0115f,0x01160),
    Interval(0x02065,0x02069),
    Interval(0x03164,0x03164),
    Interval(0x0ffa0,0x0ffa0),
    Interval(0x0fff0,0x0fff8),
    Interval(0xe0000,0xe0000),
    Interval(0xe0002,0xe001f),
    Interval(0xe0080,0xe00ff),
    Interval(0xe01f0,0xe0fff),
]);

immutable(Charset) unicodeOld_Turkic = Charset([
    Interval(0x10c00,0x10c48),
]);

immutable(Charset) unicodeInLydian = Charset([
    Interval(0x10920,0x1093f),
]);

immutable(Charset) unicodeIDS_Binary_Operator = Charset([
    Interval(0x02ff0,0x02ff1),
    Interval(0x02ff4,0x02ffb),
]);

immutable(Charset) unicodeTai_Tham = Charset([
    Interval(0x01a20,0x01a5e),
    Interval(0x01a60,0x01a7c),
    Interval(0x01a7f,0x01a89),
    Interval(0x01a90,0x01a99),
    Interval(0x01aa0,0x01aad),
]);

immutable(Charset) unicodeLinear_B = Charset([
    Interval(0x10000,0x1000b),
    Interval(0x1000d,0x10026),
    Interval(0x10028,0x1003a),
    Interval(0x1003c,0x1003d),
    Interval(0x1003f,0x1004d),
    Interval(0x10050,0x1005d),
    Interval(0x10080,0x100fa),
]);

immutable(Charset) unicodeInSupplemental_Arrows_A = Charset([
    Interval(0x027f0,0x027ff),
]);

immutable(Charset) unicodeInMathematical_Alphanumeric_Symbols = Charset([
    Interval(0x1d400,0x1d7ff),
]);

immutable(Charset) unicodeArmenian = Charset([
    Interval(0x00531,0x00556),
    Interval(0x00559,0x0055f),
    Interval(0x00561,0x00587),
    Interval(0x0058a,0x0058a),
    Interval(0x0fb13,0x0fb17),
]);

immutable(Charset) unicodeInBlock_Elements = Charset([
    Interval(0x02580,0x0259f),
]);

immutable(Charset) unicodeInSupplemental_Arrows_B = Charset([
    Interval(0x02900,0x0297f),
]);

immutable(Charset) unicodeInBalinese = Charset([
    Interval(0x01b00,0x01b7f),
]);

immutable(Charset) unicodeCyrillic = Charset([
    Interval(0x00400,0x00484),
    Interval(0x00487,0x00527),
    Interval(0x01d2b,0x01d2b),
    Interval(0x01d78,0x01d78),
    Interval(0x02de0,0x02dff),
    Interval(0x0a640,0x0a673),
    Interval(0x0a67c,0x0a697),
]);

immutable(Charset) unicodeInBamum_Supplement = Charset([
    Interval(0x16800,0x16a3f),
]);

immutable(Charset) unicodeWhite_Space = Charset([
    Interval(0x00009,0x0000d),
    Interval(0x00020,0x00020),
    Interval(0x00085,0x00085),
    Interval(0x000a0,0x000a0),
    Interval(0x01680,0x01680),
    Interval(0x0180e,0x0180e),
    Interval(0x02000,0x0200a),
    Interval(0x02028,0x02029),
    Interval(0x0202f,0x0202f),
    Interval(0x0205f,0x0205f),
    Interval(0x03000,0x03000),
]);

immutable(Charset) unicodeBatak = Charset([
    Interval(0x01bc0,0x01bf3),
    Interval(0x01bfc,0x01bff),
]);

immutable(Charset) unicodeDeprecated = Charset([
    Interval(0x00149,0x00149),
    Interval(0x00673,0x00673),
    Interval(0x00f77,0x00f77),
    Interval(0x00f79,0x00f79),
    Interval(0x017a3,0x017a4),
    Interval(0x0206a,0x0206f),
    Interval(0x02329,0x0232a),
    Interval(0xe0001,0xe0001),
    Interval(0xe0020,0xe007f),
]);

immutable(Charset) unicodeInUnified_Canadian_Aboriginal_Syllabics_Extended = Charset([
    Interval(0x018b0,0x018ff),
]);

immutable(Charset) unicodeCherokee = Charset([
    Interval(0x013a0,0x013f4),
]);

immutable(Charset) unicodeInInscriptional_Parthian = Charset([
    Interval(0x10b40,0x10b5f),
]);

immutable(Charset) unicodeHiragana = Charset([
    Interval(0x03041,0x03096),
    Interval(0x0309d,0x0309f),
    Interval(0x1b001,0x1b001),
    Interval(0x1f200,0x1f200),
]);

immutable(Charset) unicodeInCJK_Compatibility_Ideographs = Charset([
    Interval(0x0f900,0x0faff),
]);

immutable(Charset) unicodeInAncient_Symbols = Charset([
    Interval(0x10190,0x101cf),
]);

immutable(Charset) unicodeInOld_South_Arabian = Charset([
    Interval(0x10a60,0x10a7f),
]);

immutable(Charset) unicodePattern_Syntax = Charset([
    Interval(0x00021,0x0002f),
    Interval(0x0003a,0x00040),
    Interval(0x0005b,0x0005e),
    Interval(0x00060,0x00060),
    Interval(0x0007b,0x0007e),
    Interval(0x000a1,0x000a7),
    Interval(0x000a9,0x000a9),
    Interval(0x000ab,0x000ac),
    Interval(0x000ae,0x000ae),
    Interval(0x000b0,0x000b1),
    Interval(0x000b6,0x000b6),
    Interval(0x000bb,0x000bb),
    Interval(0x000bf,0x000bf),
    Interval(0x000d7,0x000d7),
    Interval(0x000f7,0x000f7),
    Interval(0x02010,0x02027),
    Interval(0x02030,0x0203e),
    Interval(0x02041,0x02053),
    Interval(0x02055,0x0205e),
    Interval(0x02190,0x0245f),
    Interval(0x02500,0x02775),
    Interval(0x02794,0x02bff),
    Interval(0x02e00,0x02e7f),
    Interval(0x03001,0x03003),
    Interval(0x03008,0x03020),
    Interval(0x03030,0x03030),
    Interval(0x0fd3e,0x0fd3f),
    Interval(0x0fe45,0x0fe46),
]);

immutable(Charset) unicodeNew_Tai_Lue = Charset([
    Interval(0x01980,0x019ab),
    Interval(0x019b0,0x019c9),
    Interval(0x019d0,0x019da),
    Interval(0x019de,0x019df),
]);

immutable(Charset) unicodeASCII_Hex_Digit = Charset([
    Interval(0x00030,0x00039),
    Interval(0x00041,0x00046),
    Interval(0x00061,0x00066),
]);

immutable(Charset) unicodeArabic = Charset([
    Interval(0x00600,0x00603),
    Interval(0x00606,0x0060b),
    Interval(0x0060d,0x0061a),
    Interval(0x0061e,0x0061e),
    Interval(0x00620,0x0063f),
    Interval(0x00641,0x0064a),
    Interval(0x00656,0x0065e),
    Interval(0x0066a,0x0066f),
    Interval(0x00671,0x006dc),
    Interval(0x006de,0x006ff),
    Interval(0x00750,0x0077f),
    Interval(0x0fb50,0x0fbc1),
    Interval(0x0fbd3,0x0fd3d),
    Interval(0x0fd50,0x0fd8f),
    Interval(0x0fd92,0x0fdc7),
    Interval(0x0fdf0,0x0fdfc),
    Interval(0x0fe70,0x0fe74),
    Interval(0x0fe76,0x0fefc),
    Interval(0x10e60,0x10e7e),
]);

immutable(Charset) unicodeInCuneiform_Numbers_and_Punctuation = Charset([
    Interval(0x12400,0x1247f),
]);

immutable(Charset) unicodeBrahmi = Charset([
    Interval(0x11000,0x1104d),
    Interval(0x11052,0x1106f),
]);

immutable(Charset) unicodeInControl_Pictures = Charset([
    Interval(0x02400,0x0243f),
]);

immutable(Charset) unicodeOther_ID_Continue = Charset([
    Interval(0x000b7,0x000b7),
    Interval(0x00387,0x00387),
    Interval(0x01369,0x01371),
    Interval(0x019da,0x019da),
]);

immutable(Charset) unicodeInOl_Chiki = Charset([
    Interval(0x01c50,0x01c7f),
]);

immutable(Charset) unicodeInArmenian = Charset([
    Interval(0x00530,0x0058f),
]);

immutable(Charset) unicodeInCyrillic = Charset([
    Interval(0x00400,0x004ff),
]);

immutable(Charset) unicodeInNew_Tai_Lue = Charset([
    Interval(0x01980,0x019df),
]);

immutable(Charset) unicodeInHigh_Surrogates = Charset([
    Interval(0x0d800,0x0db7f),
]);

immutable(Charset) unicodeInHigh_Private_Use_Surrogates = Charset([
    Interval(0x0db80,0x0dbff),
]);

immutable(Charset) unicodeInAncient_Greek_Numbers = Charset([
    Interval(0x10140,0x1018f),
]);

immutable(Charset) unicodeQuotation_Mark = Charset([
    Interval(0x00022,0x00022),
    Interval(0x00027,0x00027),
    Interval(0x000ab,0x000ab),
    Interval(0x000bb,0x000bb),
    Interval(0x02018,0x0201f),
    Interval(0x02039,0x0203a),
    Interval(0x0300c,0x0300f),
    Interval(0x0301d,0x0301f),
    Interval(0x0fe41,0x0fe44),
    Interval(0x0ff02,0x0ff02),
    Interval(0x0ff07,0x0ff07),
    Interval(0x0ff62,0x0ff63),
]);

immutable(Charset) unicodeTai_Le = Charset([
    Interval(0x01950,0x0196d),
    Interval(0x01970,0x01974),
]);

immutable(Charset) unicodeCc = Charset([
    Interval(0x00000,0x0001f),
    Interval(0x0007f,0x0009f),
]);

immutable(Charset) unicodeInCherokee = Charset([
    Interval(0x013a0,0x013ff),
]);

immutable(Charset) unicodeCoptic = Charset([
    Interval(0x003e2,0x003ef),
    Interval(0x02c80,0x02cf1),
    Interval(0x02cf9,0x02cff),
]);

immutable(Charset) unicodeInCyrillic_Supplement = Charset([
    Interval(0x00500,0x0052f),
]);

immutable(Charset) unicodeCf = Charset([
    Interval(0x000ad,0x000ad),
    Interval(0x00600,0x00603),
    Interval(0x006dd,0x006dd),
    Interval(0x0070f,0x0070f),
    Interval(0x017b4,0x017b5),
    Interval(0x0200b,0x0200f),
    Interval(0x0202a,0x0202e),
    Interval(0x02060,0x02064),
    Interval(0x0206a,0x0206f),
    Interval(0x0feff,0x0feff),
    Interval(0x0fff9,0x0fffb),
    Interval(0x110bd,0x110bd),
    Interval(0x1d173,0x1d17a),
    Interval(0xe0001,0xe0001),
    Interval(0xe0020,0xe007f),
]);

immutable(Charset) unicodeGothic = Charset([
    Interval(0x10330,0x1034a),
]);

immutable(Charset) unicodeInHiragana = Charset([
    Interval(0x03040,0x0309f),
]);

immutable(Charset) unicodeInIPA_Extensions = Charset([
    Interval(0x00250,0x002af),
]);

immutable(Charset) unicodeOgham = Charset([
    Interval(0x01680,0x0169c),
]);

immutable(Charset) unicodeInCJK_Compatibility_Forms = Charset([
    Interval(0x0fe30,0x0fe4f),
]);

immutable(Charset) unicodeInShavian = Charset([
    Interval(0x10450,0x1047f),
]);

immutable(Charset) unicodeCn = Charset([
    Interval(0x00378,0x00379),
    Interval(0x0037f,0x00383),
    Interval(0x0038b,0x0038b),
    Interval(0x0038d,0x0038d),
    Interval(0x003a2,0x003a2),
    Interval(0x00528,0x00530),
    Interval(0x00557,0x00558),
    Interval(0x00560,0x00560),
    Interval(0x00588,0x00588),
    Interval(0x0058b,0x00590),
    Interval(0x005c8,0x005cf),
    Interval(0x005eb,0x005ef),
    Interval(0x005f5,0x005ff),
    Interval(0x00604,0x00605),
    Interval(0x0061c,0x0061d),
    Interval(0x0070e,0x0070e),
    Interval(0x0074b,0x0074c),
    Interval(0x007b2,0x007bf),
    Interval(0x007fb,0x007ff),
    Interval(0x0082e,0x0082f),
    Interval(0x0083f,0x0083f),
    Interval(0x0085c,0x0085d),
    Interval(0x0085f,0x008ff),
    Interval(0x00978,0x00978),
    Interval(0x00980,0x00980),
    Interval(0x00984,0x00984),
    Interval(0x0098d,0x0098e),
    Interval(0x00991,0x00992),
    Interval(0x009a9,0x009a9),
    Interval(0x009b1,0x009b1),
    Interval(0x009b3,0x009b5),
    Interval(0x009ba,0x009bb),
    Interval(0x009c5,0x009c6),
    Interval(0x009c9,0x009ca),
    Interval(0x009cf,0x009d6),
    Interval(0x009d8,0x009db),
    Interval(0x009de,0x009de),
    Interval(0x009e4,0x009e5),
    Interval(0x009fc,0x00a00),
    Interval(0x00a04,0x00a04),
    Interval(0x00a0b,0x00a0e),
    Interval(0x00a11,0x00a12),
    Interval(0x00a29,0x00a29),
    Interval(0x00a31,0x00a31),
    Interval(0x00a34,0x00a34),
    Interval(0x00a37,0x00a37),
    Interval(0x00a3a,0x00a3b),
    Interval(0x00a3d,0x00a3d),
    Interval(0x00a43,0x00a46),
    Interval(0x00a49,0x00a4a),
    Interval(0x00a4e,0x00a50),
    Interval(0x00a52,0x00a58),
    Interval(0x00a5d,0x00a5d),
    Interval(0x00a5f,0x00a65),
    Interval(0x00a76,0x00a80),
    Interval(0x00a84,0x00a84),
    Interval(0x00a8e,0x00a8e),
    Interval(0x00a92,0x00a92),
    Interval(0x00aa9,0x00aa9),
    Interval(0x00ab1,0x00ab1),
    Interval(0x00ab4,0x00ab4),
    Interval(0x00aba,0x00abb),
    Interval(0x00ac6,0x00ac6),
    Interval(0x00aca,0x00aca),
    Interval(0x00ace,0x00acf),
    Interval(0x00ad1,0x00adf),
    Interval(0x00ae4,0x00ae5),
    Interval(0x00af0,0x00af0),
    Interval(0x00af2,0x00b00),
    Interval(0x00b04,0x00b04),
    Interval(0x00b0d,0x00b0e),
    Interval(0x00b11,0x00b12),
    Interval(0x00b29,0x00b29),
    Interval(0x00b31,0x00b31),
    Interval(0x00b34,0x00b34),
    Interval(0x00b3a,0x00b3b),
    Interval(0x00b45,0x00b46),
    Interval(0x00b49,0x00b4a),
    Interval(0x00b4e,0x00b55),
    Interval(0x00b58,0x00b5b),
    Interval(0x00b5e,0x00b5e),
    Interval(0x00b64,0x00b65),
    Interval(0x00b78,0x00b81),
    Interval(0x00b84,0x00b84),
    Interval(0x00b8b,0x00b8d),
    Interval(0x00b91,0x00b91),
    Interval(0x00b96,0x00b98),
    Interval(0x00b9b,0x00b9b),
    Interval(0x00b9d,0x00b9d),
    Interval(0x00ba0,0x00ba2),
    Interval(0x00ba5,0x00ba7),
    Interval(0x00bab,0x00bad),
    Interval(0x00bba,0x00bbd),
    Interval(0x00bc3,0x00bc5),
    Interval(0x00bc9,0x00bc9),
    Interval(0x00bce,0x00bcf),
    Interval(0x00bd1,0x00bd6),
    Interval(0x00bd8,0x00be5),
    Interval(0x00bfb,0x00c00),
    Interval(0x00c04,0x00c04),
    Interval(0x00c0d,0x00c0d),
    Interval(0x00c11,0x00c11),
    Interval(0x00c29,0x00c29),
    Interval(0x00c34,0x00c34),
    Interval(0x00c3a,0x00c3c),
    Interval(0x00c45,0x00c45),
    Interval(0x00c49,0x00c49),
    Interval(0x00c4e,0x00c54),
    Interval(0x00c57,0x00c57),
    Interval(0x00c5a,0x00c5f),
    Interval(0x00c64,0x00c65),
    Interval(0x00c70,0x00c77),
    Interval(0x00c80,0x00c81),
    Interval(0x00c84,0x00c84),
    Interval(0x00c8d,0x00c8d),
    Interval(0x00c91,0x00c91),
    Interval(0x00ca9,0x00ca9),
    Interval(0x00cb4,0x00cb4),
    Interval(0x00cba,0x00cbb),
    Interval(0x00cc5,0x00cc5),
    Interval(0x00cc9,0x00cc9),
    Interval(0x00cce,0x00cd4),
    Interval(0x00cd7,0x00cdd),
    Interval(0x00cdf,0x00cdf),
    Interval(0x00ce4,0x00ce5),
    Interval(0x00cf0,0x00cf0),
    Interval(0x00cf3,0x00d01),
    Interval(0x00d04,0x00d04),
    Interval(0x00d0d,0x00d0d),
    Interval(0x00d11,0x00d11),
    Interval(0x00d3b,0x00d3c),
    Interval(0x00d45,0x00d45),
    Interval(0x00d49,0x00d49),
    Interval(0x00d4f,0x00d56),
    Interval(0x00d58,0x00d5f),
    Interval(0x00d64,0x00d65),
    Interval(0x00d76,0x00d78),
    Interval(0x00d80,0x00d81),
    Interval(0x00d84,0x00d84),
    Interval(0x00d97,0x00d99),
    Interval(0x00db2,0x00db2),
    Interval(0x00dbc,0x00dbc),
    Interval(0x00dbe,0x00dbf),
    Interval(0x00dc7,0x00dc9),
    Interval(0x00dcb,0x00dce),
    Interval(0x00dd5,0x00dd5),
    Interval(0x00dd7,0x00dd7),
    Interval(0x00de0,0x00df1),
    Interval(0x00df5,0x00e00),
    Interval(0x00e3b,0x00e3e),
    Interval(0x00e5c,0x00e80),
    Interval(0x00e83,0x00e83),
    Interval(0x00e85,0x00e86),
    Interval(0x00e89,0x00e89),
    Interval(0x00e8b,0x00e8c),
    Interval(0x00e8e,0x00e93),
    Interval(0x00e98,0x00e98),
    Interval(0x00ea0,0x00ea0),
    Interval(0x00ea4,0x00ea4),
    Interval(0x00ea6,0x00ea6),
    Interval(0x00ea8,0x00ea9),
    Interval(0x00eac,0x00eac),
    Interval(0x00eba,0x00eba),
    Interval(0x00ebe,0x00ebf),
    Interval(0x00ec5,0x00ec5),
    Interval(0x00ec7,0x00ec7),
    Interval(0x00ece,0x00ecf),
    Interval(0x00eda,0x00edb),
    Interval(0x00ede,0x00eff),
    Interval(0x00f48,0x00f48),
    Interval(0x00f6d,0x00f70),
    Interval(0x00f98,0x00f98),
    Interval(0x00fbd,0x00fbd),
    Interval(0x00fcd,0x00fcd),
    Interval(0x00fdb,0x00fff),
    Interval(0x010c6,0x010cf),
    Interval(0x010fd,0x010ff),
    Interval(0x01249,0x01249),
    Interval(0x0124e,0x0124f),
    Interval(0x01257,0x01257),
    Interval(0x01259,0x01259),
    Interval(0x0125e,0x0125f),
    Interval(0x01289,0x01289),
    Interval(0x0128e,0x0128f),
    Interval(0x012b1,0x012b1),
    Interval(0x012b6,0x012b7),
    Interval(0x012bf,0x012bf),
    Interval(0x012c1,0x012c1),
    Interval(0x012c6,0x012c7),
    Interval(0x012d7,0x012d7),
    Interval(0x01311,0x01311),
    Interval(0x01316,0x01317),
    Interval(0x0135b,0x0135c),
    Interval(0x0137d,0x0137f),
    Interval(0x0139a,0x0139f),
    Interval(0x013f5,0x013ff),
    Interval(0x0169d,0x0169f),
    Interval(0x016f1,0x016ff),
    Interval(0x0170d,0x0170d),
    Interval(0x01715,0x0171f),
    Interval(0x01737,0x0173f),
    Interval(0x01754,0x0175f),
    Interval(0x0176d,0x0176d),
    Interval(0x01771,0x01771),
    Interval(0x01774,0x0177f),
    Interval(0x017de,0x017df),
    Interval(0x017ea,0x017ef),
    Interval(0x017fa,0x017ff),
    Interval(0x0180f,0x0180f),
    Interval(0x0181a,0x0181f),
    Interval(0x01878,0x0187f),
    Interval(0x018ab,0x018af),
    Interval(0x018f6,0x018ff),
    Interval(0x0191d,0x0191f),
    Interval(0x0192c,0x0192f),
    Interval(0x0193c,0x0193f),
    Interval(0x01941,0x01943),
    Interval(0x0196e,0x0196f),
    Interval(0x01975,0x0197f),
    Interval(0x019ac,0x019af),
    Interval(0x019ca,0x019cf),
    Interval(0x019db,0x019dd),
    Interval(0x01a1c,0x01a1d),
    Interval(0x01a5f,0x01a5f),
    Interval(0x01a7d,0x01a7e),
    Interval(0x01a8a,0x01a8f),
    Interval(0x01a9a,0x01a9f),
    Interval(0x01aae,0x01aff),
    Interval(0x01b4c,0x01b4f),
    Interval(0x01b7d,0x01b7f),
    Interval(0x01bab,0x01bad),
    Interval(0x01bba,0x01bbf),
    Interval(0x01bf4,0x01bfb),
    Interval(0x01c38,0x01c3a),
    Interval(0x01c4a,0x01c4c),
    Interval(0x01c80,0x01ccf),
    Interval(0x01cf3,0x01cff),
    Interval(0x01de7,0x01dfb),
    Interval(0x01f16,0x01f17),
    Interval(0x01f1e,0x01f1f),
    Interval(0x01f46,0x01f47),
    Interval(0x01f4e,0x01f4f),
    Interval(0x01f58,0x01f58),
    Interval(0x01f5a,0x01f5a),
    Interval(0x01f5c,0x01f5c),
    Interval(0x01f5e,0x01f5e),
    Interval(0x01f7e,0x01f7f),
    Interval(0x01fb5,0x01fb5),
    Interval(0x01fc5,0x01fc5),
    Interval(0x01fd4,0x01fd5),
    Interval(0x01fdc,0x01fdc),
    Interval(0x01ff0,0x01ff1),
    Interval(0x01ff5,0x01ff5),
    Interval(0x01fff,0x01fff),
    Interval(0x02065,0x02069),
    Interval(0x02072,0x02073),
    Interval(0x0208f,0x0208f),
    Interval(0x0209d,0x0209f),
    Interval(0x020ba,0x020cf),
    Interval(0x020f1,0x020ff),
    Interval(0x0218a,0x0218f),
    Interval(0x023f4,0x023ff),
    Interval(0x02427,0x0243f),
    Interval(0x0244b,0x0245f),
    Interval(0x02700,0x02700),
    Interval(0x027cb,0x027cb),
    Interval(0x027cd,0x027cd),
    Interval(0x02b4d,0x02b4f),
    Interval(0x02b5a,0x02bff),
    Interval(0x02c2f,0x02c2f),
    Interval(0x02c5f,0x02c5f),
    Interval(0x02cf2,0x02cf8),
    Interval(0x02d26,0x02d2f),
    Interval(0x02d66,0x02d6e),
    Interval(0x02d71,0x02d7e),
    Interval(0x02d97,0x02d9f),
    Interval(0x02da7,0x02da7),
    Interval(0x02daf,0x02daf),
    Interval(0x02db7,0x02db7),
    Interval(0x02dbf,0x02dbf),
    Interval(0x02dc7,0x02dc7),
    Interval(0x02dcf,0x02dcf),
    Interval(0x02dd7,0x02dd7),
    Interval(0x02ddf,0x02ddf),
    Interval(0x02e32,0x02e7f),
    Interval(0x02e9a,0x02e9a),
    Interval(0x02ef4,0x02eff),
    Interval(0x02fd6,0x02fef),
    Interval(0x02ffc,0x02fff),
    Interval(0x03040,0x03040),
    Interval(0x03097,0x03098),
    Interval(0x03100,0x03104),
    Interval(0x0312e,0x03130),
    Interval(0x0318f,0x0318f),
    Interval(0x031bb,0x031bf),
    Interval(0x031e4,0x031ef),
    Interval(0x0321f,0x0321f),
    Interval(0x032ff,0x032ff),
    Interval(0x04db6,0x04dbf),
    Interval(0x09fcc,0x09fff),
    Interval(0x0a48d,0x0a48f),
    Interval(0x0a4c7,0x0a4cf),
    Interval(0x0a62c,0x0a63f),
    Interval(0x0a674,0x0a67b),
    Interval(0x0a698,0x0a69f),
    Interval(0x0a6f8,0x0a6ff),
    Interval(0x0a78f,0x0a78f),
    Interval(0x0a792,0x0a79f),
    Interval(0x0a7aa,0x0a7f9),
    Interval(0x0a82c,0x0a82f),
    Interval(0x0a83a,0x0a83f),
    Interval(0x0a878,0x0a87f),
    Interval(0x0a8c5,0x0a8cd),
    Interval(0x0a8da,0x0a8df),
    Interval(0x0a8fc,0x0a8ff),
    Interval(0x0a954,0x0a95e),
    Interval(0x0a97d,0x0a97f),
    Interval(0x0a9ce,0x0a9ce),
    Interval(0x0a9da,0x0a9dd),
    Interval(0x0a9e0,0x0a9ff),
    Interval(0x0aa37,0x0aa3f),
    Interval(0x0aa4e,0x0aa4f),
    Interval(0x0aa5a,0x0aa5b),
    Interval(0x0aa7c,0x0aa7f),
    Interval(0x0aac3,0x0aada),
    Interval(0x0aae0,0x0ab00),
    Interval(0x0ab07,0x0ab08),
    Interval(0x0ab0f,0x0ab10),
    Interval(0x0ab17,0x0ab1f),
    Interval(0x0ab27,0x0ab27),
    Interval(0x0ab2f,0x0abbf),
    Interval(0x0abee,0x0abef),
    Interval(0x0abfa,0x0abff),
    Interval(0x0d7a4,0x0d7af),
    Interval(0x0d7c7,0x0d7ca),
    Interval(0x0d7fc,0x0d7ff),
    Interval(0x0fa2e,0x0fa2f),
    Interval(0x0fa6e,0x0fa6f),
    Interval(0x0fada,0x0faff),
    Interval(0x0fb07,0x0fb12),
    Interval(0x0fb18,0x0fb1c),
    Interval(0x0fb37,0x0fb37),
    Interval(0x0fb3d,0x0fb3d),
    Interval(0x0fb3f,0x0fb3f),
    Interval(0x0fb42,0x0fb42),
    Interval(0x0fb45,0x0fb45),
    Interval(0x0fbc2,0x0fbd2),
    Interval(0x0fd40,0x0fd4f),
    Interval(0x0fd90,0x0fd91),
    Interval(0x0fdc8,0x0fdef),
    Interval(0x0fdfe,0x0fdff),
    Interval(0x0fe1a,0x0fe1f),
    Interval(0x0fe27,0x0fe2f),
    Interval(0x0fe53,0x0fe53),
    Interval(0x0fe67,0x0fe67),
    Interval(0x0fe6c,0x0fe6f),
    Interval(0x0fe75,0x0fe75),
    Interval(0x0fefd,0x0fefe),
    Interval(0x0ff00,0x0ff00),
    Interval(0x0ffbf,0x0ffc1),
    Interval(0x0ffc8,0x0ffc9),
    Interval(0x0ffd0,0x0ffd1),
    Interval(0x0ffd8,0x0ffd9),
    Interval(0x0ffdd,0x0ffdf),
    Interval(0x0ffe7,0x0ffe7),
    Interval(0x0ffef,0x0fff8),
    Interval(0x0fffe,0x0ffff),
    Interval(0x1000c,0x1000c),
    Interval(0x10027,0x10027),
    Interval(0x1003b,0x1003b),
    Interval(0x1003e,0x1003e),
    Interval(0x1004e,0x1004f),
    Interval(0x1005e,0x1007f),
    Interval(0x100fb,0x100ff),
    Interval(0x10103,0x10106),
    Interval(0x10134,0x10136),
    Interval(0x1018b,0x1018f),
    Interval(0x1019c,0x101cf),
    Interval(0x101fe,0x1027f),
    Interval(0x1029d,0x1029f),
    Interval(0x102d1,0x102ff),
    Interval(0x1031f,0x1031f),
    Interval(0x10324,0x1032f),
    Interval(0x1034b,0x1037f),
    Interval(0x1039e,0x1039e),
    Interval(0x103c4,0x103c7),
    Interval(0x103d6,0x103ff),
    Interval(0x1049e,0x1049f),
    Interval(0x104aa,0x107ff),
    Interval(0x10806,0x10807),
    Interval(0x10809,0x10809),
    Interval(0x10836,0x10836),
    Interval(0x10839,0x1083b),
    Interval(0x1083d,0x1083e),
    Interval(0x10856,0x10856),
    Interval(0x10860,0x108ff),
    Interval(0x1091c,0x1091e),
    Interval(0x1093a,0x1093e),
    Interval(0x10940,0x109ff),
    Interval(0x10a04,0x10a04),
    Interval(0x10a07,0x10a0b),
    Interval(0x10a14,0x10a14),
    Interval(0x10a18,0x10a18),
    Interval(0x10a34,0x10a37),
    Interval(0x10a3b,0x10a3e),
    Interval(0x10a48,0x10a4f),
    Interval(0x10a59,0x10a5f),
    Interval(0x10a80,0x10aff),
    Interval(0x10b36,0x10b38),
    Interval(0x10b56,0x10b57),
    Interval(0x10b73,0x10b77),
    Interval(0x10b80,0x10bff),
    Interval(0x10c49,0x10e5f),
    Interval(0x10e7f,0x10fff),
    Interval(0x1104e,0x11051),
    Interval(0x11070,0x1107f),
    Interval(0x110c2,0x11fff),
    Interval(0x1236f,0x123ff),
    Interval(0x12463,0x1246f),
    Interval(0x12474,0x12fff),
    Interval(0x1342f,0x167ff),
    Interval(0x16a39,0x1afff),
    Interval(0x1b002,0x1cfff),
    Interval(0x1d0f6,0x1d0ff),
    Interval(0x1d127,0x1d128),
    Interval(0x1d1de,0x1d1ff),
    Interval(0x1d246,0x1d2ff),
    Interval(0x1d357,0x1d35f),
    Interval(0x1d372,0x1d3ff),
    Interval(0x1d455,0x1d455),
    Interval(0x1d49d,0x1d49d),
    Interval(0x1d4a0,0x1d4a1),
    Interval(0x1d4a3,0x1d4a4),
    Interval(0x1d4a7,0x1d4a8),
    Interval(0x1d4ad,0x1d4ad),
    Interval(0x1d4ba,0x1d4ba),
    Interval(0x1d4bc,0x1d4bc),
    Interval(0x1d4c4,0x1d4c4),
    Interval(0x1d506,0x1d506),
    Interval(0x1d50b,0x1d50c),
    Interval(0x1d515,0x1d515),
    Interval(0x1d51d,0x1d51d),
    Interval(0x1d53a,0x1d53a),
    Interval(0x1d53f,0x1d53f),
    Interval(0x1d545,0x1d545),
    Interval(0x1d547,0x1d549),
    Interval(0x1d551,0x1d551),
    Interval(0x1d6a6,0x1d6a7),
    Interval(0x1d7cc,0x1d7cd),
    Interval(0x1d800,0x1efff),
    Interval(0x1f02c,0x1f02f),
    Interval(0x1f094,0x1f09f),
    Interval(0x1f0af,0x1f0b0),
    Interval(0x1f0bf,0x1f0c0),
    Interval(0x1f0d0,0x1f0d0),
    Interval(0x1f0e0,0x1f0ff),
    Interval(0x1f10b,0x1f10f),
    Interval(0x1f12f,0x1f12f),
    Interval(0x1f16a,0x1f16f),
    Interval(0x1f19b,0x1f1e5),
    Interval(0x1f203,0x1f20f),
    Interval(0x1f23b,0x1f23f),
    Interval(0x1f249,0x1f24f),
    Interval(0x1f252,0x1f2ff),
    Interval(0x1f321,0x1f32f),
    Interval(0x1f336,0x1f336),
    Interval(0x1f37d,0x1f37f),
    Interval(0x1f394,0x1f39f),
    Interval(0x1f3c5,0x1f3c5),
    Interval(0x1f3cb,0x1f3df),
    Interval(0x1f3f1,0x1f3ff),
    Interval(0x1f43f,0x1f43f),
    Interval(0x1f441,0x1f441),
    Interval(0x1f4f8,0x1f4f8),
    Interval(0x1f4fd,0x1f4ff),
    Interval(0x1f53e,0x1f54f),
    Interval(0x1f568,0x1f5fa),
    Interval(0x1f600,0x1f600),
    Interval(0x1f611,0x1f611),
    Interval(0x1f615,0x1f615),
    Interval(0x1f617,0x1f617),
    Interval(0x1f619,0x1f619),
    Interval(0x1f61b,0x1f61b),
    Interval(0x1f61f,0x1f61f),
    Interval(0x1f626,0x1f627),
    Interval(0x1f62c,0x1f62c),
    Interval(0x1f62e,0x1f62f),
    Interval(0x1f634,0x1f634),
    Interval(0x1f641,0x1f644),
    Interval(0x1f650,0x1f67f),
    Interval(0x1f6c6,0x1f6ff),
    Interval(0x1f774,0x1ffff),
    Interval(0x2a6d7,0x2a6ff),
    Interval(0x2b735,0x2b73f),
    Interval(0x2b81e,0x2f7ff),
    Interval(0x2fa1e,0xe0000),
    Interval(0xe0002,0xe001f),
    Interval(0xe0080,0xe00ff),
    Interval(0xe01f0,0xeffff),
    Interval(0xffffe,0xfffff),
    Interval(0x10fffe,0x10ffff),
]);

immutable(Charset) unicodeInPhaistos_Disc = Charset([
    Interval(0x101d0,0x101ff),
]);

immutable(Charset) unicodeCo = Charset([
    Interval(0x0e000,0x0f8ff),
    Interval(0xf0000,0xffffd),
    Interval(0x100000,0x10fffd),
]);

immutable(Charset) unicodeInKana_Supplement = Charset([
    Interval(0x1b000,0x1b0ff),
]);

immutable(Charset) unicodeInLinear_B_Ideograms = Charset([
    Interval(0x10080,0x100ff),
]);

immutable(Charset) unicodeInYi_Syllables = Charset([
    Interval(0x0a000,0x0a48f),
]);

immutable(Charset) unicodeInInscriptional_Pahlavi = Charset([
    Interval(0x10b60,0x10b7f),
]);

immutable(Charset) unicodeCs = Charset([
    Interval(0x0d800,0x0dfff),
]);

immutable(Charset) unicodeInHangul_Jamo_Extended_A = Charset([
    Interval(0x0a960,0x0a97f),
]);

immutable(Charset) unicodeInGlagolitic = Charset([
    Interval(0x02c00,0x02c5f),
]);

immutable(Charset) unicodeInHangul_Jamo_Extended_B = Charset([
    Interval(0x0d7b0,0x0d7ff),
]);

immutable(Charset) unicodeInSpecials = Charset([
    Interval(0x0fff0,0x0ffff),
]);

immutable(Charset) unicodeBopomofo = Charset([
    Interval(0x002ea,0x002eb),
    Interval(0x03105,0x0312d),
    Interval(0x031a0,0x031ba),
]);

immutable(Charset) unicodeInBamum = Charset([
    Interval(0x0a6a0,0x0a6ff),
]);

immutable(Charset) unicodeInPlaying_Cards = Charset([
    Interval(0x1f0a0,0x1f0ff),
]);

immutable(Charset) unicodeInArabic = Charset([
    Interval(0x00600,0x006ff),
]);

immutable(Charset) unicodeVariation_Selector = Charset([
    Interval(0x0180b,0x0180d),
    Interval(0x0fe00,0x0fe0f),
    Interval(0xe0100,0xe01ef),
]);

immutable(Charset) unicodeInMathematical_Operators = Charset([
    Interval(0x02200,0x022ff),
]);

immutable(Charset) unicodeInPhonetic_Extensions_Supplement = Charset([
    Interval(0x01d80,0x01dbf),
]);

immutable(Charset) unicodeInBrahmi = Charset([
    Interval(0x11000,0x1107f),
]);

immutable(Charset) unicodeMalayalam = Charset([
    Interval(0x00d02,0x00d03),
    Interval(0x00d05,0x00d0c),
    Interval(0x00d0e,0x00d10),
    Interval(0x00d12,0x00d3a),
    Interval(0x00d3d,0x00d44),
    Interval(0x00d46,0x00d48),
    Interval(0x00d4a,0x00d4e),
    Interval(0x00d57,0x00d57),
    Interval(0x00d60,0x00d63),
    Interval(0x00d66,0x00d75),
    Interval(0x00d79,0x00d7f),
]);

immutable(Charset) unicodeInCJK_Unified_Ideographs_Extension_A = Charset([
    Interval(0x03400,0x04dbf),
]);

immutable(Charset) unicodeInCJK_Unified_Ideographs_Extension_B = Charset([
    Interval(0x20000,0x2a6df),
]);

immutable(Charset) unicodeInYijing_Hexagram_Symbols = Charset([
    Interval(0x04dc0,0x04dff),
]);

immutable(Charset) unicodeInCJK_Unified_Ideographs_Extension_C = Charset([
    Interval(0x2a700,0x2b73f),
]);

immutable(Charset) unicodeInTibetan = Charset([
    Interval(0x00f00,0x00fff),
]);

immutable(Charset) unicodeInImperial_Aramaic = Charset([
    Interval(0x10840,0x1085f),
]);

immutable(Charset) unicodeInCJK_Unified_Ideographs_Extension_D = Charset([
    Interval(0x2b740,0x2b81f),
]);

immutable(Charset) unicodeInAlchemical_Symbols = Charset([
    Interval(0x1f700,0x1f77f),
]);

immutable(Charset) unicodePattern_White_Space = Charset([
    Interval(0x00009,0x0000d),
    Interval(0x00020,0x00020),
    Interval(0x00085,0x00085),
    Interval(0x0200e,0x0200f),
    Interval(0x02028,0x02029),
]);

immutable(Charset) unicodeInEmoticons = Charset([
    Interval(0x1f600,0x1f64f),
]);

immutable(Charset) unicodeInYi_Radicals = Charset([
    Interval(0x0a490,0x0a4cf),
]);

immutable(Charset) unicodeInBraille_Patterns = Charset([
    Interval(0x02800,0x028ff),
]);

immutable(Charset) unicodeInscriptional_Pahlavi = Charset([
    Interval(0x10b60,0x10b72),
    Interval(0x10b78,0x10b7f),
]);

immutable(Charset) unicodeInCoptic = Charset([
    Interval(0x02c80,0x02cff),
]);

immutable(Charset) unicodeInGothic = Charset([
    Interval(0x10330,0x1034f),
]);

immutable(Charset) unicodeInDevanagari = Charset([
    Interval(0x00900,0x0097f),
]);

immutable(Charset) unicodeSTerm = Charset([
    Interval(0x00021,0x00021),
    Interval(0x0002e,0x0002e),
    Interval(0x0003f,0x0003f),
    Interval(0x0055c,0x0055c),
    Interval(0x0055e,0x0055e),
    Interval(0x00589,0x00589),
    Interval(0x0061f,0x0061f),
    Interval(0x006d4,0x006d4),
    Interval(0x00700,0x00702),
    Interval(0x007f9,0x007f9),
    Interval(0x00964,0x00965),
    Interval(0x0104a,0x0104b),
    Interval(0x01362,0x01362),
    Interval(0x01367,0x01368),
    Interval(0x0166e,0x0166e),
    Interval(0x01735,0x01736),
    Interval(0x01803,0x01803),
    Interval(0x01809,0x01809),
    Interval(0x01944,0x01945),
    Interval(0x01aa8,0x01aab),
    Interval(0x01b5a,0x01b5b),
    Interval(0x01b5e,0x01b5f),
    Interval(0x01c3b,0x01c3c),
    Interval(0x01c7e,0x01c7f),
    Interval(0x0203c,0x0203d),
    Interval(0x02047,0x02049),
    Interval(0x02e2e,0x02e2e),
    Interval(0x03002,0x03002),
    Interval(0x0a4ff,0x0a4ff),
    Interval(0x0a60e,0x0a60f),
    Interval(0x0a6f3,0x0a6f3),
    Interval(0x0a6f7,0x0a6f7),
    Interval(0x0a876,0x0a877),
    Interval(0x0a8ce,0x0a8cf),
    Interval(0x0a92f,0x0a92f),
    Interval(0x0a9c8,0x0a9c9),
    Interval(0x0aa5d,0x0aa5f),
    Interval(0x0abeb,0x0abeb),
    Interval(0x0fe52,0x0fe52),
    Interval(0x0fe56,0x0fe57),
    Interval(0x0ff01,0x0ff01),
    Interval(0x0ff0e,0x0ff0e),
    Interval(0x0ff1f,0x0ff1f),
    Interval(0x0ff61,0x0ff61),
    Interval(0x10a56,0x10a57),
    Interval(0x11047,0x11048),
    Interval(0x110be,0x110c1),
]);

immutable(Charset) unicodeInTai_Viet = Charset([
    Interval(0x0aa80,0x0aadf),
]);

immutable(Charset) unicodeInDeseret = Charset([
    Interval(0x10400,0x1044f),
]);

immutable(Charset) unicodeHebrew = Charset([
    Interval(0x00591,0x005c7),
    Interval(0x005d0,0x005ea),
    Interval(0x005f0,0x005f4),
    Interval(0x0fb1d,0x0fb36),
    Interval(0x0fb38,0x0fb3c),
    Interval(0x0fb3e,0x0fb3e),
    Interval(0x0fb40,0x0fb41),
    Interval(0x0fb43,0x0fb44),
    Interval(0x0fb46,0x0fb4f),
]);

immutable(Charset) unicodeLisu = Charset([
    Interval(0x0a4d0,0x0a4ff),
]);

immutable(Charset) unicodeInSupplementary_Private_Use_Area_A = Charset([
    Interval(0xf0000,0xfffff),
]);

immutable(Charset) unicodeInSupplementary_Private_Use_Area_B = Charset([
    Interval(0x100000,0x10ffff),
]);

immutable(Charset) unicodeUgaritic = Charset([
    Interval(0x10380,0x1039d),
    Interval(0x1039f,0x1039f),
]);

immutable(Charset) unicodeInMongolian = Charset([
    Interval(0x01800,0x018af),
]);

immutable(Charset) unicodeInBopomofo = Charset([
    Interval(0x03100,0x0312f),
]);

immutable(Charset) unicodeOld_Persian = Charset([
    Interval(0x103a0,0x103c3),
    Interval(0x103c8,0x103d5),
]);

immutable(Charset) unicodeInCJK_Compatibility_Ideographs_Supplement = Charset([
    Interval(0x2f800,0x2fa1f),
]);

immutable(Charset) unicodeInMahjong_Tiles = Charset([
    Interval(0x1f000,0x1f02f),
]);

immutable(Charset) unicodePhoenician = Charset([
    Interval(0x10900,0x1091b),
    Interval(0x1091f,0x1091f),
]);

immutable(Charset) unicodeEgyptian_Hieroglyphs = Charset([
    Interval(0x13000,0x1342e),
]);

immutable(Charset) unicodeInVariation_Selectors_Supplement = Charset([
    Interval(0xe0100,0xe01ef),
]);

immutable(Charset) unicodeInLisu = Charset([
    Interval(0x0a4d0,0x0a4ff),
]);

immutable(Charset) unicodeInLow_Surrogates = Charset([
    Interval(0x0dc00,0x0dfff),
]);

immutable(Charset) unicodeInUgaritic = Charset([
    Interval(0x10380,0x1039f),
]);

immutable(Charset) unicodeInAncient_Greek_Musical_Notation = Charset([
    Interval(0x1d200,0x1d24f),
]);

immutable(Charset) unicodeInSupplemental_Punctuation = Charset([
    Interval(0x02e00,0x02e7f),
]);

immutable(Charset) unicodeInTamil = Charset([
    Interval(0x00b80,0x00bff),
]);

immutable(Charset) unicodeBidi_Control = Charset([
    Interval(0x0200e,0x0200f),
    Interval(0x0202a,0x0202e),
]);

immutable(Charset) unicodeKatakana = Charset([
    Interval(0x030a1,0x030fa),
    Interval(0x030fd,0x030ff),
    Interval(0x031f0,0x031ff),
    Interval(0x032d0,0x032fe),
    Interval(0x03300,0x03357),
    Interval(0x0ff66,0x0ff6f),
    Interval(0x0ff71,0x0ff9d),
    Interval(0x1b000,0x1b000),
]);

immutable(Charset) unicodeInKanbun = Charset([
    Interval(0x03190,0x0319f),
]);

immutable(Charset) unicodeInHebrew = Charset([
    Interval(0x00590,0x005ff),
]);

immutable(Charset) unicodeTai_Viet = Charset([
    Interval(0x0aa80,0x0aac2),
    Interval(0x0aadb,0x0aadf),
]);

immutable(Charset) unicodeShavian = Charset([
    Interval(0x10450,0x1047f),
]);

immutable(Charset) unicodeInHanunoo = Charset([
    Interval(0x01720,0x0173f),
]);

immutable(Charset) unicodeOther_Lowercase = Charset([
    Interval(0x002b0,0x002b8),
    Interval(0x002c0,0x002c1),
    Interval(0x002e0,0x002e4),
    Interval(0x00345,0x00345),
    Interval(0x0037a,0x0037a),
    Interval(0x01d2c,0x01d61),
    Interval(0x01d78,0x01d78),
    Interval(0x01d9b,0x01dbf),
    Interval(0x02090,0x02094),
    Interval(0x02170,0x0217f),
    Interval(0x024d0,0x024e9),
    Interval(0x02c7d,0x02c7d),
    Interval(0x0a770,0x0a770),
]);

immutable(Charset) unicodeDash = Charset([
    Interval(0x0002d,0x0002d),
    Interval(0x0058a,0x0058a),
    Interval(0x005be,0x005be),
    Interval(0x01400,0x01400),
    Interval(0x01806,0x01806),
    Interval(0x02010,0x02015),
    Interval(0x02053,0x02053),
    Interval(0x0207b,0x0207b),
    Interval(0x0208b,0x0208b),
    Interval(0x02212,0x02212),
    Interval(0x02e17,0x02e17),
    Interval(0x02e1a,0x02e1a),
    Interval(0x0301c,0x0301c),
    Interval(0x03030,0x03030),
    Interval(0x030a0,0x030a0),
    Interval(0x0fe31,0x0fe32),
    Interval(0x0fe58,0x0fe58),
    Interval(0x0fe63,0x0fe63),
    Interval(0x0ff0d,0x0ff0d),
]);

immutable(Charset) unicodeInSinhala = Charset([
    Interval(0x00d80,0x00dff),
]);

immutable(Charset) unicodeKaithi = Charset([
    Interval(0x11080,0x110c1),
]);

immutable(Charset) unicodeInSundanese = Charset([
    Interval(0x01b80,0x01bbf),
]);

immutable(Charset) unicodeInEthiopic_Extended_A = Charset([
    Interval(0x0ab00,0x0ab2f),
]);

immutable(Charset) unicodeInAegean_Numbers = Charset([
    Interval(0x10100,0x1013f),
]);

immutable(Charset) unicodeTibetan = Charset([
    Interval(0x00f00,0x00f47),
    Interval(0x00f49,0x00f6c),
    Interval(0x00f71,0x00f97),
    Interval(0x00f99,0x00fbc),
    Interval(0x00fbe,0x00fcc),
    Interval(0x00fce,0x00fd4),
    Interval(0x00fd9,0x00fda),
]);

immutable(Charset) unicodeSamaritan = Charset([
    Interval(0x00800,0x0082d),
    Interval(0x00830,0x0083e),
]);

immutable(Charset) unicodeInOptical_Character_Recognition = Charset([
    Interval(0x02440,0x0245f),
]);

immutable(Charset) unicodeInKatakana = Charset([
    Interval(0x030a0,0x030ff),
]);

immutable(Charset) unicodeInVariation_Selectors = Charset([
    Interval(0x0fe00,0x0fe0f),
]);

immutable(Charset) unicodeOld_Italic = Charset([
    Interval(0x10300,0x1031e),
    Interval(0x10320,0x10323),
]);

immutable(Charset) unicodeInEnclosed_CJK_Letters_and_Months = Charset([
    Interval(0x03200,0x032ff),
]);

immutable(Charset) unicodeInLatin_1_Supplement = Charset([
    Interval(0x00080,0x000ff),
]);

immutable(Charset) unicodeHan = Charset([
    Interval(0x02e80,0x02e99),
    Interval(0x02e9b,0x02ef3),
    Interval(0x02f00,0x02fd5),
    Interval(0x03005,0x03005),
    Interval(0x03007,0x03007),
    Interval(0x03021,0x03029),
    Interval(0x03038,0x0303b),
    Interval(0x03400,0x04db5),
    Interval(0x04e00,0x09fcb),
    Interval(0x0f900,0x0fa2d),
    Interval(0x0fa30,0x0fa6d),
    Interval(0x0fa70,0x0fad9),
    Interval(0x20000,0x2a6d6),
    Interval(0x2a700,0x2b734),
    Interval(0x2b740,0x2b81d),
    Interval(0x2f800,0x2fa1d),
]);

immutable(Charset) unicodeDeseret = Charset([
    Interval(0x10400,0x1044f),
]);

immutable(Charset) unicodeInMyanmar = Charset([
    Interval(0x01000,0x0109f),
]);

immutable(Charset) unicodeSaurashtra = Charset([
    Interval(0x0a880,0x0a8c4),
    Interval(0x0a8ce,0x0a8d9),
]);

immutable(Charset) unicodeInLinear_B_Syllabary = Charset([
    Interval(0x10000,0x1007f),
]);

immutable(Charset) unicodeLm = Charset([
    Interval(0x002b0,0x002c1),
    Interval(0x002c6,0x002d1),
    Interval(0x002e0,0x002e4),
    Interval(0x002ec,0x002ec),
    Interval(0x002ee,0x002ee),
    Interval(0x00374,0x00374),
    Interval(0x0037a,0x0037a),
    Interval(0x00559,0x00559),
    Interval(0x00640,0x00640),
    Interval(0x006e5,0x006e6),
    Interval(0x007f4,0x007f5),
    Interval(0x007fa,0x007fa),
    Interval(0x0081a,0x0081a),
    Interval(0x00824,0x00824),
    Interval(0x00828,0x00828),
    Interval(0x00971,0x00971),
    Interval(0x00e46,0x00e46),
    Interval(0x00ec6,0x00ec6),
    Interval(0x010fc,0x010fc),
    Interval(0x017d7,0x017d7),
    Interval(0x01843,0x01843),
    Interval(0x01aa7,0x01aa7),
    Interval(0x01c78,0x01c7d),
    Interval(0x01d2c,0x01d61),
    Interval(0x01d78,0x01d78),
    Interval(0x01d9b,0x01dbf),
    Interval(0x02071,0x02071),
    Interval(0x0207f,0x0207f),
    Interval(0x02090,0x0209c),
    Interval(0x02c7d,0x02c7d),
    Interval(0x02d6f,0x02d6f),
    Interval(0x02e2f,0x02e2f),
    Interval(0x03005,0x03005),
    Interval(0x03031,0x03035),
    Interval(0x0303b,0x0303b),
    Interval(0x0309d,0x0309e),
    Interval(0x030fc,0x030fe),
    Interval(0x0a015,0x0a015),
    Interval(0x0a4f8,0x0a4fd),
    Interval(0x0a60c,0x0a60c),
    Interval(0x0a67f,0x0a67f),
    Interval(0x0a717,0x0a71f),
    Interval(0x0a770,0x0a770),
    Interval(0x0a788,0x0a788),
    Interval(0x0a9cf,0x0a9cf),
    Interval(0x0aa70,0x0aa70),
    Interval(0x0aadd,0x0aadd),
    Interval(0x0ff70,0x0ff70),
    Interval(0x0ff9e,0x0ff9f),
]);

immutable(Charset) unicodeInKannada = Charset([
    Interval(0x00c80,0x00cff),
]);

immutable(Charset) unicodeInLimbu = Charset([
    Interval(0x01900,0x0194f),
]);

immutable(Charset) unicodeInByzantine_Musical_Symbols = Charset([
    Interval(0x1d000,0x1d0ff),
]);

immutable(Charset) unicodeMc = Charset([
    Interval(0x00903,0x00903),
    Interval(0x0093b,0x0093b),
    Interval(0x0093e,0x00940),
    Interval(0x00949,0x0094c),
    Interval(0x0094e,0x0094f),
    Interval(0x00982,0x00983),
    Interval(0x009be,0x009c0),
    Interval(0x009c7,0x009c8),
    Interval(0x009cb,0x009cc),
    Interval(0x009d7,0x009d7),
    Interval(0x00a03,0x00a03),
    Interval(0x00a3e,0x00a40),
    Interval(0x00a83,0x00a83),
    Interval(0x00abe,0x00ac0),
    Interval(0x00ac9,0x00ac9),
    Interval(0x00acb,0x00acc),
    Interval(0x00b02,0x00b03),
    Interval(0x00b3e,0x00b3e),
    Interval(0x00b40,0x00b40),
    Interval(0x00b47,0x00b48),
    Interval(0x00b4b,0x00b4c),
    Interval(0x00b57,0x00b57),
    Interval(0x00bbe,0x00bbf),
    Interval(0x00bc1,0x00bc2),
    Interval(0x00bc6,0x00bc8),
    Interval(0x00bca,0x00bcc),
    Interval(0x00bd7,0x00bd7),
    Interval(0x00c01,0x00c03),
    Interval(0x00c41,0x00c44),
    Interval(0x00c82,0x00c83),
    Interval(0x00cbe,0x00cbe),
    Interval(0x00cc0,0x00cc4),
    Interval(0x00cc7,0x00cc8),
    Interval(0x00cca,0x00ccb),
    Interval(0x00cd5,0x00cd6),
    Interval(0x00d02,0x00d03),
    Interval(0x00d3e,0x00d40),
    Interval(0x00d46,0x00d48),
    Interval(0x00d4a,0x00d4c),
    Interval(0x00d57,0x00d57),
    Interval(0x00d82,0x00d83),
    Interval(0x00dcf,0x00dd1),
    Interval(0x00dd8,0x00ddf),
    Interval(0x00df2,0x00df3),
    Interval(0x00f3e,0x00f3f),
    Interval(0x00f7f,0x00f7f),
    Interval(0x0102b,0x0102c),
    Interval(0x01031,0x01031),
    Interval(0x01038,0x01038),
    Interval(0x0103b,0x0103c),
    Interval(0x01056,0x01057),
    Interval(0x01062,0x01064),
    Interval(0x01067,0x0106d),
    Interval(0x01083,0x01084),
    Interval(0x01087,0x0108c),
    Interval(0x0108f,0x0108f),
    Interval(0x0109a,0x0109c),
    Interval(0x017b6,0x017b6),
    Interval(0x017be,0x017c5),
    Interval(0x017c7,0x017c8),
    Interval(0x01923,0x01926),
    Interval(0x01929,0x0192b),
    Interval(0x01930,0x01931),
    Interval(0x01933,0x01938),
    Interval(0x019b0,0x019c0),
    Interval(0x019c8,0x019c9),
    Interval(0x01a19,0x01a1b),
    Interval(0x01a55,0x01a55),
    Interval(0x01a57,0x01a57),
    Interval(0x01a61,0x01a61),
    Interval(0x01a63,0x01a64),
    Interval(0x01a6d,0x01a72),
    Interval(0x01b04,0x01b04),
    Interval(0x01b35,0x01b35),
    Interval(0x01b3b,0x01b3b),
    Interval(0x01b3d,0x01b41),
    Interval(0x01b43,0x01b44),
    Interval(0x01b82,0x01b82),
    Interval(0x01ba1,0x01ba1),
    Interval(0x01ba6,0x01ba7),
    Interval(0x01baa,0x01baa),
    Interval(0x01be7,0x01be7),
    Interval(0x01bea,0x01bec),
    Interval(0x01bee,0x01bee),
    Interval(0x01bf2,0x01bf3),
    Interval(0x01c24,0x01c2b),
    Interval(0x01c34,0x01c35),
    Interval(0x01ce1,0x01ce1),
    Interval(0x01cf2,0x01cf2),
    Interval(0x0a823,0x0a824),
    Interval(0x0a827,0x0a827),
    Interval(0x0a880,0x0a881),
    Interval(0x0a8b4,0x0a8c3),
    Interval(0x0a952,0x0a953),
    Interval(0x0a983,0x0a983),
    Interval(0x0a9b4,0x0a9b5),
    Interval(0x0a9ba,0x0a9bb),
    Interval(0x0a9bd,0x0a9c0),
    Interval(0x0aa2f,0x0aa30),
    Interval(0x0aa33,0x0aa34),
    Interval(0x0aa4d,0x0aa4d),
    Interval(0x0aa7b,0x0aa7b),
    Interval(0x0abe3,0x0abe4),
    Interval(0x0abe6,0x0abe7),
    Interval(0x0abe9,0x0abea),
    Interval(0x0abec,0x0abec),
    Interval(0x11000,0x11000),
    Interval(0x11002,0x11002),
    Interval(0x11082,0x11082),
    Interval(0x110b0,0x110b2),
    Interval(0x110b7,0x110b8),
    Interval(0x1d165,0x1d166),
    Interval(0x1d16d,0x1d172),
]);

immutable(Charset) unicodeLo = Charset([
    Interval(0x001bb,0x001bb),
    Interval(0x001c0,0x001c3),
    Interval(0x00294,0x00294),
    Interval(0x005d0,0x005ea),
    Interval(0x005f0,0x005f2),
    Interval(0x00620,0x0063f),
    Interval(0x00641,0x0064a),
    Interval(0x0066e,0x0066f),
    Interval(0x00671,0x006d3),
    Interval(0x006d5,0x006d5),
    Interval(0x006ee,0x006ef),
    Interval(0x006fa,0x006fc),
    Interval(0x006ff,0x006ff),
    Interval(0x00710,0x00710),
    Interval(0x00712,0x0072f),
    Interval(0x0074d,0x007a5),
    Interval(0x007b1,0x007b1),
    Interval(0x007ca,0x007ea),
    Interval(0x00800,0x00815),
    Interval(0x00840,0x00858),
    Interval(0x00904,0x00939),
    Interval(0x0093d,0x0093d),
    Interval(0x00950,0x00950),
    Interval(0x00958,0x00961),
    Interval(0x00972,0x00977),
    Interval(0x00979,0x0097f),
    Interval(0x00985,0x0098c),
    Interval(0x0098f,0x00990),
    Interval(0x00993,0x009a8),
    Interval(0x009aa,0x009b0),
    Interval(0x009b2,0x009b2),
    Interval(0x009b6,0x009b9),
    Interval(0x009bd,0x009bd),
    Interval(0x009ce,0x009ce),
    Interval(0x009dc,0x009dd),
    Interval(0x009df,0x009e1),
    Interval(0x009f0,0x009f1),
    Interval(0x00a05,0x00a0a),
    Interval(0x00a0f,0x00a10),
    Interval(0x00a13,0x00a28),
    Interval(0x00a2a,0x00a30),
    Interval(0x00a32,0x00a33),
    Interval(0x00a35,0x00a36),
    Interval(0x00a38,0x00a39),
    Interval(0x00a59,0x00a5c),
    Interval(0x00a5e,0x00a5e),
    Interval(0x00a72,0x00a74),
    Interval(0x00a85,0x00a8d),
    Interval(0x00a8f,0x00a91),
    Interval(0x00a93,0x00aa8),
    Interval(0x00aaa,0x00ab0),
    Interval(0x00ab2,0x00ab3),
    Interval(0x00ab5,0x00ab9),
    Interval(0x00abd,0x00abd),
    Interval(0x00ad0,0x00ad0),
    Interval(0x00ae0,0x00ae1),
    Interval(0x00b05,0x00b0c),
    Interval(0x00b0f,0x00b10),
    Interval(0x00b13,0x00b28),
    Interval(0x00b2a,0x00b30),
    Interval(0x00b32,0x00b33),
    Interval(0x00b35,0x00b39),
    Interval(0x00b3d,0x00b3d),
    Interval(0x00b5c,0x00b5d),
    Interval(0x00b5f,0x00b61),
    Interval(0x00b71,0x00b71),
    Interval(0x00b83,0x00b83),
    Interval(0x00b85,0x00b8a),
    Interval(0x00b8e,0x00b90),
    Interval(0x00b92,0x00b95),
    Interval(0x00b99,0x00b9a),
    Interval(0x00b9c,0x00b9c),
    Interval(0x00b9e,0x00b9f),
    Interval(0x00ba3,0x00ba4),
    Interval(0x00ba8,0x00baa),
    Interval(0x00bae,0x00bb9),
    Interval(0x00bd0,0x00bd0),
    Interval(0x00c05,0x00c0c),
    Interval(0x00c0e,0x00c10),
    Interval(0x00c12,0x00c28),
    Interval(0x00c2a,0x00c33),
    Interval(0x00c35,0x00c39),
    Interval(0x00c3d,0x00c3d),
    Interval(0x00c58,0x00c59),
    Interval(0x00c60,0x00c61),
    Interval(0x00c85,0x00c8c),
    Interval(0x00c8e,0x00c90),
    Interval(0x00c92,0x00ca8),
    Interval(0x00caa,0x00cb3),
    Interval(0x00cb5,0x00cb9),
    Interval(0x00cbd,0x00cbd),
    Interval(0x00cde,0x00cde),
    Interval(0x00ce0,0x00ce1),
    Interval(0x00cf1,0x00cf2),
    Interval(0x00d05,0x00d0c),
    Interval(0x00d0e,0x00d10),
    Interval(0x00d12,0x00d3a),
    Interval(0x00d3d,0x00d3d),
    Interval(0x00d4e,0x00d4e),
    Interval(0x00d60,0x00d61),
    Interval(0x00d7a,0x00d7f),
    Interval(0x00d85,0x00d96),
    Interval(0x00d9a,0x00db1),
    Interval(0x00db3,0x00dbb),
    Interval(0x00dbd,0x00dbd),
    Interval(0x00dc0,0x00dc6),
    Interval(0x00e01,0x00e30),
    Interval(0x00e32,0x00e33),
    Interval(0x00e40,0x00e45),
    Interval(0x00e81,0x00e82),
    Interval(0x00e84,0x00e84),
    Interval(0x00e87,0x00e88),
    Interval(0x00e8a,0x00e8a),
    Interval(0x00e8d,0x00e8d),
    Interval(0x00e94,0x00e97),
    Interval(0x00e99,0x00e9f),
    Interval(0x00ea1,0x00ea3),
    Interval(0x00ea5,0x00ea5),
    Interval(0x00ea7,0x00ea7),
    Interval(0x00eaa,0x00eab),
    Interval(0x00ead,0x00eb0),
    Interval(0x00eb2,0x00eb3),
    Interval(0x00ebd,0x00ebd),
    Interval(0x00ec0,0x00ec4),
    Interval(0x00edc,0x00edd),
    Interval(0x00f00,0x00f00),
    Interval(0x00f40,0x00f47),
    Interval(0x00f49,0x00f6c),
    Interval(0x00f88,0x00f8c),
    Interval(0x01000,0x0102a),
    Interval(0x0103f,0x0103f),
    Interval(0x01050,0x01055),
    Interval(0x0105a,0x0105d),
    Interval(0x01061,0x01061),
    Interval(0x01065,0x01066),
    Interval(0x0106e,0x01070),
    Interval(0x01075,0x01081),
    Interval(0x0108e,0x0108e),
    Interval(0x010d0,0x010fa),
    Interval(0x01100,0x01248),
    Interval(0x0124a,0x0124d),
    Interval(0x01250,0x01256),
    Interval(0x01258,0x01258),
    Interval(0x0125a,0x0125d),
    Interval(0x01260,0x01288),
    Interval(0x0128a,0x0128d),
    Interval(0x01290,0x012b0),
    Interval(0x012b2,0x012b5),
    Interval(0x012b8,0x012be),
    Interval(0x012c0,0x012c0),
    Interval(0x012c2,0x012c5),
    Interval(0x012c8,0x012d6),
    Interval(0x012d8,0x01310),
    Interval(0x01312,0x01315),
    Interval(0x01318,0x0135a),
    Interval(0x01380,0x0138f),
    Interval(0x013a0,0x013f4),
    Interval(0x01401,0x0166c),
    Interval(0x0166f,0x0167f),
    Interval(0x01681,0x0169a),
    Interval(0x016a0,0x016ea),
    Interval(0x01700,0x0170c),
    Interval(0x0170e,0x01711),
    Interval(0x01720,0x01731),
    Interval(0x01740,0x01751),
    Interval(0x01760,0x0176c),
    Interval(0x0176e,0x01770),
    Interval(0x01780,0x017b3),
    Interval(0x017dc,0x017dc),
    Interval(0x01820,0x01842),
    Interval(0x01844,0x01877),
    Interval(0x01880,0x018a8),
    Interval(0x018aa,0x018aa),
    Interval(0x018b0,0x018f5),
    Interval(0x01900,0x0191c),
    Interval(0x01950,0x0196d),
    Interval(0x01970,0x01974),
    Interval(0x01980,0x019ab),
    Interval(0x019c1,0x019c7),
    Interval(0x01a00,0x01a16),
    Interval(0x01a20,0x01a54),
    Interval(0x01b05,0x01b33),
    Interval(0x01b45,0x01b4b),
    Interval(0x01b83,0x01ba0),
    Interval(0x01bae,0x01baf),
    Interval(0x01bc0,0x01be5),
    Interval(0x01c00,0x01c23),
    Interval(0x01c4d,0x01c4f),
    Interval(0x01c5a,0x01c77),
    Interval(0x01ce9,0x01cec),
    Interval(0x01cee,0x01cf1),
    Interval(0x02135,0x02138),
    Interval(0x02d30,0x02d65),
    Interval(0x02d80,0x02d96),
    Interval(0x02da0,0x02da6),
    Interval(0x02da8,0x02dae),
    Interval(0x02db0,0x02db6),
    Interval(0x02db8,0x02dbe),
    Interval(0x02dc0,0x02dc6),
    Interval(0x02dc8,0x02dce),
    Interval(0x02dd0,0x02dd6),
    Interval(0x02dd8,0x02dde),
    Interval(0x03006,0x03006),
    Interval(0x0303c,0x0303c),
    Interval(0x03041,0x03096),
    Interval(0x0309f,0x0309f),
    Interval(0x030a1,0x030fa),
    Interval(0x030ff,0x030ff),
    Interval(0x03105,0x0312d),
    Interval(0x03131,0x0318e),
    Interval(0x031a0,0x031ba),
    Interval(0x031f0,0x031ff),
    Interval(0x03400,0x04db5),
    Interval(0x04e00,0x09fcb),
    Interval(0x0a000,0x0a014),
    Interval(0x0a016,0x0a48c),
    Interval(0x0a4d0,0x0a4f7),
    Interval(0x0a500,0x0a60b),
    Interval(0x0a610,0x0a61f),
    Interval(0x0a62a,0x0a62b),
    Interval(0x0a66e,0x0a66e),
    Interval(0x0a6a0,0x0a6e5),
    Interval(0x0a7fb,0x0a801),
    Interval(0x0a803,0x0a805),
    Interval(0x0a807,0x0a80a),
    Interval(0x0a80c,0x0a822),
    Interval(0x0a840,0x0a873),
    Interval(0x0a882,0x0a8b3),
    Interval(0x0a8f2,0x0a8f7),
    Interval(0x0a8fb,0x0a8fb),
    Interval(0x0a90a,0x0a925),
    Interval(0x0a930,0x0a946),
    Interval(0x0a960,0x0a97c),
    Interval(0x0a984,0x0a9b2),
    Interval(0x0aa00,0x0aa28),
    Interval(0x0aa40,0x0aa42),
    Interval(0x0aa44,0x0aa4b),
    Interval(0x0aa60,0x0aa6f),
    Interval(0x0aa71,0x0aa76),
    Interval(0x0aa7a,0x0aa7a),
    Interval(0x0aa80,0x0aaaf),
    Interval(0x0aab1,0x0aab1),
    Interval(0x0aab5,0x0aab6),
    Interval(0x0aab9,0x0aabd),
    Interval(0x0aac0,0x0aac0),
    Interval(0x0aac2,0x0aac2),
    Interval(0x0aadb,0x0aadc),
    Interval(0x0ab01,0x0ab06),
    Interval(0x0ab09,0x0ab0e),
    Interval(0x0ab11,0x0ab16),
    Interval(0x0ab20,0x0ab26),
    Interval(0x0ab28,0x0ab2e),
    Interval(0x0abc0,0x0abe2),
    Interval(0x0ac00,0x0d7a3),
    Interval(0x0d7b0,0x0d7c6),
    Interval(0x0d7cb,0x0d7fb),
    Interval(0x0f900,0x0fa2d),
    Interval(0x0fa30,0x0fa6d),
    Interval(0x0fa70,0x0fad9),
    Interval(0x0fb1d,0x0fb1d),
    Interval(0x0fb1f,0x0fb28),
    Interval(0x0fb2a,0x0fb36),
    Interval(0x0fb38,0x0fb3c),
    Interval(0x0fb3e,0x0fb3e),
    Interval(0x0fb40,0x0fb41),
    Interval(0x0fb43,0x0fb44),
    Interval(0x0fb46,0x0fbb1),
    Interval(0x0fbd3,0x0fd3d),
    Interval(0x0fd50,0x0fd8f),
    Interval(0x0fd92,0x0fdc7),
    Interval(0x0fdf0,0x0fdfb),
    Interval(0x0fe70,0x0fe74),
    Interval(0x0fe76,0x0fefc),
    Interval(0x0ff66,0x0ff6f),
    Interval(0x0ff71,0x0ff9d),
    Interval(0x0ffa0,0x0ffbe),
    Interval(0x0ffc2,0x0ffc7),
    Interval(0x0ffca,0x0ffcf),
    Interval(0x0ffd2,0x0ffd7),
    Interval(0x0ffda,0x0ffdc),
    Interval(0x10000,0x1000b),
    Interval(0x1000d,0x10026),
    Interval(0x10028,0x1003a),
    Interval(0x1003c,0x1003d),
    Interval(0x1003f,0x1004d),
    Interval(0x10050,0x1005d),
    Interval(0x10080,0x100fa),
    Interval(0x10280,0x1029c),
    Interval(0x102a0,0x102d0),
    Interval(0x10300,0x1031e),
    Interval(0x10330,0x10340),
    Interval(0x10342,0x10349),
    Interval(0x10380,0x1039d),
    Interval(0x103a0,0x103c3),
    Interval(0x103c8,0x103cf),
    Interval(0x10450,0x1049d),
    Interval(0x10800,0x10805),
    Interval(0x10808,0x10808),
    Interval(0x1080a,0x10835),
    Interval(0x10837,0x10838),
    Interval(0x1083c,0x1083c),
    Interval(0x1083f,0x10855),
    Interval(0x10900,0x10915),
    Interval(0x10920,0x10939),
    Interval(0x10a00,0x10a00),
    Interval(0x10a10,0x10a13),
    Interval(0x10a15,0x10a17),
    Interval(0x10a19,0x10a33),
    Interval(0x10a60,0x10a7c),
    Interval(0x10b00,0x10b35),
    Interval(0x10b40,0x10b55),
    Interval(0x10b60,0x10b72),
    Interval(0x10c00,0x10c48),
    Interval(0x11003,0x11037),
    Interval(0x11083,0x110af),
    Interval(0x12000,0x1236e),
    Interval(0x13000,0x1342e),
    Interval(0x16800,0x16a38),
    Interval(0x1b000,0x1b001),
    Interval(0x20000,0x2a6d6),
    Interval(0x2a700,0x2b734),
    Interval(0x2b740,0x2b81d),
    Interval(0x2f800,0x2fa1d),
]);

immutable(Charset) unicodeMe = Charset([
    Interval(0x00488,0x00489),
    Interval(0x020dd,0x020e0),
    Interval(0x020e2,0x020e4),
    Interval(0x0a670,0x0a672),
]);

immutable(Charset) unicodeInMeetei_Mayek = Charset([
    Interval(0x0abc0,0x0abff),
]);

immutable(Charset) unicodeLt = Charset([
    Interval(0x001c5,0x001c5),
    Interval(0x001c8,0x001c8),
    Interval(0x001cb,0x001cb),
    Interval(0x001f2,0x001f2),
    Interval(0x01f88,0x01f8f),
    Interval(0x01f98,0x01f9f),
    Interval(0x01fa8,0x01faf),
    Interval(0x01fbc,0x01fbc),
    Interval(0x01fcc,0x01fcc),
    Interval(0x01ffc,0x01ffc),
]);

immutable(Charset) unicodeInKhmer = Charset([
    Interval(0x01780,0x017ff),
]);

immutable(Charset) unicodeInEthiopic_Extended = Charset([
    Interval(0x02d80,0x02ddf),
]);

immutable(Charset) unicodeCarian = Charset([
    Interval(0x102a0,0x102d0),
]);

immutable(Charset) unicodeInKaithi = Charset([
    Interval(0x11080,0x110cf),
]);

immutable(Charset) unicodeInVedic_Extensions = Charset([
    Interval(0x01cd0,0x01cff),
]);

immutable(Charset) unicodeMn = Charset([
    Interval(0x00300,0x0036f),
    Interval(0x00483,0x00487),
    Interval(0x00591,0x005bd),
    Interval(0x005bf,0x005bf),
    Interval(0x005c1,0x005c2),
    Interval(0x005c4,0x005c5),
    Interval(0x005c7,0x005c7),
    Interval(0x00610,0x0061a),
    Interval(0x0064b,0x0065f),
    Interval(0x00670,0x00670),
    Interval(0x006d6,0x006dc),
    Interval(0x006df,0x006e4),
    Interval(0x006e7,0x006e8),
    Interval(0x006ea,0x006ed),
    Interval(0x00711,0x00711),
    Interval(0x00730,0x0074a),
    Interval(0x007a6,0x007b0),
    Interval(0x007eb,0x007f3),
    Interval(0x00816,0x00819),
    Interval(0x0081b,0x00823),
    Interval(0x00825,0x00827),
    Interval(0x00829,0x0082d),
    Interval(0x00859,0x0085b),
    Interval(0x00900,0x00902),
    Interval(0x0093a,0x0093a),
    Interval(0x0093c,0x0093c),
    Interval(0x00941,0x00948),
    Interval(0x0094d,0x0094d),
    Interval(0x00951,0x00957),
    Interval(0x00962,0x00963),
    Interval(0x00981,0x00981),
    Interval(0x009bc,0x009bc),
    Interval(0x009c1,0x009c4),
    Interval(0x009cd,0x009cd),
    Interval(0x009e2,0x009e3),
    Interval(0x00a01,0x00a02),
    Interval(0x00a3c,0x00a3c),
    Interval(0x00a41,0x00a42),
    Interval(0x00a47,0x00a48),
    Interval(0x00a4b,0x00a4d),
    Interval(0x00a51,0x00a51),
    Interval(0x00a70,0x00a71),
    Interval(0x00a75,0x00a75),
    Interval(0x00a81,0x00a82),
    Interval(0x00abc,0x00abc),
    Interval(0x00ac1,0x00ac5),
    Interval(0x00ac7,0x00ac8),
    Interval(0x00acd,0x00acd),
    Interval(0x00ae2,0x00ae3),
    Interval(0x00b01,0x00b01),
    Interval(0x00b3c,0x00b3c),
    Interval(0x00b3f,0x00b3f),
    Interval(0x00b41,0x00b44),
    Interval(0x00b4d,0x00b4d),
    Interval(0x00b56,0x00b56),
    Interval(0x00b62,0x00b63),
    Interval(0x00b82,0x00b82),
    Interval(0x00bc0,0x00bc0),
    Interval(0x00bcd,0x00bcd),
    Interval(0x00c3e,0x00c40),
    Interval(0x00c46,0x00c48),
    Interval(0x00c4a,0x00c4d),
    Interval(0x00c55,0x00c56),
    Interval(0x00c62,0x00c63),
    Interval(0x00cbc,0x00cbc),
    Interval(0x00cbf,0x00cbf),
    Interval(0x00cc6,0x00cc6),
    Interval(0x00ccc,0x00ccd),
    Interval(0x00ce2,0x00ce3),
    Interval(0x00d41,0x00d44),
    Interval(0x00d4d,0x00d4d),
    Interval(0x00d62,0x00d63),
    Interval(0x00dca,0x00dca),
    Interval(0x00dd2,0x00dd4),
    Interval(0x00dd6,0x00dd6),
    Interval(0x00e31,0x00e31),
    Interval(0x00e34,0x00e3a),
    Interval(0x00e47,0x00e4e),
    Interval(0x00eb1,0x00eb1),
    Interval(0x00eb4,0x00eb9),
    Interval(0x00ebb,0x00ebc),
    Interval(0x00ec8,0x00ecd),
    Interval(0x00f18,0x00f19),
    Interval(0x00f35,0x00f35),
    Interval(0x00f37,0x00f37),
    Interval(0x00f39,0x00f39),
    Interval(0x00f71,0x00f7e),
    Interval(0x00f80,0x00f84),
    Interval(0x00f86,0x00f87),
    Interval(0x00f8d,0x00f97),
    Interval(0x00f99,0x00fbc),
    Interval(0x00fc6,0x00fc6),
    Interval(0x0102d,0x01030),
    Interval(0x01032,0x01037),
    Interval(0x01039,0x0103a),
    Interval(0x0103d,0x0103e),
    Interval(0x01058,0x01059),
    Interval(0x0105e,0x01060),
    Interval(0x01071,0x01074),
    Interval(0x01082,0x01082),
    Interval(0x01085,0x01086),
    Interval(0x0108d,0x0108d),
    Interval(0x0109d,0x0109d),
    Interval(0x0135d,0x0135f),
    Interval(0x01712,0x01714),
    Interval(0x01732,0x01734),
    Interval(0x01752,0x01753),
    Interval(0x01772,0x01773),
    Interval(0x017b7,0x017bd),
    Interval(0x017c6,0x017c6),
    Interval(0x017c9,0x017d3),
    Interval(0x017dd,0x017dd),
    Interval(0x0180b,0x0180d),
    Interval(0x018a9,0x018a9),
    Interval(0x01920,0x01922),
    Interval(0x01927,0x01928),
    Interval(0x01932,0x01932),
    Interval(0x01939,0x0193b),
    Interval(0x01a17,0x01a18),
    Interval(0x01a56,0x01a56),
    Interval(0x01a58,0x01a5e),
    Interval(0x01a60,0x01a60),
    Interval(0x01a62,0x01a62),
    Interval(0x01a65,0x01a6c),
    Interval(0x01a73,0x01a7c),
    Interval(0x01a7f,0x01a7f),
    Interval(0x01b00,0x01b03),
    Interval(0x01b34,0x01b34),
    Interval(0x01b36,0x01b3a),
    Interval(0x01b3c,0x01b3c),
    Interval(0x01b42,0x01b42),
    Interval(0x01b6b,0x01b73),
    Interval(0x01b80,0x01b81),
    Interval(0x01ba2,0x01ba5),
    Interval(0x01ba8,0x01ba9),
    Interval(0x01be6,0x01be6),
    Interval(0x01be8,0x01be9),
    Interval(0x01bed,0x01bed),
    Interval(0x01bef,0x01bf1),
    Interval(0x01c2c,0x01c33),
    Interval(0x01c36,0x01c37),
    Interval(0x01cd0,0x01cd2),
    Interval(0x01cd4,0x01ce0),
    Interval(0x01ce2,0x01ce8),
    Interval(0x01ced,0x01ced),
    Interval(0x01dc0,0x01de6),
    Interval(0x01dfc,0x01dff),
    Interval(0x020d0,0x020dc),
    Interval(0x020e1,0x020e1),
    Interval(0x020e5,0x020f0),
    Interval(0x02cef,0x02cf1),
    Interval(0x02d7f,0x02d7f),
    Interval(0x02de0,0x02dff),
    Interval(0x0302a,0x0302f),
    Interval(0x03099,0x0309a),
    Interval(0x0a66f,0x0a66f),
    Interval(0x0a67c,0x0a67d),
    Interval(0x0a6f0,0x0a6f1),
    Interval(0x0a802,0x0a802),
    Interval(0x0a806,0x0a806),
    Interval(0x0a80b,0x0a80b),
    Interval(0x0a825,0x0a826),
    Interval(0x0a8c4,0x0a8c4),
    Interval(0x0a8e0,0x0a8f1),
    Interval(0x0a926,0x0a92d),
    Interval(0x0a947,0x0a951),
    Interval(0x0a980,0x0a982),
    Interval(0x0a9b3,0x0a9b3),
    Interval(0x0a9b6,0x0a9b9),
    Interval(0x0a9bc,0x0a9bc),
    Interval(0x0aa29,0x0aa2e),
    Interval(0x0aa31,0x0aa32),
    Interval(0x0aa35,0x0aa36),
    Interval(0x0aa43,0x0aa43),
    Interval(0x0aa4c,0x0aa4c),
    Interval(0x0aab0,0x0aab0),
    Interval(0x0aab2,0x0aab4),
    Interval(0x0aab7,0x0aab8),
    Interval(0x0aabe,0x0aabf),
    Interval(0x0aac1,0x0aac1),
    Interval(0x0abe5,0x0abe5),
    Interval(0x0abe8,0x0abe8),
    Interval(0x0abed,0x0abed),
    Interval(0x0fb1e,0x0fb1e),
    Interval(0x0fe00,0x0fe0f),
    Interval(0x0fe20,0x0fe26),
    Interval(0x101fd,0x101fd),
    Interval(0x10a01,0x10a03),
    Interval(0x10a05,0x10a06),
    Interval(0x10a0c,0x10a0f),
    Interval(0x10a38,0x10a3a),
    Interval(0x10a3f,0x10a3f),
    Interval(0x11001,0x11001),
    Interval(0x11038,0x11046),
    Interval(0x11080,0x11081),
    Interval(0x110b3,0x110b6),
    Interval(0x110b9,0x110ba),
    Interval(0x1d167,0x1d169),
    Interval(0x1d17b,0x1d182),
    Interval(0x1d185,0x1d18b),
    Interval(0x1d1aa,0x1d1ad),
    Interval(0x1d242,0x1d244),
    Interval(0xe0100,0xe01ef),
]);

immutable(Charset) unicodeNd = Charset([
    Interval(0x00030,0x00039),
    Interval(0x00660,0x00669),
    Interval(0x006f0,0x006f9),
    Interval(0x007c0,0x007c9),
    Interval(0x00966,0x0096f),
    Interval(0x009e6,0x009ef),
    Interval(0x00a66,0x00a6f),
    Interval(0x00ae6,0x00aef),
    Interval(0x00b66,0x00b6f),
    Interval(0x00be6,0x00bef),
    Interval(0x00c66,0x00c6f),
    Interval(0x00ce6,0x00cef),
    Interval(0x00d66,0x00d6f),
    Interval(0x00e50,0x00e59),
    Interval(0x00ed0,0x00ed9),
    Interval(0x00f20,0x00f29),
    Interval(0x01040,0x01049),
    Interval(0x01090,0x01099),
    Interval(0x017e0,0x017e9),
    Interval(0x01810,0x01819),
    Interval(0x01946,0x0194f),
    Interval(0x019d0,0x019d9),
    Interval(0x01a80,0x01a89),
    Interval(0x01a90,0x01a99),
    Interval(0x01b50,0x01b59),
    Interval(0x01bb0,0x01bb9),
    Interval(0x01c40,0x01c49),
    Interval(0x01c50,0x01c59),
    Interval(0x0a620,0x0a629),
    Interval(0x0a8d0,0x0a8d9),
    Interval(0x0a900,0x0a909),
    Interval(0x0a9d0,0x0a9d9),
    Interval(0x0aa50,0x0aa59),
    Interval(0x0abf0,0x0abf9),
    Interval(0x0ff10,0x0ff19),
    Interval(0x104a0,0x104a9),
    Interval(0x11066,0x1106f),
    Interval(0x1d7ce,0x1d7ff),
]);

immutable(Charset) unicodeBamum = Charset([
    Interval(0x0a6a0,0x0a6f7),
    Interval(0x16800,0x16a38),
]);

immutable(Charset) unicodeJavanese = Charset([
    Interval(0x0a980,0x0a9cd),
    Interval(0x0a9cf,0x0a9d9),
    Interval(0x0a9de,0x0a9df),
]);

immutable(Charset) unicodeTifinagh = Charset([
    Interval(0x02d30,0x02d65),
    Interval(0x02d6f,0x02d70),
    Interval(0x02d7f,0x02d7f),
]);

immutable(Charset) unicodeInHalfwidth_and_Fullwidth_Forms = Charset([
    Interval(0x0ff00,0x0ffef),
]);

immutable(Charset) unicodeInDevanagari_Extended = Charset([
    Interval(0x0a8e0,0x0a8ff),
]);

immutable(Charset) unicodeInIdeographic_Description_Characters = Charset([
    Interval(0x02ff0,0x02fff),
]);

immutable(Charset) unicodeInCuneiform = Charset([
    Interval(0x12000,0x123ff),
]);

immutable(Charset) unicodeNl = Charset([
    Interval(0x016ee,0x016f0),
    Interval(0x02160,0x02182),
    Interval(0x02185,0x02188),
    Interval(0x03007,0x03007),
    Interval(0x03021,0x03029),
    Interval(0x03038,0x0303a),
    Interval(0x0a6e6,0x0a6ef),
    Interval(0x10140,0x10174),
    Interval(0x10341,0x10341),
    Interval(0x1034a,0x1034a),
    Interval(0x103d1,0x103d5),
    Interval(0x12400,0x12462),
]);

immutable(Charset) unicodeInHangul_Compatibility_Jamo = Charset([
    Interval(0x03130,0x0318f),
]);

immutable(Charset) unicodeNo = Charset([
    Interval(0x000b2,0x000b3),
    Interval(0x000b9,0x000b9),
    Interval(0x000bc,0x000be),
    Interval(0x009f4,0x009f9),
    Interval(0x00b72,0x00b77),
    Interval(0x00bf0,0x00bf2),
    Interval(0x00c78,0x00c7e),
    Interval(0x00d70,0x00d75),
    Interval(0x00f2a,0x00f33),
    Interval(0x01369,0x0137c),
    Interval(0x017f0,0x017f9),
    Interval(0x019da,0x019da),
    Interval(0x02070,0x02070),
    Interval(0x02074,0x02079),
    Interval(0x02080,0x02089),
    Interval(0x02150,0x0215f),
    Interval(0x02189,0x02189),
    Interval(0x02460,0x0249b),
    Interval(0x024ea,0x024ff),
    Interval(0x02776,0x02793),
    Interval(0x02cfd,0x02cfd),
    Interval(0x03192,0x03195),
    Interval(0x03220,0x03229),
    Interval(0x03251,0x0325f),
    Interval(0x03280,0x03289),
    Interval(0x032b1,0x032bf),
    Interval(0x0a830,0x0a835),
    Interval(0x10107,0x10133),
    Interval(0x10175,0x10178),
    Interval(0x1018a,0x1018a),
    Interval(0x10320,0x10323),
    Interval(0x10858,0x1085f),
    Interval(0x10916,0x1091b),
    Interval(0x10a40,0x10a47),
    Interval(0x10a7d,0x10a7e),
    Interval(0x10b58,0x10b5f),
    Interval(0x10b78,0x10b7f),
    Interval(0x10e60,0x10e7e),
    Interval(0x11052,0x11065),
    Interval(0x1d360,0x1d371),
    Interval(0x1f100,0x1f10a),
]);

immutable(Charset) unicodeInOriya = Charset([
    Interval(0x00b00,0x00b7f),
]);

immutable(Charset) unicodeLogical_Order_Exception = Charset([
    Interval(0x00e40,0x00e44),
    Interval(0x00ec0,0x00ec4),
    Interval(0x0aab5,0x0aab6),
    Interval(0x0aab9,0x0aab9),
    Interval(0x0aabb,0x0aabc),
]);

immutable(Charset) unicodeInscriptional_Parthian = Charset([
    Interval(0x10b40,0x10b55),
    Interval(0x10b58,0x10b5f),
]);

immutable(Charset) unicodeSyloti_Nagri = Charset([
    Interval(0x0a800,0x0a82b),
]);

immutable(Charset) unicodeInBengali = Charset([
    Interval(0x00980,0x009ff),
]);

immutable(Charset) unicodeInTagalog = Charset([
    Interval(0x01700,0x0171f),
]);

immutable(Charset) unicodeInMyanmar_Extended_A = Charset([
    Interval(0x0aa60,0x0aa7f),
]);

immutable(Charset) unicodeInAvestan = Charset([
    Interval(0x10b00,0x10b3f),
]);

immutable(Charset) unicodePc = Charset([
    Interval(0x0005f,0x0005f),
    Interval(0x0203f,0x02040),
    Interval(0x02054,0x02054),
    Interval(0x0fe33,0x0fe34),
    Interval(0x0fe4d,0x0fe4f),
    Interval(0x0ff3f,0x0ff3f),
]);

immutable(Charset) unicodeInCyrillic_Extended_A = Charset([
    Interval(0x02de0,0x02dff),
]);

immutable(Charset) unicodePd = Charset([
    Interval(0x0002d,0x0002d),
    Interval(0x0058a,0x0058a),
    Interval(0x005be,0x005be),
    Interval(0x01400,0x01400),
    Interval(0x01806,0x01806),
    Interval(0x02010,0x02015),
    Interval(0x02e17,0x02e17),
    Interval(0x02e1a,0x02e1a),
    Interval(0x0301c,0x0301c),
    Interval(0x03030,0x03030),
    Interval(0x030a0,0x030a0),
    Interval(0x0fe31,0x0fe32),
    Interval(0x0fe58,0x0fe58),
    Interval(0x0fe63,0x0fe63),
    Interval(0x0ff0d,0x0ff0d),
]);

immutable(Charset) unicodeInCyrillic_Extended_B = Charset([
    Interval(0x0a640,0x0a69f),
]);

immutable(Charset) unicodeInBasic_Latin = Charset([
    Interval(0x00000,0x0007f),
]);

immutable(Charset) unicodePe = Charset([
    Interval(0x00029,0x00029),
    Interval(0x0005d,0x0005d),
    Interval(0x0007d,0x0007d),
    Interval(0x00f3b,0x00f3b),
    Interval(0x00f3d,0x00f3d),
    Interval(0x0169c,0x0169c),
    Interval(0x02046,0x02046),
    Interval(0x0207e,0x0207e),
    Interval(0x0208e,0x0208e),
    Interval(0x0232a,0x0232a),
    Interval(0x02769,0x02769),
    Interval(0x0276b,0x0276b),
    Interval(0x0276d,0x0276d),
    Interval(0x0276f,0x0276f),
    Interval(0x02771,0x02771),
    Interval(0x02773,0x02773),
    Interval(0x02775,0x02775),
    Interval(0x027c6,0x027c6),
    Interval(0x027e7,0x027e7),
    Interval(0x027e9,0x027e9),
    Interval(0x027eb,0x027eb),
    Interval(0x027ed,0x027ed),
    Interval(0x027ef,0x027ef),
    Interval(0x02984,0x02984),
    Interval(0x02986,0x02986),
    Interval(0x02988,0x02988),
    Interval(0x0298a,0x0298a),
    Interval(0x0298c,0x0298c),
    Interval(0x0298e,0x0298e),
    Interval(0x02990,0x02990),
    Interval(0x02992,0x02992),
    Interval(0x02994,0x02994),
    Interval(0x02996,0x02996),
    Interval(0x02998,0x02998),
    Interval(0x029d9,0x029d9),
    Interval(0x029db,0x029db),
    Interval(0x029fd,0x029fd),
    Interval(0x02e23,0x02e23),
    Interval(0x02e25,0x02e25),
    Interval(0x02e27,0x02e27),
    Interval(0x02e29,0x02e29),
    Interval(0x03009,0x03009),
    Interval(0x0300b,0x0300b),
    Interval(0x0300d,0x0300d),
    Interval(0x0300f,0x0300f),
    Interval(0x03011,0x03011),
    Interval(0x03015,0x03015),
    Interval(0x03017,0x03017),
    Interval(0x03019,0x03019),
    Interval(0x0301b,0x0301b),
    Interval(0x0301e,0x0301f),
    Interval(0x0fd3f,0x0fd3f),
    Interval(0x0fe18,0x0fe18),
    Interval(0x0fe36,0x0fe36),
    Interval(0x0fe38,0x0fe38),
    Interval(0x0fe3a,0x0fe3a),
    Interval(0x0fe3c,0x0fe3c),
    Interval(0x0fe3e,0x0fe3e),
    Interval(0x0fe40,0x0fe40),
    Interval(0x0fe42,0x0fe42),
    Interval(0x0fe44,0x0fe44),
    Interval(0x0fe48,0x0fe48),
    Interval(0x0fe5a,0x0fe5a),
    Interval(0x0fe5c,0x0fe5c),
    Interval(0x0fe5e,0x0fe5e),
    Interval(0x0ff09,0x0ff09),
    Interval(0x0ff3d,0x0ff3d),
    Interval(0x0ff5d,0x0ff5d),
    Interval(0x0ff60,0x0ff60),
    Interval(0x0ff63,0x0ff63),
]);

immutable(Charset) unicodeHanunoo = Charset([
    Interval(0x01720,0x01734),
]);

immutable(Charset) unicodePf = Charset([
    Interval(0x000bb,0x000bb),
    Interval(0x02019,0x02019),
    Interval(0x0201d,0x0201d),
    Interval(0x0203a,0x0203a),
    Interval(0x02e03,0x02e03),
    Interval(0x02e05,0x02e05),
    Interval(0x02e0a,0x02e0a),
    Interval(0x02e0d,0x02e0d),
    Interval(0x02e1d,0x02e1d),
    Interval(0x02e21,0x02e21),
]);

immutable(Charset) unicodePi = Charset([
    Interval(0x000ab,0x000ab),
    Interval(0x02018,0x02018),
    Interval(0x0201b,0x0201c),
    Interval(0x0201f,0x0201f),
    Interval(0x02039,0x02039),
    Interval(0x02e02,0x02e02),
    Interval(0x02e04,0x02e04),
    Interval(0x02e09,0x02e09),
    Interval(0x02e0c,0x02e0c),
    Interval(0x02e1c,0x02e1c),
    Interval(0x02e20,0x02e20),
]);

immutable(Charset) unicodeSinhala = Charset([
    Interval(0x00d82,0x00d83),
    Interval(0x00d85,0x00d96),
    Interval(0x00d9a,0x00db1),
    Interval(0x00db3,0x00dbb),
    Interval(0x00dbd,0x00dbd),
    Interval(0x00dc0,0x00dc6),
    Interval(0x00dca,0x00dca),
    Interval(0x00dcf,0x00dd4),
    Interval(0x00dd6,0x00dd6),
    Interval(0x00dd8,0x00ddf),
    Interval(0x00df2,0x00df4),
]);

immutable(Charset) unicodeInJavanese = Charset([
    Interval(0x0a980,0x0a9df),
]);

immutable(Charset) unicodeInCarian = Charset([
    Interval(0x102a0,0x102df),
]);

immutable(Charset) unicodeInDomino_Tiles = Charset([
    Interval(0x1f030,0x1f09f),
]);

immutable(Charset) unicodeInTifinagh = Charset([
    Interval(0x02d30,0x02d7f),
]);

immutable(Charset) unicodeLycian = Charset([
    Interval(0x10280,0x1029c),
]);

immutable(Charset) unicodeInGeometric_Shapes = Charset([
    Interval(0x025a0,0x025ff),
]);

immutable(Charset) unicodeInArabic_Presentation_Forms_A = Charset([
    Interval(0x0fb50,0x0fdff),
]);

immutable(Charset) unicodeInArabic_Presentation_Forms_B = Charset([
    Interval(0x0fe70,0x0feff),
]);

immutable(Charset) unicodePo = Charset([
    Interval(0x00021,0x00023),
    Interval(0x00025,0x00027),
    Interval(0x0002a,0x0002a),
    Interval(0x0002c,0x0002c),
    Interval(0x0002e,0x0002f),
    Interval(0x0003a,0x0003b),
    Interval(0x0003f,0x00040),
    Interval(0x0005c,0x0005c),
    Interval(0x000a1,0x000a1),
    Interval(0x000b7,0x000b7),
    Interval(0x000bf,0x000bf),
    Interval(0x0037e,0x0037e),
    Interval(0x00387,0x00387),
    Interval(0x0055a,0x0055f),
    Interval(0x00589,0x00589),
    Interval(0x005c0,0x005c0),
    Interval(0x005c3,0x005c3),
    Interval(0x005c6,0x005c6),
    Interval(0x005f3,0x005f4),
    Interval(0x00609,0x0060a),
    Interval(0x0060c,0x0060d),
    Interval(0x0061b,0x0061b),
    Interval(0x0061e,0x0061f),
    Interval(0x0066a,0x0066d),
    Interval(0x006d4,0x006d4),
    Interval(0x00700,0x0070d),
    Interval(0x007f7,0x007f9),
    Interval(0x00830,0x0083e),
    Interval(0x0085e,0x0085e),
    Interval(0x00964,0x00965),
    Interval(0x00970,0x00970),
    Interval(0x00df4,0x00df4),
    Interval(0x00e4f,0x00e4f),
    Interval(0x00e5a,0x00e5b),
    Interval(0x00f04,0x00f12),
    Interval(0x00f85,0x00f85),
    Interval(0x00fd0,0x00fd4),
    Interval(0x00fd9,0x00fda),
    Interval(0x0104a,0x0104f),
    Interval(0x010fb,0x010fb),
    Interval(0x01361,0x01368),
    Interval(0x0166d,0x0166e),
    Interval(0x016eb,0x016ed),
    Interval(0x01735,0x01736),
    Interval(0x017d4,0x017d6),
    Interval(0x017d8,0x017da),
    Interval(0x01800,0x01805),
    Interval(0x01807,0x0180a),
    Interval(0x01944,0x01945),
    Interval(0x01a1e,0x01a1f),
    Interval(0x01aa0,0x01aa6),
    Interval(0x01aa8,0x01aad),
    Interval(0x01b5a,0x01b60),
    Interval(0x01bfc,0x01bff),
    Interval(0x01c3b,0x01c3f),
    Interval(0x01c7e,0x01c7f),
    Interval(0x01cd3,0x01cd3),
    Interval(0x02016,0x02017),
    Interval(0x02020,0x02027),
    Interval(0x02030,0x02038),
    Interval(0x0203b,0x0203e),
    Interval(0x02041,0x02043),
    Interval(0x02047,0x02051),
    Interval(0x02053,0x02053),
    Interval(0x02055,0x0205e),
    Interval(0x02cf9,0x02cfc),
    Interval(0x02cfe,0x02cff),
    Interval(0x02d70,0x02d70),
    Interval(0x02e00,0x02e01),
    Interval(0x02e06,0x02e08),
    Interval(0x02e0b,0x02e0b),
    Interval(0x02e0e,0x02e16),
    Interval(0x02e18,0x02e19),
    Interval(0x02e1b,0x02e1b),
    Interval(0x02e1e,0x02e1f),
    Interval(0x02e2a,0x02e2e),
    Interval(0x02e30,0x02e31),
    Interval(0x03001,0x03003),
    Interval(0x0303d,0x0303d),
    Interval(0x030fb,0x030fb),
    Interval(0x0a4fe,0x0a4ff),
    Interval(0x0a60d,0x0a60f),
    Interval(0x0a673,0x0a673),
    Interval(0x0a67e,0x0a67e),
    Interval(0x0a6f2,0x0a6f7),
    Interval(0x0a874,0x0a877),
    Interval(0x0a8ce,0x0a8cf),
    Interval(0x0a8f8,0x0a8fa),
    Interval(0x0a92e,0x0a92f),
    Interval(0x0a95f,0x0a95f),
    Interval(0x0a9c1,0x0a9cd),
    Interval(0x0a9de,0x0a9df),
    Interval(0x0aa5c,0x0aa5f),
    Interval(0x0aade,0x0aadf),
    Interval(0x0abeb,0x0abeb),
    Interval(0x0fe10,0x0fe16),
    Interval(0x0fe19,0x0fe19),
    Interval(0x0fe30,0x0fe30),
    Interval(0x0fe45,0x0fe46),
    Interval(0x0fe49,0x0fe4c),
    Interval(0x0fe50,0x0fe52),
    Interval(0x0fe54,0x0fe57),
    Interval(0x0fe5f,0x0fe61),
    Interval(0x0fe68,0x0fe68),
    Interval(0x0fe6a,0x0fe6b),
    Interval(0x0ff01,0x0ff03),
    Interval(0x0ff05,0x0ff07),
    Interval(0x0ff0a,0x0ff0a),
    Interval(0x0ff0c,0x0ff0c),
    Interval(0x0ff0e,0x0ff0f),
    Interval(0x0ff1a,0x0ff1b),
    Interval(0x0ff1f,0x0ff20),
    Interval(0x0ff3c,0x0ff3c),
    Interval(0x0ff61,0x0ff61),
    Interval(0x0ff64,0x0ff65),
    Interval(0x10100,0x10101),
    Interval(0x1039f,0x1039f),
    Interval(0x103d0,0x103d0),
    Interval(0x10857,0x10857),
    Interval(0x1091f,0x1091f),
    Interval(0x1093f,0x1093f),
    Interval(0x10a50,0x10a58),
    Interval(0x10a7f,0x10a7f),
    Interval(0x10b39,0x10b3f),
    Interval(0x11047,0x1104d),
    Interval(0x110bb,0x110bc),
    Interval(0x110be,0x110c1),
    Interval(0x12470,0x12473),
]);

immutable(Charset) unicodeTerminal_Punctuation = Charset([
    Interval(0x00021,0x00021),
    Interval(0x0002c,0x0002c),
    Interval(0x0002e,0x0002e),
    Interval(0x0003a,0x0003b),
    Interval(0x0003f,0x0003f),
    Interval(0x0037e,0x0037e),
    Interval(0x00387,0x00387),
    Interval(0x00589,0x00589),
    Interval(0x005c3,0x005c3),
    Interval(0x0060c,0x0060c),
    Interval(0x0061b,0x0061b),
    Interval(0x0061f,0x0061f),
    Interval(0x006d4,0x006d4),
    Interval(0x00700,0x0070a),
    Interval(0x0070c,0x0070c),
    Interval(0x007f8,0x007f9),
    Interval(0x00830,0x0083e),
    Interval(0x0085e,0x0085e),
    Interval(0x00964,0x00965),
    Interval(0x00e5a,0x00e5b),
    Interval(0x00f08,0x00f08),
    Interval(0x00f0d,0x00f12),
    Interval(0x0104a,0x0104b),
    Interval(0x01361,0x01368),
    Interval(0x0166d,0x0166e),
    Interval(0x016eb,0x016ed),
    Interval(0x017d4,0x017d6),
    Interval(0x017da,0x017da),
    Interval(0x01802,0x01805),
    Interval(0x01808,0x01809),
    Interval(0x01944,0x01945),
    Interval(0x01aa8,0x01aab),
    Interval(0x01b5a,0x01b5b),
    Interval(0x01b5d,0x01b5f),
    Interval(0x01c3b,0x01c3f),
    Interval(0x01c7e,0x01c7f),
    Interval(0x0203c,0x0203d),
    Interval(0x02047,0x02049),
    Interval(0x02e2e,0x02e2e),
    Interval(0x03001,0x03002),
    Interval(0x0a4fe,0x0a4ff),
    Interval(0x0a60d,0x0a60f),
    Interval(0x0a6f3,0x0a6f7),
    Interval(0x0a876,0x0a877),
    Interval(0x0a8ce,0x0a8cf),
    Interval(0x0a92f,0x0a92f),
    Interval(0x0a9c7,0x0a9c9),
    Interval(0x0aa5d,0x0aa5f),
    Interval(0x0aadf,0x0aadf),
    Interval(0x0abeb,0x0abeb),
    Interval(0x0fe50,0x0fe52),
    Interval(0x0fe54,0x0fe57),
    Interval(0x0ff01,0x0ff01),
    Interval(0x0ff0c,0x0ff0c),
    Interval(0x0ff0e,0x0ff0e),
    Interval(0x0ff1a,0x0ff1b),
    Interval(0x0ff1f,0x0ff1f),
    Interval(0x0ff61,0x0ff61),
    Interval(0x0ff64,0x0ff64),
    Interval(0x1039f,0x1039f),
    Interval(0x103d0,0x103d0),
    Interval(0x10857,0x10857),
    Interval(0x1091f,0x1091f),
    Interval(0x10b3a,0x10b3f),
    Interval(0x11047,0x1104d),
    Interval(0x110be,0x110c1),
    Interval(0x12470,0x12473),
]);

immutable(Charset) unicodePs = Charset([
    Interval(0x00028,0x00028),
    Interval(0x0005b,0x0005b),
    Interval(0x0007b,0x0007b),
    Interval(0x00f3a,0x00f3a),
    Interval(0x00f3c,0x00f3c),
    Interval(0x0169b,0x0169b),
    Interval(0x0201a,0x0201a),
    Interval(0x0201e,0x0201e),
    Interval(0x02045,0x02045),
    Interval(0x0207d,0x0207d),
    Interval(0x0208d,0x0208d),
    Interval(0x02329,0x02329),
    Interval(0x02768,0x02768),
    Interval(0x0276a,0x0276a),
    Interval(0x0276c,0x0276c),
    Interval(0x0276e,0x0276e),
    Interval(0x02770,0x02770),
    Interval(0x02772,0x02772),
    Interval(0x02774,0x02774),
    Interval(0x027c5,0x027c5),
    Interval(0x027e6,0x027e6),
    Interval(0x027e8,0x027e8),
    Interval(0x027ea,0x027ea),
    Interval(0x027ec,0x027ec),
    Interval(0x027ee,0x027ee),
    Interval(0x02983,0x02983),
    Interval(0x02985,0x02985),
    Interval(0x02987,0x02987),
    Interval(0x02989,0x02989),
    Interval(0x0298b,0x0298b),
    Interval(0x0298d,0x0298d),
    Interval(0x0298f,0x0298f),
    Interval(0x02991,0x02991),
    Interval(0x02993,0x02993),
    Interval(0x02995,0x02995),
    Interval(0x02997,0x02997),
    Interval(0x029d8,0x029d8),
    Interval(0x029da,0x029da),
    Interval(0x029fc,0x029fc),
    Interval(0x02e22,0x02e22),
    Interval(0x02e24,0x02e24),
    Interval(0x02e26,0x02e26),
    Interval(0x02e28,0x02e28),
    Interval(0x03008,0x03008),
    Interval(0x0300a,0x0300a),
    Interval(0x0300c,0x0300c),
    Interval(0x0300e,0x0300e),
    Interval(0x03010,0x03010),
    Interval(0x03014,0x03014),
    Interval(0x03016,0x03016),
    Interval(0x03018,0x03018),
    Interval(0x0301a,0x0301a),
    Interval(0x0301d,0x0301d),
    Interval(0x0fd3e,0x0fd3e),
    Interval(0x0fe17,0x0fe17),
    Interval(0x0fe35,0x0fe35),
    Interval(0x0fe37,0x0fe37),
    Interval(0x0fe39,0x0fe39),
    Interval(0x0fe3b,0x0fe3b),
    Interval(0x0fe3d,0x0fe3d),
    Interval(0x0fe3f,0x0fe3f),
    Interval(0x0fe41,0x0fe41),
    Interval(0x0fe43,0x0fe43),
    Interval(0x0fe47,0x0fe47),
    Interval(0x0fe59,0x0fe59),
    Interval(0x0fe5b,0x0fe5b),
    Interval(0x0fe5d,0x0fe5d),
    Interval(0x0ff08,0x0ff08),
    Interval(0x0ff3b,0x0ff3b),
    Interval(0x0ff5b,0x0ff5b),
    Interval(0x0ff5f,0x0ff5f),
    Interval(0x0ff62,0x0ff62),
]);

immutable(Charset) unicodeInSpacing_Modifier_Letters = Charset([
    Interval(0x002b0,0x002ff),
]);

immutable(Charset) unicodeOther_Alphabetic = Charset([
    Interval(0x00345,0x00345),
    Interval(0x005b0,0x005bd),
    Interval(0x005bf,0x005bf),
    Interval(0x005c1,0x005c2),
    Interval(0x005c4,0x005c5),
    Interval(0x005c7,0x005c7),
    Interval(0x00610,0x0061a),
    Interval(0x0064b,0x00657),
    Interval(0x00659,0x0065f),
    Interval(0x00670,0x00670),
    Interval(0x006d6,0x006dc),
    Interval(0x006e1,0x006e4),
    Interval(0x006e7,0x006e8),
    Interval(0x006ed,0x006ed),
    Interval(0x00711,0x00711),
    Interval(0x00730,0x0073f),
    Interval(0x007a6,0x007b0),
    Interval(0x00816,0x00817),
    Interval(0x0081b,0x00823),
    Interval(0x00825,0x00827),
    Interval(0x00829,0x0082c),
    Interval(0x00900,0x00903),
    Interval(0x0093a,0x0093b),
    Interval(0x0093e,0x0094c),
    Interval(0x0094e,0x0094f),
    Interval(0x00955,0x00957),
    Interval(0x00962,0x00963),
    Interval(0x00981,0x00983),
    Interval(0x009be,0x009c4),
    Interval(0x009c7,0x009c8),
    Interval(0x009cb,0x009cc),
    Interval(0x009d7,0x009d7),
    Interval(0x009e2,0x009e3),
    Interval(0x00a01,0x00a03),
    Interval(0x00a3e,0x00a42),
    Interval(0x00a47,0x00a48),
    Interval(0x00a4b,0x00a4c),
    Interval(0x00a51,0x00a51),
    Interval(0x00a70,0x00a71),
    Interval(0x00a75,0x00a75),
    Interval(0x00a81,0x00a83),
    Interval(0x00abe,0x00ac5),
    Interval(0x00ac7,0x00ac9),
    Interval(0x00acb,0x00acc),
    Interval(0x00ae2,0x00ae3),
    Interval(0x00b01,0x00b03),
    Interval(0x00b3e,0x00b44),
    Interval(0x00b47,0x00b48),
    Interval(0x00b4b,0x00b4c),
    Interval(0x00b56,0x00b57),
    Interval(0x00b62,0x00b63),
    Interval(0x00b82,0x00b82),
    Interval(0x00bbe,0x00bc2),
    Interval(0x00bc6,0x00bc8),
    Interval(0x00bca,0x00bcc),
    Interval(0x00bd7,0x00bd7),
    Interval(0x00c01,0x00c03),
    Interval(0x00c3e,0x00c44),
    Interval(0x00c46,0x00c48),
    Interval(0x00c4a,0x00c4c),
    Interval(0x00c55,0x00c56),
    Interval(0x00c62,0x00c63),
    Interval(0x00c82,0x00c83),
    Interval(0x00cbe,0x00cc4),
    Interval(0x00cc6,0x00cc8),
    Interval(0x00cca,0x00ccc),
    Interval(0x00cd5,0x00cd6),
    Interval(0x00ce2,0x00ce3),
    Interval(0x00d02,0x00d03),
    Interval(0x00d3e,0x00d44),
    Interval(0x00d46,0x00d48),
    Interval(0x00d4a,0x00d4c),
    Interval(0x00d57,0x00d57),
    Interval(0x00d62,0x00d63),
    Interval(0x00d82,0x00d83),
    Interval(0x00dcf,0x00dd4),
    Interval(0x00dd6,0x00dd6),
    Interval(0x00dd8,0x00ddf),
    Interval(0x00df2,0x00df3),
    Interval(0x00e31,0x00e31),
    Interval(0x00e34,0x00e3a),
    Interval(0x00e4d,0x00e4d),
    Interval(0x00eb1,0x00eb1),
    Interval(0x00eb4,0x00eb9),
    Interval(0x00ebb,0x00ebc),
    Interval(0x00ecd,0x00ecd),
    Interval(0x00f71,0x00f81),
    Interval(0x00f8d,0x00f97),
    Interval(0x00f99,0x00fbc),
    Interval(0x0102b,0x01036),
    Interval(0x01038,0x01038),
    Interval(0x0103b,0x0103e),
    Interval(0x01056,0x01059),
    Interval(0x0105e,0x01060),
    Interval(0x01062,0x01062),
    Interval(0x01067,0x01068),
    Interval(0x01071,0x01074),
    Interval(0x01082,0x01086),
    Interval(0x0109c,0x0109d),
    Interval(0x0135f,0x0135f),
    Interval(0x01712,0x01713),
    Interval(0x01732,0x01733),
    Interval(0x01752,0x01753),
    Interval(0x01772,0x01773),
    Interval(0x017b6,0x017c8),
    Interval(0x018a9,0x018a9),
    Interval(0x01920,0x0192b),
    Interval(0x01930,0x01938),
    Interval(0x019b0,0x019c0),
    Interval(0x019c8,0x019c9),
    Interval(0x01a17,0x01a1b),
    Interval(0x01a55,0x01a5e),
    Interval(0x01a61,0x01a74),
    Interval(0x01b00,0x01b04),
    Interval(0x01b35,0x01b43),
    Interval(0x01b80,0x01b82),
    Interval(0x01ba1,0x01ba9),
    Interval(0x01be7,0x01bf1),
    Interval(0x01c24,0x01c35),
    Interval(0x01cf2,0x01cf2),
    Interval(0x024b6,0x024e9),
    Interval(0x02de0,0x02dff),
    Interval(0x0a823,0x0a827),
    Interval(0x0a880,0x0a881),
    Interval(0x0a8b4,0x0a8c3),
    Interval(0x0a926,0x0a92a),
    Interval(0x0a947,0x0a952),
    Interval(0x0a980,0x0a983),
    Interval(0x0a9b4,0x0a9bf),
    Interval(0x0aa29,0x0aa36),
    Interval(0x0aa43,0x0aa43),
    Interval(0x0aa4c,0x0aa4d),
    Interval(0x0aab0,0x0aab0),
    Interval(0x0aab2,0x0aab4),
    Interval(0x0aab7,0x0aab8),
    Interval(0x0aabe,0x0aabe),
    Interval(0x0abe3,0x0abea),
    Interval(0x0fb1e,0x0fb1e),
    Interval(0x10a01,0x10a03),
    Interval(0x10a05,0x10a06),
    Interval(0x10a0c,0x10a0f),
    Interval(0x11000,0x11002),
    Interval(0x11038,0x11045),
    Interval(0x11082,0x11082),
    Interval(0x110b0,0x110b8),
]);

immutable(Charset) unicodeLepcha = Charset([
    Interval(0x01c00,0x01c37),
    Interval(0x01c3b,0x01c49),
    Interval(0x01c4d,0x01c4f),
]);

immutable(Charset) unicodeKayah_Li = Charset([
    Interval(0x0a900,0x0a92f),
]);

immutable(Charset) unicodeInCounting_Rod_Numerals = Charset([
    Interval(0x1d360,0x1d37f),
]);

immutable(Charset) unicodeNko = Charset([
    Interval(0x007c0,0x007fa),
]);

immutable(Charset) unicodeInOld_Turkic = Charset([
    Interval(0x10c00,0x10c4f),
]);

immutable(Charset) unicodeInMiscellaneous_Symbols_And_Pictographs = Charset([
    Interval(0x1f300,0x1f5ff),
]);

immutable(Charset) unicodeInLao = Charset([
    Interval(0x00e80,0x00eff),
]);

immutable(Charset) unicodeInNKo = Charset([
    Interval(0x007c0,0x007ff),
]);

immutable(Charset) unicodeInGreek_and_Coptic = Charset([
    Interval(0x00370,0x003ff),
]);

immutable(Charset) unicodePhags_Pa = Charset([
    Interval(0x0a840,0x0a877),
]);

immutable(Charset) unicodeCypriot = Charset([
    Interval(0x10800,0x10805),
    Interval(0x10808,0x10808),
    Interval(0x1080a,0x10835),
    Interval(0x10837,0x10838),
    Interval(0x1083c,0x1083c),
    Interval(0x1083f,0x1083f),
]);

immutable(Charset) unicodeInModifier_Tone_Letters = Charset([
    Interval(0x0a700,0x0a71f),
]);

immutable(Charset) unicodeTamil = Charset([
    Interval(0x00b82,0x00b83),
    Interval(0x00b85,0x00b8a),
    Interval(0x00b8e,0x00b90),
    Interval(0x00b92,0x00b95),
    Interval(0x00b99,0x00b9a),
    Interval(0x00b9c,0x00b9c),
    Interval(0x00b9e,0x00b9f),
    Interval(0x00ba3,0x00ba4),
    Interval(0x00ba8,0x00baa),
    Interval(0x00bae,0x00bb9),
    Interval(0x00bbe,0x00bc2),
    Interval(0x00bc6,0x00bc8),
    Interval(0x00bca,0x00bcd),
    Interval(0x00bd0,0x00bd0),
    Interval(0x00bd7,0x00bd7),
    Interval(0x00be6,0x00bfa),
]);

immutable(Charset) unicodeMyanmar = Charset([
    Interval(0x01000,0x0109f),
    Interval(0x0aa60,0x0aa7b),
]);

immutable(Charset) unicodeSc = Charset([
    Interval(0x00024,0x00024),
    Interval(0x000a2,0x000a5),
    Interval(0x0060b,0x0060b),
    Interval(0x009f2,0x009f3),
    Interval(0x009fb,0x009fb),
    Interval(0x00af1,0x00af1),
    Interval(0x00bf9,0x00bf9),
    Interval(0x00e3f,0x00e3f),
    Interval(0x017db,0x017db),
    Interval(0x020a0,0x020b9),
    Interval(0x0a838,0x0a838),
    Interval(0x0fdfc,0x0fdfc),
    Interval(0x0fe69,0x0fe69),
    Interval(0x0ff04,0x0ff04),
    Interval(0x0ffe0,0x0ffe1),
    Interval(0x0ffe5,0x0ffe6),
]);

immutable(Charset) unicodeInPrivate_Use_Area = Charset([
    Interval(0x0e000,0x0f8ff),
]);

immutable(Charset) unicodeKannada = Charset([
    Interval(0x00c82,0x00c83),
    Interval(0x00c85,0x00c8c),
    Interval(0x00c8e,0x00c90),
    Interval(0x00c92,0x00ca8),
    Interval(0x00caa,0x00cb3),
    Interval(0x00cb5,0x00cb9),
    Interval(0x00cbc,0x00cc4),
    Interval(0x00cc6,0x00cc8),
    Interval(0x00cca,0x00ccd),
    Interval(0x00cd5,0x00cd6),
    Interval(0x00cde,0x00cde),
    Interval(0x00ce0,0x00ce3),
    Interval(0x00ce6,0x00cef),
    Interval(0x00cf1,0x00cf2),
]);

immutable(Charset) unicodeInPhonetic_Extensions = Charset([
    Interval(0x01d00,0x01d7f),
]);

immutable(Charset) unicodeInEgyptian_Hieroglyphs = Charset([
    Interval(0x13000,0x1342f),
]);

immutable(Charset) unicodeTelugu = Charset([
    Interval(0x00c01,0x00c03),
    Interval(0x00c05,0x00c0c),
    Interval(0x00c0e,0x00c10),
    Interval(0x00c12,0x00c28),
    Interval(0x00c2a,0x00c33),
    Interval(0x00c35,0x00c39),
    Interval(0x00c3d,0x00c44),
    Interval(0x00c46,0x00c48),
    Interval(0x00c4a,0x00c4d),
    Interval(0x00c55,0x00c56),
    Interval(0x00c58,0x00c59),
    Interval(0x00c60,0x00c63),
    Interval(0x00c66,0x00c6f),
    Interval(0x00c78,0x00c7f),
]);

immutable(Charset) unicodeInCombining_Diacritical_Marks = Charset([
    Interval(0x00300,0x0036f),
]);

immutable(Charset) unicodeCham = Charset([
    Interval(0x0aa00,0x0aa36),
    Interval(0x0aa40,0x0aa4d),
    Interval(0x0aa50,0x0aa59),
    Interval(0x0aa5c,0x0aa5f),
]);

immutable(Charset) unicodeInArabic_Supplement = Charset([
    Interval(0x00750,0x0077f),
]);

immutable(Charset) unicodeSk = Charset([
    Interval(0x0005e,0x0005e),
    Interval(0x00060,0x00060),
    Interval(0x000a8,0x000a8),
    Interval(0x000af,0x000af),
    Interval(0x000b4,0x000b4),
    Interval(0x000b8,0x000b8),
    Interval(0x002c2,0x002c5),
    Interval(0x002d2,0x002df),
    Interval(0x002e5,0x002eb),
    Interval(0x002ed,0x002ed),
    Interval(0x002ef,0x002ff),
    Interval(0x00375,0x00375),
    Interval(0x00384,0x00385),
    Interval(0x01fbd,0x01fbd),
    Interval(0x01fbf,0x01fc1),
    Interval(0x01fcd,0x01fcf),
    Interval(0x01fdd,0x01fdf),
    Interval(0x01fed,0x01fef),
    Interval(0x01ffd,0x01ffe),
    Interval(0x0309b,0x0309c),
    Interval(0x0a700,0x0a716),
    Interval(0x0a720,0x0a721),
    Interval(0x0a789,0x0a78a),
    Interval(0x0fbb2,0x0fbc1),
    Interval(0x0ff3e,0x0ff3e),
    Interval(0x0ff40,0x0ff40),
    Interval(0x0ffe3,0x0ffe3),
]);

immutable(Charset) unicodeImperial_Aramaic = Charset([
    Interval(0x10840,0x10855),
    Interval(0x10857,0x1085f),
]);

immutable(Charset) unicodeSm = Charset([
    Interval(0x0002b,0x0002b),
    Interval(0x0003c,0x0003e),
    Interval(0x0007c,0x0007c),
    Interval(0x0007e,0x0007e),
    Interval(0x000ac,0x000ac),
    Interval(0x000b1,0x000b1),
    Interval(0x000d7,0x000d7),
    Interval(0x000f7,0x000f7),
    Interval(0x003f6,0x003f6),
    Interval(0x00606,0x00608),
    Interval(0x02044,0x02044),
    Interval(0x02052,0x02052),
    Interval(0x0207a,0x0207c),
    Interval(0x0208a,0x0208c),
    Interval(0x02118,0x02118),
    Interval(0x02140,0x02144),
    Interval(0x0214b,0x0214b),
    Interval(0x02190,0x02194),
    Interval(0x0219a,0x0219b),
    Interval(0x021a0,0x021a0),
    Interval(0x021a3,0x021a3),
    Interval(0x021a6,0x021a6),
    Interval(0x021ae,0x021ae),
    Interval(0x021ce,0x021cf),
    Interval(0x021d2,0x021d2),
    Interval(0x021d4,0x021d4),
    Interval(0x021f4,0x022ff),
    Interval(0x02308,0x0230b),
    Interval(0x02320,0x02321),
    Interval(0x0237c,0x0237c),
    Interval(0x0239b,0x023b3),
    Interval(0x023dc,0x023e1),
    Interval(0x025b7,0x025b7),
    Interval(0x025c1,0x025c1),
    Interval(0x025f8,0x025ff),
    Interval(0x0266f,0x0266f),
    Interval(0x027c0,0x027c4),
    Interval(0x027c7,0x027ca),
    Interval(0x027cc,0x027cc),
    Interval(0x027ce,0x027e5),
    Interval(0x027f0,0x027ff),
    Interval(0x02900,0x02982),
    Interval(0x02999,0x029d7),
    Interval(0x029dc,0x029fb),
    Interval(0x029fe,0x02aff),
    Interval(0x02b30,0x02b44),
    Interval(0x02b47,0x02b4c),
    Interval(0x0fb29,0x0fb29),
    Interval(0x0fe62,0x0fe62),
    Interval(0x0fe64,0x0fe66),
    Interval(0x0ff0b,0x0ff0b),
    Interval(0x0ff1c,0x0ff1e),
    Interval(0x0ff5c,0x0ff5c),
    Interval(0x0ff5e,0x0ff5e),
    Interval(0x0ffe2,0x0ffe2),
    Interval(0x0ffe9,0x0ffec),
    Interval(0x1d6c1,0x1d6c1),
    Interval(0x1d6db,0x1d6db),
    Interval(0x1d6fb,0x1d6fb),
    Interval(0x1d715,0x1d715),
    Interval(0x1d735,0x1d735),
    Interval(0x1d74f,0x1d74f),
    Interval(0x1d76f,0x1d76f),
    Interval(0x1d789,0x1d789),
    Interval(0x1d7a9,0x1d7a9),
    Interval(0x1d7c3,0x1d7c3),
]);

immutable(Charset) unicodeKharoshthi = Charset([
    Interval(0x10a00,0x10a03),
    Interval(0x10a05,0x10a06),
    Interval(0x10a0c,0x10a13),
    Interval(0x10a15,0x10a17),
    Interval(0x10a19,0x10a33),
    Interval(0x10a38,0x10a3a),
    Interval(0x10a3f,0x10a47),
    Interval(0x10a50,0x10a58),
]);

immutable(Charset) unicodeInLycian = Charset([
    Interval(0x10280,0x1029f),
]);

immutable(Charset) unicodeInCombining_Half_Marks = Charset([
    Interval(0x0fe20,0x0fe2f),
]);

immutable(Charset) unicodeSo = Charset([
    Interval(0x000a6,0x000a7),
    Interval(0x000a9,0x000a9),
    Interval(0x000ae,0x000ae),
    Interval(0x000b0,0x000b0),
    Interval(0x000b6,0x000b6),
    Interval(0x00482,0x00482),
    Interval(0x0060e,0x0060f),
    Interval(0x006de,0x006de),
    Interval(0x006e9,0x006e9),
    Interval(0x006fd,0x006fe),
    Interval(0x007f6,0x007f6),
    Interval(0x009fa,0x009fa),
    Interval(0x00b70,0x00b70),
    Interval(0x00bf3,0x00bf8),
    Interval(0x00bfa,0x00bfa),
    Interval(0x00c7f,0x00c7f),
    Interval(0x00d79,0x00d79),
    Interval(0x00f01,0x00f03),
    Interval(0x00f13,0x00f17),
    Interval(0x00f1a,0x00f1f),
    Interval(0x00f34,0x00f34),
    Interval(0x00f36,0x00f36),
    Interval(0x00f38,0x00f38),
    Interval(0x00fbe,0x00fc5),
    Interval(0x00fc7,0x00fcc),
    Interval(0x00fce,0x00fcf),
    Interval(0x00fd5,0x00fd8),
    Interval(0x0109e,0x0109f),
    Interval(0x01360,0x01360),
    Interval(0x01390,0x01399),
    Interval(0x01940,0x01940),
    Interval(0x019de,0x019ff),
    Interval(0x01b61,0x01b6a),
    Interval(0x01b74,0x01b7c),
    Interval(0x02100,0x02101),
    Interval(0x02103,0x02106),
    Interval(0x02108,0x02109),
    Interval(0x02114,0x02114),
    Interval(0x02116,0x02117),
    Interval(0x0211e,0x02123),
    Interval(0x02125,0x02125),
    Interval(0x02127,0x02127),
    Interval(0x02129,0x02129),
    Interval(0x0212e,0x0212e),
    Interval(0x0213a,0x0213b),
    Interval(0x0214a,0x0214a),
    Interval(0x0214c,0x0214d),
    Interval(0x0214f,0x0214f),
    Interval(0x02195,0x02199),
    Interval(0x0219c,0x0219f),
    Interval(0x021a1,0x021a2),
    Interval(0x021a4,0x021a5),
    Interval(0x021a7,0x021ad),
    Interval(0x021af,0x021cd),
    Interval(0x021d0,0x021d1),
    Interval(0x021d3,0x021d3),
    Interval(0x021d5,0x021f3),
    Interval(0x02300,0x02307),
    Interval(0x0230c,0x0231f),
    Interval(0x02322,0x02328),
    Interval(0x0232b,0x0237b),
    Interval(0x0237d,0x0239a),
    Interval(0x023b4,0x023db),
    Interval(0x023e2,0x023f3),
    Interval(0x02400,0x02426),
    Interval(0x02440,0x0244a),
    Interval(0x0249c,0x024e9),
    Interval(0x02500,0x025b6),
    Interval(0x025b8,0x025c0),
    Interval(0x025c2,0x025f7),
    Interval(0x02600,0x0266e),
    Interval(0x02670,0x026ff),
    Interval(0x02701,0x02767),
    Interval(0x02794,0x027bf),
    Interval(0x02800,0x028ff),
    Interval(0x02b00,0x02b2f),
    Interval(0x02b45,0x02b46),
    Interval(0x02b50,0x02b59),
    Interval(0x02ce5,0x02cea),
    Interval(0x02e80,0x02e99),
    Interval(0x02e9b,0x02ef3),
    Interval(0x02f00,0x02fd5),
    Interval(0x02ff0,0x02ffb),
    Interval(0x03004,0x03004),
    Interval(0x03012,0x03013),
    Interval(0x03020,0x03020),
    Interval(0x03036,0x03037),
    Interval(0x0303e,0x0303f),
    Interval(0x03190,0x03191),
    Interval(0x03196,0x0319f),
    Interval(0x031c0,0x031e3),
    Interval(0x03200,0x0321e),
    Interval(0x0322a,0x03250),
    Interval(0x03260,0x0327f),
    Interval(0x0328a,0x032b0),
    Interval(0x032c0,0x032fe),
    Interval(0x03300,0x033ff),
    Interval(0x04dc0,0x04dff),
    Interval(0x0a490,0x0a4c6),
    Interval(0x0a828,0x0a82b),
    Interval(0x0a836,0x0a837),
    Interval(0x0a839,0x0a839),
    Interval(0x0aa77,0x0aa79),
    Interval(0x0fdfd,0x0fdfd),
    Interval(0x0ffe4,0x0ffe4),
    Interval(0x0ffe8,0x0ffe8),
    Interval(0x0ffed,0x0ffee),
    Interval(0x0fffc,0x0fffd),
    Interval(0x10102,0x10102),
    Interval(0x10137,0x1013f),
    Interval(0x10179,0x10189),
    Interval(0x10190,0x1019b),
    Interval(0x101d0,0x101fc),
    Interval(0x1d000,0x1d0f5),
    Interval(0x1d100,0x1d126),
    Interval(0x1d129,0x1d164),
    Interval(0x1d16a,0x1d16c),
    Interval(0x1d183,0x1d184),
    Interval(0x1d18c,0x1d1a9),
    Interval(0x1d1ae,0x1d1dd),
    Interval(0x1d200,0x1d241),
    Interval(0x1d245,0x1d245),
    Interval(0x1d300,0x1d356),
    Interval(0x1f000,0x1f02b),
    Interval(0x1f030,0x1f093),
    Interval(0x1f0a0,0x1f0ae),
    Interval(0x1f0b1,0x1f0be),
    Interval(0x1f0c1,0x1f0cf),
    Interval(0x1f0d1,0x1f0df),
    Interval(0x1f110,0x1f12e),
    Interval(0x1f130,0x1f169),
    Interval(0x1f170,0x1f19a),
    Interval(0x1f1e6,0x1f202),
    Interval(0x1f210,0x1f23a),
    Interval(0x1f240,0x1f248),
    Interval(0x1f250,0x1f251),
    Interval(0x1f300,0x1f320),
    Interval(0x1f330,0x1f335),
    Interval(0x1f337,0x1f37c),
    Interval(0x1f380,0x1f393),
    Interval(0x1f3a0,0x1f3c4),
    Interval(0x1f3c6,0x1f3ca),
    Interval(0x1f3e0,0x1f3f0),
    Interval(0x1f400,0x1f43e),
    Interval(0x1f440,0x1f440),
    Interval(0x1f442,0x1f4f7),
    Interval(0x1f4f9,0x1f4fc),
    Interval(0x1f500,0x1f53d),
    Interval(0x1f550,0x1f567),
    Interval(0x1f5fb,0x1f5ff),
    Interval(0x1f601,0x1f610),
    Interval(0x1f612,0x1f614),
    Interval(0x1f616,0x1f616),
    Interval(0x1f618,0x1f618),
    Interval(0x1f61a,0x1f61a),
    Interval(0x1f61c,0x1f61e),
    Interval(0x1f620,0x1f625),
    Interval(0x1f628,0x1f62b),
    Interval(0x1f62d,0x1f62d),
    Interval(0x1f630,0x1f633),
    Interval(0x1f635,0x1f640),
    Interval(0x1f645,0x1f64f),
    Interval(0x1f680,0x1f6c5),
    Interval(0x1f700,0x1f773),
]);

immutable(Charset) unicodeInEnclosed_Alphanumeric_Supplement = Charset([
    Interval(0x1f100,0x1f1ff),
]);

immutable(Charset) unicodeInTai_Le = Charset([
    Interval(0x01950,0x0197f),
]);

immutable(Charset) unicodeInMandaic = Charset([
    Interval(0x00840,0x0085f),
]);

immutable(Charset) unicodeInLepcha = Charset([
    Interval(0x01c00,0x01c4f),
]);

immutable(Charset) unicodeCanadian_Aboriginal = Charset([
    Interval(0x01400,0x0167f),
    Interval(0x018b0,0x018f5),
]);

immutable(Charset) unicodeInGreek_Extended = Charset([
    Interval(0x01f00,0x01fff),
]);

immutable(Charset) unicodeInCJK_Unified_Ideographs = Charset([
    Interval(0x04e00,0x09fff),
]);

immutable(Charset) unicodeIDS_Trinary_Operator = Charset([
    Interval(0x02ff2,0x02ff3),
]);

immutable(Charset) unicodeInMiscellaneous_Symbols = Charset([
    Interval(0x02600,0x026ff),
]);

immutable(Charset) unicodeLao = Charset([
    Interval(0x00e81,0x00e82),
    Interval(0x00e84,0x00e84),
    Interval(0x00e87,0x00e88),
    Interval(0x00e8a,0x00e8a),
    Interval(0x00e8d,0x00e8d),
    Interval(0x00e94,0x00e97),
    Interval(0x00e99,0x00e9f),
    Interval(0x00ea1,0x00ea3),
    Interval(0x00ea5,0x00ea5),
    Interval(0x00ea7,0x00ea7),
    Interval(0x00eaa,0x00eab),
    Interval(0x00ead,0x00eb9),
    Interval(0x00ebb,0x00ebd),
    Interval(0x00ec0,0x00ec4),
    Interval(0x00ec6,0x00ec6),
    Interval(0x00ec8,0x00ecd),
    Interval(0x00ed0,0x00ed9),
    Interval(0x00edc,0x00edd),
]);

immutable(Charset) unicodeInLatin_Extended_Additional = Charset([
    Interval(0x01e00,0x01eff),
]);

immutable(Charset) unicodeRadical = Charset([
    Interval(0x02e80,0x02e99),
    Interval(0x02e9b,0x02ef3),
    Interval(0x02f00,0x02fd5),
]);

immutable(Charset) unicodeMongolian = Charset([
    Interval(0x01800,0x01801),
    Interval(0x01804,0x01804),
    Interval(0x01806,0x0180e),
    Interval(0x01810,0x01819),
    Interval(0x01820,0x01877),
    Interval(0x01880,0x018aa),
]);

immutable(Charset) unicodeInVai = Charset([
    Interval(0x0a500,0x0a63f),
]);

immutable(Charset) unicodeBengali = Charset([
    Interval(0x00981,0x00983),
    Interval(0x00985,0x0098c),
    Interval(0x0098f,0x00990),
    Interval(0x00993,0x009a8),
    Interval(0x009aa,0x009b0),
    Interval(0x009b2,0x009b2),
    Interval(0x009b6,0x009b9),
    Interval(0x009bc,0x009c4),
    Interval(0x009c7,0x009c8),
    Interval(0x009cb,0x009ce),
    Interval(0x009d7,0x009d7),
    Interval(0x009dc,0x009dd),
    Interval(0x009df,0x009e3),
    Interval(0x009e6,0x009fb),
]);

immutable(Charset) unicodeLatin = Charset([
    Interval(0x00041,0x0005a),
    Interval(0x00061,0x0007a),
    Interval(0x000aa,0x000aa),
    Interval(0x000ba,0x000ba),
    Interval(0x000c0,0x000d6),
    Interval(0x000d8,0x000f6),
    Interval(0x000f8,0x002b8),
    Interval(0x002e0,0x002e4),
    Interval(0x01d00,0x01d25),
    Interval(0x01d2c,0x01d5c),
    Interval(0x01d62,0x01d65),
    Interval(0x01d6b,0x01d77),
    Interval(0x01d79,0x01dbe),
    Interval(0x01e00,0x01eff),
    Interval(0x02071,0x02071),
    Interval(0x0207f,0x0207f),
    Interval(0x02090,0x0209c),
    Interval(0x0212a,0x0212b),
    Interval(0x02132,0x02132),
    Interval(0x0214e,0x0214e),
    Interval(0x02160,0x02188),
    Interval(0x02c60,0x02c7f),
    Interval(0x0a722,0x0a787),
    Interval(0x0a78b,0x0a78e),
    Interval(0x0a790,0x0a791),
    Interval(0x0a7a0,0x0a7a9),
    Interval(0x0a7fa,0x0a7ff),
    Interval(0x0fb00,0x0fb06),
    Interval(0x0ff21,0x0ff3a),
    Interval(0x0ff41,0x0ff5a),
]);

immutable(Charset) unicodeTagalog = Charset([
    Interval(0x01700,0x0170c),
    Interval(0x0170e,0x01714),
]);

immutable(Charset) unicodeRejang = Charset([
    Interval(0x0a930,0x0a953),
    Interval(0x0a95f,0x0a95f),
]);

immutable(Charset) unicodeInCombining_Diacritical_Marks_for_Symbols = Charset([
    Interval(0x020d0,0x020ff),
]);

immutable(Charset) unicodeInSupplemental_Mathematical_Operators = Charset([
    Interval(0x02a00,0x02aff),
]);

immutable(Charset) unicodeInCham = Charset([
    Interval(0x0aa00,0x0aa5f),
]);

immutable(Charset) unicodeAvestan = Charset([
    Interval(0x10b00,0x10b35),
    Interval(0x10b39,0x10b3f),
]);

immutable(Charset) unicodeInMiscellaneous_Mathematical_Symbols_A = Charset([
    Interval(0x027c0,0x027ef),
]);

immutable(Charset) unicodeInMiscellaneous_Mathematical_Symbols_B = Charset([
    Interval(0x02980,0x029ff),
]);

immutable(Charset) unicodeInTelugu = Charset([
    Interval(0x00c00,0x00c7f),
]);

immutable(Charset) unicodeLimbu = Charset([
    Interval(0x01900,0x0191c),
    Interval(0x01920,0x0192b),
    Interval(0x01930,0x0193b),
    Interval(0x01940,0x01940),
    Interval(0x01944,0x0194f),
]);

immutable(Charset) unicodeInGeneral_Punctuation = Charset([
    Interval(0x02000,0x0206f),
]);

immutable(Charset) unicodeUnified_Ideograph = Charset([
    Interval(0x03400,0x04db5),
    Interval(0x04e00,0x09fcb),
    Interval(0x0fa0e,0x0fa0f),
    Interval(0x0fa11,0x0fa11),
    Interval(0x0fa13,0x0fa14),
    Interval(0x0fa1f,0x0fa1f),
    Interval(0x0fa21,0x0fa21),
    Interval(0x0fa23,0x0fa24),
    Interval(0x0fa27,0x0fa29),
    Interval(0x20000,0x2a6d6),
    Interval(0x2a700,0x2b734),
    Interval(0x2b740,0x2b81d),
]);

immutable(Charset) unicodeInPhoenician = Charset([
    Interval(0x10900,0x1091f),
]);

immutable(Charset) unicodeOld_South_Arabian = Charset([
    Interval(0x10a60,0x10a7f),
]);

immutable(Charset) unicodeInBuhid = Charset([
    Interval(0x01740,0x0175f),
]);

immutable(Charset) unicodeKhmer = Charset([
    Interval(0x01780,0x017dd),
    Interval(0x017e0,0x017e9),
    Interval(0x017f0,0x017f9),
    Interval(0x019e0,0x019ff),
]);

immutable(Charset) unicodeInLatin_Extended_A = Charset([
    Interval(0x00100,0x0017f),
]);

immutable(Charset) unicodeInLatin_Extended_B = Charset([
    Interval(0x00180,0x0024f),
]);

immutable(Charset) unicodeInLatin_Extended_C = Charset([
    Interval(0x02c60,0x02c7f),
]);

immutable(Charset) unicodeInLatin_Extended_D = Charset([
    Interval(0x0a720,0x0a7ff),
]);

immutable(Charset) unicodeGurmukhi = Charset([
    Interval(0x00a01,0x00a03),
    Interval(0x00a05,0x00a0a),
    Interval(0x00a0f,0x00a10),
    Interval(0x00a13,0x00a28),
    Interval(0x00a2a,0x00a30),
    Interval(0x00a32,0x00a33),
    Interval(0x00a35,0x00a36),
    Interval(0x00a38,0x00a39),
    Interval(0x00a3c,0x00a3c),
    Interval(0x00a3e,0x00a42),
    Interval(0x00a47,0x00a48),
    Interval(0x00a4b,0x00a4d),
    Interval(0x00a51,0x00a51),
    Interval(0x00a59,0x00a5c),
    Interval(0x00a5e,0x00a5e),
    Interval(0x00a66,0x00a75),
]);

immutable(Charset) unicodeInOsmanya = Charset([
    Interval(0x10480,0x104af),
]);

immutable(Charset) unicodeInCJK_Compatibility = Charset([
    Interval(0x03300,0x033ff),
]);

immutable(Charset) unicodeOriya = Charset([
    Interval(0x00b01,0x00b03),
    Interval(0x00b05,0x00b0c),
    Interval(0x00b0f,0x00b10),
    Interval(0x00b13,0x00b28),
    Interval(0x00b2a,0x00b30),
    Interval(0x00b32,0x00b33),
    Interval(0x00b35,0x00b39),
    Interval(0x00b3c,0x00b44),
    Interval(0x00b47,0x00b48),
    Interval(0x00b4b,0x00b4d),
    Interval(0x00b56,0x00b57),
    Interval(0x00b5c,0x00b5d),
    Interval(0x00b5f,0x00b63),
    Interval(0x00b66,0x00b77),
]);

immutable(Charset) unicodeBuginese = Charset([
    Interval(0x01a00,0x01a1b),
    Interval(0x01a1e,0x01a1f),
]);

immutable(Charset) unicodeInGeorgian_Supplement = Charset([
    Interval(0x02d00,0x02d2f),
]);

immutable(Charset) unicodeInCJK_Strokes = Charset([
    Interval(0x031c0,0x031ef),
]);

immutable(Charset) unicodeVai = Charset([
    Interval(0x0a500,0x0a62b),
]);

immutable(Charset) unicodeHangul = Charset([
    Interval(0x01100,0x011ff),
    Interval(0x0302e,0x0302f),
    Interval(0x03131,0x0318e),
    Interval(0x03200,0x0321e),
    Interval(0x03260,0x0327e),
    Interval(0x0a960,0x0a97c),
    Interval(0x0ac00,0x0d7a3),
    Interval(0x0d7b0,0x0d7c6),
    Interval(0x0d7cb,0x0d7fb),
    Interval(0x0ffa0,0x0ffbe),
    Interval(0x0ffc2,0x0ffc7),
    Interval(0x0ffca,0x0ffcf),
    Interval(0x0ffd2,0x0ffd7),
    Interval(0x0ffda,0x0ffdc),
]);

immutable(Charset) unicodeInRejang = Charset([
    Interval(0x0a930,0x0a95f),
]);

immutable(Charset) unicodeInMiscellaneous_Technical = Charset([
    Interval(0x02300,0x023ff),
]);

immutable(Charset) unicodeInTransport_And_Map_Symbols = Charset([
    Interval(0x1f680,0x1f6ff),
]);

immutable(Charset) unicodeHyphen = Charset([
    Interval(0x0002d,0x0002d),
    Interval(0x000ad,0x000ad),
    Interval(0x0058a,0x0058a),
    Interval(0x01806,0x01806),
    Interval(0x02010,0x02011),
    Interval(0x02e17,0x02e17),
    Interval(0x030fb,0x030fb),
    Interval(0x0fe63,0x0fe63),
    Interval(0x0ff0d,0x0ff0d),
    Interval(0x0ff65,0x0ff65),
]);

immutable(Charset) unicodeThai = Charset([
    Interval(0x00e01,0x00e3a),
    Interval(0x00e40,0x00e5b),
]);

immutable(Charset) unicodeSundanese = Charset([
    Interval(0x01b80,0x01baa),
    Interval(0x01bae,0x01bb9),
]);

immutable(Charset) unicodeInRunic = Charset([
    Interval(0x016a0,0x016ff),
]);

immutable(Charset) unicodeDiacritic = Charset([
    Interval(0x0005e,0x0005e),
    Interval(0x00060,0x00060),
    Interval(0x000a8,0x000a8),
    Interval(0x000af,0x000af),
    Interval(0x000b4,0x000b4),
    Interval(0x000b7,0x000b8),
    Interval(0x002b0,0x0034e),
    Interval(0x00350,0x00357),
    Interval(0x0035d,0x00362),
    Interval(0x00374,0x00375),
    Interval(0x0037a,0x0037a),
    Interval(0x00384,0x00385),
    Interval(0x00483,0x00487),
    Interval(0x00559,0x00559),
    Interval(0x00591,0x005a1),
    Interval(0x005a3,0x005bd),
    Interval(0x005bf,0x005bf),
    Interval(0x005c1,0x005c2),
    Interval(0x005c4,0x005c4),
    Interval(0x0064b,0x00652),
    Interval(0x00657,0x00658),
    Interval(0x006df,0x006e0),
    Interval(0x006e5,0x006e6),
    Interval(0x006ea,0x006ec),
    Interval(0x00730,0x0074a),
    Interval(0x007a6,0x007b0),
    Interval(0x007eb,0x007f5),
    Interval(0x00818,0x00819),
    Interval(0x0093c,0x0093c),
    Interval(0x0094d,0x0094d),
    Interval(0x00951,0x00954),
    Interval(0x00971,0x00971),
    Interval(0x009bc,0x009bc),
    Interval(0x009cd,0x009cd),
    Interval(0x00a3c,0x00a3c),
    Interval(0x00a4d,0x00a4d),
    Interval(0x00abc,0x00abc),
    Interval(0x00acd,0x00acd),
    Interval(0x00b3c,0x00b3c),
    Interval(0x00b4d,0x00b4d),
    Interval(0x00bcd,0x00bcd),
    Interval(0x00c4d,0x00c4d),
    Interval(0x00cbc,0x00cbc),
    Interval(0x00ccd,0x00ccd),
    Interval(0x00d4d,0x00d4d),
    Interval(0x00dca,0x00dca),
    Interval(0x00e47,0x00e4c),
    Interval(0x00e4e,0x00e4e),
    Interval(0x00ec8,0x00ecc),
    Interval(0x00f18,0x00f19),
    Interval(0x00f35,0x00f35),
    Interval(0x00f37,0x00f37),
    Interval(0x00f39,0x00f39),
    Interval(0x00f3e,0x00f3f),
    Interval(0x00f82,0x00f84),
    Interval(0x00f86,0x00f87),
    Interval(0x00fc6,0x00fc6),
    Interval(0x01037,0x01037),
    Interval(0x01039,0x0103a),
    Interval(0x01087,0x0108d),
    Interval(0x0108f,0x0108f),
    Interval(0x0109a,0x0109b),
    Interval(0x017c9,0x017d3),
    Interval(0x017dd,0x017dd),
    Interval(0x01939,0x0193b),
    Interval(0x01a75,0x01a7c),
    Interval(0x01a7f,0x01a7f),
    Interval(0x01b34,0x01b34),
    Interval(0x01b44,0x01b44),
    Interval(0x01b6b,0x01b73),
    Interval(0x01baa,0x01baa),
    Interval(0x01c36,0x01c37),
    Interval(0x01c78,0x01c7d),
    Interval(0x01cd0,0x01ce8),
    Interval(0x01ced,0x01ced),
    Interval(0x01d2c,0x01d6a),
    Interval(0x01dc4,0x01dcf),
    Interval(0x01dfd,0x01dff),
    Interval(0x01fbd,0x01fbd),
    Interval(0x01fbf,0x01fc1),
    Interval(0x01fcd,0x01fcf),
    Interval(0x01fdd,0x01fdf),
    Interval(0x01fed,0x01fef),
    Interval(0x01ffd,0x01ffe),
    Interval(0x02cef,0x02cf1),
    Interval(0x02e2f,0x02e2f),
    Interval(0x0302a,0x0302f),
    Interval(0x03099,0x0309c),
    Interval(0x030fc,0x030fc),
    Interval(0x0a66f,0x0a66f),
    Interval(0x0a67c,0x0a67d),
    Interval(0x0a67f,0x0a67f),
    Interval(0x0a6f0,0x0a6f1),
    Interval(0x0a717,0x0a721),
    Interval(0x0a788,0x0a788),
    Interval(0x0a8c4,0x0a8c4),
    Interval(0x0a8e0,0x0a8f1),
    Interval(0x0a92b,0x0a92e),
    Interval(0x0a953,0x0a953),
    Interval(0x0a9b3,0x0a9b3),
    Interval(0x0a9c0,0x0a9c0),
    Interval(0x0aa7b,0x0aa7b),
    Interval(0x0aabf,0x0aac2),
    Interval(0x0abec,0x0abed),
    Interval(0x0fb1e,0x0fb1e),
    Interval(0x0fe20,0x0fe26),
    Interval(0x0ff3e,0x0ff3e),
    Interval(0x0ff40,0x0ff40),
    Interval(0x0ff70,0x0ff70),
    Interval(0x0ff9e,0x0ff9f),
    Interval(0x0ffe3,0x0ffe3),
    Interval(0x110b9,0x110ba),
    Interval(0x1d167,0x1d169),
    Interval(0x1d16d,0x1d172),
    Interval(0x1d17b,0x1d182),
    Interval(0x1d185,0x1d18b),
    Interval(0x1d1aa,0x1d1ad),
]);

immutable(Charset) unicodeYi = Charset([
    Interval(0x0a000,0x0a48c),
    Interval(0x0a490,0x0a4c6),
]);

immutable(Charset) unicodeInAlphabetic_Presentation_Forms = Charset([
    Interval(0x0fb00,0x0fb4f),
]);

immutable(Charset) unicodeExtender = Charset([
    Interval(0x000b7,0x000b7),
    Interval(0x002d0,0x002d1),
    Interval(0x00640,0x00640),
    Interval(0x007fa,0x007fa),
    Interval(0x00e46,0x00e46),
    Interval(0x00ec6,0x00ec6),
    Interval(0x01843,0x01843),
    Interval(0x01aa7,0x01aa7),
    Interval(0x01c36,0x01c36),
    Interval(0x01c7b,0x01c7b),
    Interval(0x03005,0x03005),
    Interval(0x03031,0x03035),
    Interval(0x0309d,0x0309e),
    Interval(0x030fc,0x030fe),
    Interval(0x0a015,0x0a015),
    Interval(0x0a60c,0x0a60c),
    Interval(0x0a9cf,0x0a9cf),
    Interval(0x0aa70,0x0aa70),
    Interval(0x0aadd,0x0aadd),
    Interval(0x0ff70,0x0ff70),
]);

immutable(Charset) unicodeGlagolitic = Charset([
    Interval(0x02c00,0x02c2e),
    Interval(0x02c30,0x02c5e),
]);

immutable(Charset) unicodeInSuperscripts_and_Subscripts = Charset([
    Interval(0x02070,0x0209f),
]);

immutable(Charset) unicodeInMalayalam = Charset([
    Interval(0x00d00,0x00d7f),
]);

immutable(Charset) unicodeJoin_Control = Charset([
    Interval(0x0200c,0x0200d),
]);

immutable(Charset) unicodeInBatak = Charset([
    Interval(0x01bc0,0x01bff),
]);

immutable(Charset) unicodeThaana = Charset([
    Interval(0x00780,0x007b1),
]);

immutable(Charset) unicodeSoft_Dotted = Charset([
    Interval(0x00069,0x0006a),
    Interval(0x0012f,0x0012f),
    Interval(0x00249,0x00249),
    Interval(0x00268,0x00268),
    Interval(0x0029d,0x0029d),
    Interval(0x002b2,0x002b2),
    Interval(0x003f3,0x003f3),
    Interval(0x00456,0x00456),
    Interval(0x00458,0x00458),
    Interval(0x01d62,0x01d62),
    Interval(0x01d96,0x01d96),
    Interval(0x01da4,0x01da4),
    Interval(0x01da8,0x01da8),
    Interval(0x01e2d,0x01e2d),
    Interval(0x01ecb,0x01ecb),
    Interval(0x02071,0x02071),
    Interval(0x02148,0x02149),
    Interval(0x02c7c,0x02c7c),
    Interval(0x1d422,0x1d423),
    Interval(0x1d456,0x1d457),
    Interval(0x1d48a,0x1d48b),
    Interval(0x1d4be,0x1d4bf),
    Interval(0x1d4f2,0x1d4f3),
    Interval(0x1d526,0x1d527),
    Interval(0x1d55a,0x1d55b),
    Interval(0x1d58e,0x1d58f),
    Interval(0x1d5c2,0x1d5c3),
    Interval(0x1d5f6,0x1d5f7),
    Interval(0x1d62a,0x1d62b),
    Interval(0x1d65e,0x1d65f),
    Interval(0x1d692,0x1d693),
]);

immutable(Charset) unicodeBraille = Charset([
    Interval(0x02800,0x028ff),
]);

immutable(Charset) unicodeInGurmukhi = Charset([
    Interval(0x00a00,0x00a7f),
]);

immutable(Charset) unicodeMandaic = Charset([
    Interval(0x00840,0x0085b),
    Interval(0x0085e,0x0085e),
]);

immutable(Charset) unicodeInUnified_Canadian_Aboriginal_Syllabics = Charset([
    Interval(0x01400,0x0167f),
]);

immutable(Charset) unicodeInDingbats = Charset([
    Interval(0x02700,0x027bf),
]);

immutable(Charset) unicodeZl = Charset([
    Interval(0x02028,0x02028),
]);

immutable(Charset) unicodeInMusical_Symbols = Charset([
    Interval(0x1d100,0x1d1ff),
]);

immutable(Charset) unicodeInBuginese = Charset([
    Interval(0x01a00,0x01a1f),
]);

immutable(Charset) unicodeInSaurashtra = Charset([
    Interval(0x0a880,0x0a8df),
]);

immutable(Charset) unicodeInCJK_Symbols_and_Punctuation = Charset([
    Interval(0x03000,0x0303f),
]);

immutable(Charset) unicodeInKangxi_Radicals = Charset([
    Interval(0x02f00,0x02fdf),
]);

immutable(Charset) unicodeZp = Charset([
    Interval(0x02029,0x02029),
]);

immutable(Charset) unicodeHex_Digit = Charset([
    Interval(0x00030,0x00039),
    Interval(0x00041,0x00046),
    Interval(0x00061,0x00066),
    Interval(0x0ff10,0x0ff19),
    Interval(0x0ff21,0x0ff26),
    Interval(0x0ff41,0x0ff46),
]);

immutable(Charset) unicodeZs = Charset([
    Interval(0x00020,0x00020),
    Interval(0x000a0,0x000a0),
    Interval(0x01680,0x01680),
    Interval(0x0180e,0x0180e),
    Interval(0x02000,0x0200a),
    Interval(0x0202f,0x0202f),
    Interval(0x0205f,0x0205f),
    Interval(0x03000,0x03000),
]);

immutable(Charset) unicodeInThai = Charset([
    Interval(0x00e00,0x00e7f),
]);

immutable(Charset) unicodeDevanagari = Charset([
    Interval(0x00900,0x00950),
    Interval(0x00953,0x00963),
    Interval(0x00966,0x0096f),
    Interval(0x00971,0x00977),
    Interval(0x00979,0x0097f),
    Interval(0x0a8e0,0x0a8fb),
]);

immutable(Charset) unicodeInArrows = Charset([
    Interval(0x02190,0x021ff),
]);

immutable(Charset) unicodeEthiopic = Charset([
    Interval(0x01200,0x01248),
    Interval(0x0124a,0x0124d),
    Interval(0x01250,0x01256),
    Interval(0x01258,0x01258),
    Interval(0x0125a,0x0125d),
    Interval(0x01260,0x01288),
    Interval(0x0128a,0x0128d),
    Interval(0x01290,0x012b0),
    Interval(0x012b2,0x012b5),
    Interval(0x012b8,0x012be),
    Interval(0x012c0,0x012c0),
    Interval(0x012c2,0x012c5),
    Interval(0x012c8,0x012d6),
    Interval(0x012d8,0x01310),
    Interval(0x01312,0x01315),
    Interval(0x01318,0x0135a),
    Interval(0x0135d,0x0137c),
    Interval(0x01380,0x01399),
    Interval(0x02d80,0x02d96),
    Interval(0x02da0,0x02da6),
    Interval(0x02da8,0x02dae),
    Interval(0x02db0,0x02db6),
    Interval(0x02db8,0x02dbe),
    Interval(0x02dc0,0x02dc6),
    Interval(0x02dc8,0x02dce),
    Interval(0x02dd0,0x02dd6),
    Interval(0x02dd8,0x02dde),
    Interval(0x0ab01,0x0ab06),
    Interval(0x0ab09,0x0ab0e),
    Interval(0x0ab11,0x0ab16),
    Interval(0x0ab20,0x0ab26),
    Interval(0x0ab28,0x0ab2e),
]);

immutable(Charset) unicodeInCurrency_Symbols = Charset([
    Interval(0x020a0,0x020cf),
]);

immutable(Charset) unicodeInOld_Persian = Charset([
    Interval(0x103a0,0x103df),
]);

immutable(Charset) unicodeInRumi_Numeral_Symbols = Charset([
    Interval(0x10e60,0x10e7f),
]);

immutable(Charset) unicodeInTags = Charset([
    Interval(0xe0000,0xe007f),
]);

immutable(Charset) unicodeGreek = Charset([
    Interval(0x00370,0x00373),
    Interval(0x00375,0x00377),
    Interval(0x0037a,0x0037d),
    Interval(0x00384,0x00384),
    Interval(0x00386,0x00386),
    Interval(0x00388,0x0038a),
    Interval(0x0038c,0x0038c),
    Interval(0x0038e,0x003a1),
    Interval(0x003a3,0x003e1),
    Interval(0x003f0,0x003ff),
    Interval(0x01d26,0x01d2a),
    Interval(0x01d5d,0x01d61),
    Interval(0x01d66,0x01d6a),
    Interval(0x01dbf,0x01dbf),
    Interval(0x01f00,0x01f15),
    Interval(0x01f18,0x01f1d),
    Interval(0x01f20,0x01f45),
    Interval(0x01f48,0x01f4d),
    Interval(0x01f50,0x01f57),
    Interval(0x01f59,0x01f59),
    Interval(0x01f5b,0x01f5b),
    Interval(0x01f5d,0x01f5d),
    Interval(0x01f5f,0x01f7d),
    Interval(0x01f80,0x01fb4),
    Interval(0x01fb6,0x01fc4),
    Interval(0x01fc6,0x01fd3),
    Interval(0x01fd6,0x01fdb),
    Interval(0x01fdd,0x01fef),
    Interval(0x01ff2,0x01ff4),
    Interval(0x01ff6,0x01ffe),
    Interval(0x02126,0x02126),
    Interval(0x10140,0x1018a),
    Interval(0x1d200,0x1d245),
]);

immutable(Charset) unicodeOl_Chiki = Charset([
    Interval(0x01c50,0x01c7f),
]);

immutable(Charset) unicodeTagbanwa = Charset([
    Interval(0x01760,0x0176c),
    Interval(0x0176e,0x01770),
    Interval(0x01772,0x01773),
]);

immutable(Charset) unicodeOther_Uppercase = Charset([
    Interval(0x02160,0x0216f),
    Interval(0x024b6,0x024cf),
]);

immutable(Charset) unicodeInOgham = Charset([
    Interval(0x01680,0x0169f),
]);

immutable(Charset) unicodeInThaana = Charset([
    Interval(0x00780,0x007bf),
]);

immutable(Charset) unicodeInEnclosed_Ideographic_Supplement = Charset([
    Interval(0x1f200,0x1f2ff),
]);

immutable(Charset) unicodeInKhmer_Symbols = Charset([
    Interval(0x019e0,0x019ff),
]);

immutable(Charset) unicodeCommon = Charset([
    Interval(0x00000,0x00040),
    Interval(0x0005b,0x00060),
    Interval(0x0007b,0x000a9),
    Interval(0x000ab,0x000b9),
    Interval(0x000bb,0x000bf),
    Interval(0x000d7,0x000d7),
    Interval(0x000f7,0x000f7),
    Interval(0x002b9,0x002df),
    Interval(0x002e5,0x002e9),
    Interval(0x002ec,0x002ff),
    Interval(0x00374,0x00374),
    Interval(0x0037e,0x0037e),
    Interval(0x00385,0x00385),
    Interval(0x00387,0x00387),
    Interval(0x00589,0x00589),
    Interval(0x0060c,0x0060c),
    Interval(0x0061b,0x0061b),
    Interval(0x0061f,0x0061f),
    Interval(0x00640,0x00640),
    Interval(0x00660,0x00669),
    Interval(0x006dd,0x006dd),
    Interval(0x00964,0x00965),
    Interval(0x00970,0x00970),
    Interval(0x00e3f,0x00e3f),
    Interval(0x00fd5,0x00fd8),
    Interval(0x010fb,0x010fb),
    Interval(0x016eb,0x016ed),
    Interval(0x01735,0x01736),
    Interval(0x01802,0x01803),
    Interval(0x01805,0x01805),
    Interval(0x01cd3,0x01cd3),
    Interval(0x01ce1,0x01ce1),
    Interval(0x01ce9,0x01cec),
    Interval(0x01cee,0x01cf2),
    Interval(0x02000,0x0200b),
    Interval(0x0200e,0x02064),
    Interval(0x0206a,0x02070),
    Interval(0x02074,0x0207e),
    Interval(0x02080,0x0208e),
    Interval(0x020a0,0x020b9),
    Interval(0x02100,0x02125),
    Interval(0x02127,0x02129),
    Interval(0x0212c,0x02131),
    Interval(0x02133,0x0214d),
    Interval(0x0214f,0x0215f),
    Interval(0x02189,0x02189),
    Interval(0x02190,0x023f3),
    Interval(0x02400,0x02426),
    Interval(0x02440,0x0244a),
    Interval(0x02460,0x026ff),
    Interval(0x02701,0x027ca),
    Interval(0x027cc,0x027cc),
    Interval(0x027ce,0x027ff),
    Interval(0x02900,0x02b4c),
    Interval(0x02b50,0x02b59),
    Interval(0x02e00,0x02e31),
    Interval(0x02ff0,0x02ffb),
    Interval(0x03000,0x03004),
    Interval(0x03006,0x03006),
    Interval(0x03008,0x03020),
    Interval(0x03030,0x03037),
    Interval(0x0303c,0x0303f),
    Interval(0x0309b,0x0309c),
    Interval(0x030a0,0x030a0),
    Interval(0x030fb,0x030fc),
    Interval(0x03190,0x0319f),
    Interval(0x031c0,0x031e3),
    Interval(0x03220,0x0325f),
    Interval(0x0327f,0x032cf),
    Interval(0x03358,0x033ff),
    Interval(0x04dc0,0x04dff),
    Interval(0x0a700,0x0a721),
    Interval(0x0a788,0x0a78a),
    Interval(0x0a830,0x0a839),
    Interval(0x0fd3e,0x0fd3f),
    Interval(0x0fdfd,0x0fdfd),
    Interval(0x0fe10,0x0fe19),
    Interval(0x0fe30,0x0fe52),
    Interval(0x0fe54,0x0fe66),
    Interval(0x0fe68,0x0fe6b),
    Interval(0x0feff,0x0feff),
    Interval(0x0ff01,0x0ff20),
    Interval(0x0ff3b,0x0ff40),
    Interval(0x0ff5b,0x0ff65),
    Interval(0x0ff70,0x0ff70),
    Interval(0x0ff9e,0x0ff9f),
    Interval(0x0ffe0,0x0ffe6),
    Interval(0x0ffe8,0x0ffee),
    Interval(0x0fff9,0x0fffd),
    Interval(0x10100,0x10102),
    Interval(0x10107,0x10133),
    Interval(0x10137,0x1013f),
    Interval(0x10190,0x1019b),
    Interval(0x101d0,0x101fc),
    Interval(0x1d000,0x1d0f5),
    Interval(0x1d100,0x1d126),
    Interval(0x1d129,0x1d166),
    Interval(0x1d16a,0x1d17a),
    Interval(0x1d183,0x1d184),
    Interval(0x1d18c,0x1d1a9),
    Interval(0x1d1ae,0x1d1dd),
    Interval(0x1d300,0x1d356),
    Interval(0x1d360,0x1d371),
    Interval(0x1d400,0x1d454),
    Interval(0x1d456,0x1d49c),
    Interval(0x1d49e,0x1d49f),
    Interval(0x1d4a2,0x1d4a2),
    Interval(0x1d4a5,0x1d4a6),
    Interval(0x1d4a9,0x1d4ac),
    Interval(0x1d4ae,0x1d4b9),
    Interval(0x1d4bb,0x1d4bb),
    Interval(0x1d4bd,0x1d4c3),
    Interval(0x1d4c5,0x1d505),
    Interval(0x1d507,0x1d50a),
    Interval(0x1d50d,0x1d514),
    Interval(0x1d516,0x1d51c),
    Interval(0x1d51e,0x1d539),
    Interval(0x1d53b,0x1d53e),
    Interval(0x1d540,0x1d544),
    Interval(0x1d546,0x1d546),
    Interval(0x1d54a,0x1d550),
    Interval(0x1d552,0x1d6a5),
    Interval(0x1d6a8,0x1d7cb),
    Interval(0x1d7ce,0x1d7ff),
    Interval(0x1f000,0x1f02b),
    Interval(0x1f030,0x1f093),
    Interval(0x1f0a0,0x1f0ae),
    Interval(0x1f0b1,0x1f0be),
    Interval(0x1f0c1,0x1f0cf),
    Interval(0x1f0d1,0x1f0df),
    Interval(0x1f100,0x1f10a),
    Interval(0x1f110,0x1f12e),
    Interval(0x1f130,0x1f169),
    Interval(0x1f170,0x1f19a),
    Interval(0x1f1e6,0x1f1ff),
    Interval(0x1f201,0x1f202),
    Interval(0x1f210,0x1f23a),
    Interval(0x1f240,0x1f248),
    Interval(0x1f250,0x1f251),
    Interval(0x1f300,0x1f320),
    Interval(0x1f330,0x1f335),
    Interval(0x1f337,0x1f37c),
    Interval(0x1f380,0x1f393),
    Interval(0x1f3a0,0x1f3c4),
    Interval(0x1f3c6,0x1f3ca),
    Interval(0x1f3e0,0x1f3f0),
    Interval(0x1f400,0x1f43e),
    Interval(0x1f440,0x1f440),
    Interval(0x1f442,0x1f4f7),
    Interval(0x1f4f9,0x1f4fc),
    Interval(0x1f500,0x1f53d),
    Interval(0x1f550,0x1f567),
    Interval(0x1f5fb,0x1f5ff),
    Interval(0x1f601,0x1f610),
    Interval(0x1f612,0x1f614),
    Interval(0x1f616,0x1f616),
    Interval(0x1f618,0x1f618),
    Interval(0x1f61a,0x1f61a),
    Interval(0x1f61c,0x1f61e),
    Interval(0x1f620,0x1f625),
    Interval(0x1f628,0x1f62b),
    Interval(0x1f62d,0x1f62d),
    Interval(0x1f630,0x1f633),
    Interval(0x1f635,0x1f640),
    Interval(0x1f645,0x1f64f),
    Interval(0x1f680,0x1f6c5),
    Interval(0x1f700,0x1f773),
    Interval(0xe0001,0xe0001),
    Interval(0xe0020,0xe007f),
]);

immutable(Charset) unicodeInCommon_Indic_Number_Forms = Charset([
    Interval(0x0a830,0x0a83f),
]);

immutable(Charset) unicodeInSmall_Form_Variants = Charset([
    Interval(0x0fe50,0x0fe6f),
]);

immutable(Charset) unicodeIdeographic = Charset([
    Interval(0x03006,0x03007),
    Interval(0x03021,0x03029),
    Interval(0x03038,0x0303a),
    Interval(0x03400,0x04db5),
    Interval(0x04e00,0x09fcb),
    Interval(0x0f900,0x0fa2d),
    Interval(0x0fa30,0x0fa6d),
    Interval(0x0fa70,0x0fad9),
    Interval(0x20000,0x2a6d6),
    Interval(0x2a700,0x2b734),
    Interval(0x2b740,0x2b81d),
    Interval(0x2f800,0x2fa1d),
]);

immutable(Charset) unicodeGeorgian = Charset([
    Interval(0x010a0,0x010c5),
    Interval(0x010d0,0x010fa),
    Interval(0x010fc,0x010fc),
    Interval(0x02d00,0x02d25),
]);

immutable(Charset) unicodeOsmanya = Charset([
    Interval(0x10480,0x1049d),
    Interval(0x104a0,0x104a9),
]);

immutable(Charset) unicodeInEthiopic = Charset([
    Interval(0x01200,0x0137f),
]);

immutable(Charset) unicodeInEnclosed_Alphanumerics = Charset([
    Interval(0x02460,0x024ff),
]);

immutable(Charset) unicodeCuneiform = Charset([
    Interval(0x12000,0x1236e),
    Interval(0x12400,0x12462),
    Interval(0x12470,0x12473),
]);

immutable(Charset) unicodeSyriac = Charset([
    Interval(0x00700,0x0070d),
    Interval(0x0070f,0x0074a),
    Interval(0x0074d,0x0074f),
]);

immutable(Charset) unicodeInVertical_Forms = Charset([
    Interval(0x0fe10,0x0fe1f),
]);

immutable(Charset) unicodeInTai_Xuan_Jing_Symbols = Charset([
    Interval(0x1d300,0x1d35f),
]);

immutable(Charset) unicodeNoncharacter_Code_Point = Charset([
    Interval(0x0fdd0,0x0fdef),
    Interval(0x0fffe,0x0ffff),
    Interval(0x1fffe,0x1ffff),
    Interval(0x2fffe,0x2ffff),
    Interval(0x3fffe,0x3ffff),
    Interval(0x4fffe,0x4ffff),
    Interval(0x5fffe,0x5ffff),
    Interval(0x6fffe,0x6ffff),
    Interval(0x7fffe,0x7ffff),
    Interval(0x8fffe,0x8ffff),
    Interval(0x9fffe,0x9ffff),
    Interval(0xafffe,0xaffff),
    Interval(0xbfffe,0xbffff),
    Interval(0xcfffe,0xcffff),
    Interval(0xdfffe,0xdffff),
    Interval(0xefffe,0xeffff),
    Interval(0xffffe,0xfffff),
    Interval(0x10fffe,0x10ffff),
]);

immutable(Charset) unicodeInMiscellaneous_Symbols_and_Arrows = Charset([
    Interval(0x02b00,0x02bff),
]);

immutable(Charset) unicodeInOld_Italic = Charset([
    Interval(0x10300,0x1032f),
]);

immutable(Charset) unicodeMeetei_Mayek = Charset([
    Interval(0x0abc0,0x0abed),
    Interval(0x0abf0,0x0abf9),
]);

immutable(Charset) unicodeOther_Grapheme_Extend = Charset([
    Interval(0x009be,0x009be),
    Interval(0x009d7,0x009d7),
    Interval(0x00b3e,0x00b3e),
    Interval(0x00b57,0x00b57),
    Interval(0x00bbe,0x00bbe),
    Interval(0x00bd7,0x00bd7),
    Interval(0x00cc2,0x00cc2),
    Interval(0x00cd5,0x00cd6),
    Interval(0x00d3e,0x00d3e),
    Interval(0x00d57,0x00d57),
    Interval(0x00dcf,0x00dcf),
    Interval(0x00ddf,0x00ddf),
    Interval(0x0200c,0x0200d),
    Interval(0x0ff9e,0x0ff9f),
    Interval(0x1d165,0x1d165),
    Interval(0x1d16e,0x1d172),
]);

immutable(Charset) unicodeOther_Math = Charset([
    Interval(0x0005e,0x0005e),
    Interval(0x003d0,0x003d2),
    Interval(0x003d5,0x003d5),
    Interval(0x003f0,0x003f1),
    Interval(0x003f4,0x003f5),
    Interval(0x02016,0x02016),
    Interval(0x02032,0x02034),
    Interval(0x02040,0x02040),
    Interval(0x02061,0x02064),
    Interval(0x0207d,0x0207e),
    Interval(0x0208d,0x0208e),
    Interval(0x020d0,0x020dc),
    Interval(0x020e1,0x020e1),
    Interval(0x020e5,0x020e6),
    Interval(0x020eb,0x020ef),
    Interval(0x02102,0x02102),
    Interval(0x02107,0x02107),
    Interval(0x0210a,0x02113),
    Interval(0x02115,0x02115),
    Interval(0x02119,0x0211d),
    Interval(0x02124,0x02124),
    Interval(0x02128,0x02129),
    Interval(0x0212c,0x0212d),
    Interval(0x0212f,0x02131),
    Interval(0x02133,0x02138),
    Interval(0x0213c,0x0213f),
    Interval(0x02145,0x02149),
    Interval(0x02195,0x02199),
    Interval(0x0219c,0x0219f),
    Interval(0x021a1,0x021a2),
    Interval(0x021a4,0x021a5),
    Interval(0x021a7,0x021a7),
    Interval(0x021a9,0x021ad),
    Interval(0x021b0,0x021b1),
    Interval(0x021b6,0x021b7),
    Interval(0x021bc,0x021cd),
    Interval(0x021d0,0x021d1),
    Interval(0x021d3,0x021d3),
    Interval(0x021d5,0x021db),
    Interval(0x021dd,0x021dd),
    Interval(0x021e4,0x021e5),
    Interval(0x023b4,0x023b5),
    Interval(0x023b7,0x023b7),
    Interval(0x023d0,0x023d0),
    Interval(0x023e2,0x023e2),
    Interval(0x025a0,0x025a1),
    Interval(0x025ae,0x025b6),
    Interval(0x025bc,0x025c0),
    Interval(0x025c6,0x025c7),
    Interval(0x025ca,0x025cb),
    Interval(0x025cf,0x025d3),
    Interval(0x025e2,0x025e2),
    Interval(0x025e4,0x025e4),
    Interval(0x025e7,0x025ec),
    Interval(0x02605,0x02606),
    Interval(0x02640,0x02640),
    Interval(0x02642,0x02642),
    Interval(0x02660,0x02663),
    Interval(0x0266d,0x0266e),
    Interval(0x027c5,0x027c6),
    Interval(0x027e6,0x027ef),
    Interval(0x02983,0x02998),
    Interval(0x029d8,0x029db),
    Interval(0x029fc,0x029fd),
    Interval(0x0fe61,0x0fe61),
    Interval(0x0fe63,0x0fe63),
    Interval(0x0fe68,0x0fe68),
    Interval(0x0ff3c,0x0ff3c),
    Interval(0x0ff3e,0x0ff3e),
    Interval(0x1d400,0x1d454),
    Interval(0x1d456,0x1d49c),
    Interval(0x1d49e,0x1d49f),
    Interval(0x1d4a2,0x1d4a2),
    Interval(0x1d4a5,0x1d4a6),
    Interval(0x1d4a9,0x1d4ac),
    Interval(0x1d4ae,0x1d4b9),
    Interval(0x1d4bb,0x1d4bb),
    Interval(0x1d4bd,0x1d4c3),
    Interval(0x1d4c5,0x1d505),
    Interval(0x1d507,0x1d50a),
    Interval(0x1d50d,0x1d514),
    Interval(0x1d516,0x1d51c),
    Interval(0x1d51e,0x1d539),
    Interval(0x1d53b,0x1d53e),
    Interval(0x1d540,0x1d544),
    Interval(0x1d546,0x1d546),
    Interval(0x1d54a,0x1d550),
    Interval(0x1d552,0x1d6a5),
    Interval(0x1d6a8,0x1d6c0),
    Interval(0x1d6c2,0x1d6da),
    Interval(0x1d6dc,0x1d6fa),
    Interval(0x1d6fc,0x1d714),
    Interval(0x1d716,0x1d734),
    Interval(0x1d736,0x1d74e),
    Interval(0x1d750,0x1d76e),
    Interval(0x1d770,0x1d788),
    Interval(0x1d78a,0x1d7a8),
    Interval(0x1d7aa,0x1d7c2),
    Interval(0x1d7c4,0x1d7cb),
    Interval(0x1d7ce,0x1d7ff),
]);

immutable(Charset) unicodeGujarati = Charset([
    Interval(0x00a81,0x00a83),
    Interval(0x00a85,0x00a8d),
    Interval(0x00a8f,0x00a91),
    Interval(0x00a93,0x00aa8),
    Interval(0x00aaa,0x00ab0),
    Interval(0x00ab2,0x00ab3),
    Interval(0x00ab5,0x00ab9),
    Interval(0x00abc,0x00ac5),
    Interval(0x00ac7,0x00ac9),
    Interval(0x00acb,0x00acd),
    Interval(0x00ad0,0x00ad0),
    Interval(0x00ae0,0x00ae3),
    Interval(0x00ae6,0x00aef),
    Interval(0x00af1,0x00af1),
]);

immutable(Charset) unicodeInBox_Drawing = Charset([
    Interval(0x02500,0x0257f),
]);

immutable(Charset) unicodeInTagbanwa = Charset([
    Interval(0x01760,0x0177f),
]);

immutable(Charset) unicodeInHangul_Syllables = Charset([
    Interval(0x0ac00,0x0d7af),
]);

immutable(Charset) unicodeLydian = Charset([
    Interval(0x10920,0x10939),
    Interval(0x1093f,0x1093f),
]);

immutable(Charset) unicodeInKatakana_Phonetic_Extensions = Charset([
    Interval(0x031f0,0x031ff),
]);

immutable(Charset) unicodeInTai_Tham = Charset([
    Interval(0x01a20,0x01aaf),
]);

immutable(Charset) unicodeInNumber_Forms = Charset([
    Interval(0x02150,0x0218f),
]);

immutable(Charset) unicodeInBopomofo_Extended = Charset([
    Interval(0x031a0,0x031bf),
]);

immutable(Charset) unicodeInherited = Charset([
    Interval(0x00300,0x0036f),
    Interval(0x00485,0x00486),
    Interval(0x0064b,0x00655),
    Interval(0x0065f,0x0065f),
    Interval(0x00670,0x00670),
    Interval(0x00951,0x00952),
    Interval(0x01cd0,0x01cd2),
    Interval(0x01cd4,0x01ce0),
    Interval(0x01ce2,0x01ce8),
    Interval(0x01ced,0x01ced),
    Interval(0x01dc0,0x01de6),
    Interval(0x01dfc,0x01dff),
    Interval(0x0200c,0x0200d),
    Interval(0x020d0,0x020f0),
    Interval(0x0302a,0x0302d),
    Interval(0x03099,0x0309a),
    Interval(0x0fe00,0x0fe0f),
    Interval(0x0fe20,0x0fe26),
    Interval(0x101fd,0x101fd),
    Interval(0x1d167,0x1d169),
    Interval(0x1d17b,0x1d182),
    Interval(0x1d185,0x1d18b),
    Interval(0x1d1aa,0x1d1ad),
    Interval(0xe0100,0xe01ef),
]);

immutable(Charset) unicodeInLetterlike_Symbols = Charset([
    Interval(0x02100,0x0214f),
]);

immutable(Charset) unicodeBuhid = Charset([
    Interval(0x01740,0x01753),
]);

immutable(Charset) unicodeInCypriot_Syllabary = Charset([
    Interval(0x10800,0x1083f),
]);

immutable(Charset) unicodeInSyloti_Nagri = Charset([
    Interval(0x0a800,0x0a82f),
]);

immutable(Charset) unicodeInSamaritan = Charset([
    Interval(0x00800,0x0083f),
]);

immutable(Charset) unicodeInGeorgian = Charset([
    Interval(0x010a0,0x010ff),
]);

immutable(Charset) unicodeBalinese = Charset([
    Interval(0x01b00,0x01b4b),
    Interval(0x01b50,0x01b7c),
]);

immutable(UnicodeProperty)[] unicodeProperties = [
UnicodeProperty("Arabic", unicodeArabic),
UnicodeProperty("Armenian", unicodeArmenian),
UnicodeProperty("ASCII_Hex_Digit", unicodeASCII_Hex_Digit),
UnicodeProperty("Avestan", unicodeAvestan),
UnicodeProperty("Balinese", unicodeBalinese),
UnicodeProperty("Bamum", unicodeBamum),
UnicodeProperty("Batak", unicodeBatak),
UnicodeProperty("Bengali", unicodeBengali),
UnicodeProperty("Bidi_Control", unicodeBidi_Control),
UnicodeProperty("Bopomofo", unicodeBopomofo),
UnicodeProperty("Brahmi", unicodeBrahmi),
UnicodeProperty("Braille", unicodeBraille),
UnicodeProperty("Buginese", unicodeBuginese),
UnicodeProperty("Buhid", unicodeBuhid),
UnicodeProperty("Canadian_Aboriginal", unicodeCanadian_Aboriginal),
UnicodeProperty("Carian", unicodeCarian),
UnicodeProperty("Cc", unicodeCc),
UnicodeProperty("Cf", unicodeCf),
UnicodeProperty("Cham", unicodeCham),
UnicodeProperty("Cherokee", unicodeCherokee),
UnicodeProperty("Close_Punctuation", unicodePe),
UnicodeProperty("Cn", unicodeCn),
UnicodeProperty("Co", unicodeCo),
UnicodeProperty("Common", unicodeCommon),
UnicodeProperty("Connector_Punctuation", unicodePc),
UnicodeProperty("Control", unicodeCc),
UnicodeProperty("Coptic", unicodeCoptic),
UnicodeProperty("Cs", unicodeCs),
UnicodeProperty("Cuneiform", unicodeCuneiform),
UnicodeProperty("Currency_Symbol", unicodeSc),
UnicodeProperty("Cypriot", unicodeCypriot),
UnicodeProperty("Cyrillic", unicodeCyrillic),
UnicodeProperty("Dash", unicodeDash),
UnicodeProperty("Dash_Punctuation", unicodePd),
UnicodeProperty("Decimal_Number", unicodeNd),
UnicodeProperty("Deprecated", unicodeDeprecated),
UnicodeProperty("Deseret", unicodeDeseret),
UnicodeProperty("Devanagari", unicodeDevanagari),
UnicodeProperty("Diacritic", unicodeDiacritic),
UnicodeProperty("Egyptian_Hieroglyphs", unicodeEgyptian_Hieroglyphs),
UnicodeProperty("Enclosing_Mark", unicodeMe),
UnicodeProperty("Ethiopic", unicodeEthiopic),
UnicodeProperty("Extender", unicodeExtender),
UnicodeProperty("Final_Punctuation", unicodePf),
UnicodeProperty("Format", unicodeCf),
UnicodeProperty("Georgian", unicodeGeorgian),
UnicodeProperty("Glagolitic", unicodeGlagolitic),
UnicodeProperty("Gothic", unicodeGothic),
UnicodeProperty("Greek", unicodeGreek),
UnicodeProperty("Gujarati", unicodeGujarati),
UnicodeProperty("Gurmukhi", unicodeGurmukhi),
UnicodeProperty("Han", unicodeHan),
UnicodeProperty("Hangul", unicodeHangul),
UnicodeProperty("Hanunoo", unicodeHanunoo),
UnicodeProperty("Hebrew", unicodeHebrew),
UnicodeProperty("Hex_Digit", unicodeHex_Digit),
UnicodeProperty("Hiragana", unicodeHiragana),
UnicodeProperty("Hyphen", unicodeHyphen),
UnicodeProperty("Ideographic", unicodeIdeographic),
UnicodeProperty("IDS_Binary_Operator", unicodeIDS_Binary_Operator),
UnicodeProperty("IDS_Trinary_Operator", unicodeIDS_Trinary_Operator),
UnicodeProperty("Imperial_Aramaic", unicodeImperial_Aramaic),
UnicodeProperty("InAegean Numbers", unicodeInAegean_Numbers),
UnicodeProperty("InAlchemical Symbols", unicodeInAlchemical_Symbols),
UnicodeProperty("InAlphabetic Presentation Forms", unicodeInAlphabetic_Presentation_Forms),
UnicodeProperty("InAncient Greek Musical Notation", unicodeInAncient_Greek_Musical_Notation),
UnicodeProperty("InAncient Greek Numbers", unicodeInAncient_Greek_Numbers),
UnicodeProperty("InAncient Symbols", unicodeInAncient_Symbols),
UnicodeProperty("InArabic", unicodeInArabic),
UnicodeProperty("InArabic Presentation Forms-A", unicodeInArabic_Presentation_Forms_A),
UnicodeProperty("InArabic Presentation Forms-B", unicodeInArabic_Presentation_Forms_B),
UnicodeProperty("InArabic Supplement", unicodeInArabic_Supplement),
UnicodeProperty("InArmenian", unicodeInArmenian),
UnicodeProperty("InArrows", unicodeInArrows),
UnicodeProperty("InAvestan", unicodeInAvestan),
UnicodeProperty("InBalinese", unicodeInBalinese),
UnicodeProperty("InBamum", unicodeInBamum),
UnicodeProperty("InBamum Supplement", unicodeInBamum_Supplement),
UnicodeProperty("InBasic Latin", unicodeInBasic_Latin),
UnicodeProperty("InBatak", unicodeInBatak),
UnicodeProperty("InBengali", unicodeInBengali),
UnicodeProperty("InBlock Elements", unicodeInBlock_Elements),
UnicodeProperty("InBopomofo", unicodeInBopomofo),
UnicodeProperty("InBopomofo Extended", unicodeInBopomofo_Extended),
UnicodeProperty("InBox Drawing", unicodeInBox_Drawing),
UnicodeProperty("InBrahmi", unicodeInBrahmi),
UnicodeProperty("InBraille Patterns", unicodeInBraille_Patterns),
UnicodeProperty("InBuginese", unicodeInBuginese),
UnicodeProperty("InBuhid", unicodeInBuhid),
UnicodeProperty("InByzantine Musical Symbols", unicodeInByzantine_Musical_Symbols),
UnicodeProperty("InCarian", unicodeInCarian),
UnicodeProperty("InCham", unicodeInCham),
UnicodeProperty("InCherokee", unicodeInCherokee),
UnicodeProperty("InCJK Compatibility", unicodeInCJK_Compatibility),
UnicodeProperty("InCJK Compatibility Forms", unicodeInCJK_Compatibility_Forms),
UnicodeProperty("InCJK Compatibility Ideographs", unicodeInCJK_Compatibility_Ideographs),
UnicodeProperty("InCJK Compatibility Ideographs Supplement", unicodeInCJK_Compatibility_Ideographs_Supplement),
UnicodeProperty("InCJK Radicals Supplement", unicodeInCJK_Radicals_Supplement),
UnicodeProperty("InCJK Strokes", unicodeInCJK_Strokes),
UnicodeProperty("InCJK Symbols and Punctuation", unicodeInCJK_Symbols_and_Punctuation),
UnicodeProperty("InCJK Unified Ideographs", unicodeInCJK_Unified_Ideographs),
UnicodeProperty("InCJK Unified Ideographs Extension A", unicodeInCJK_Unified_Ideographs_Extension_A),
UnicodeProperty("InCJK Unified Ideographs Extension B", unicodeInCJK_Unified_Ideographs_Extension_B),
UnicodeProperty("InCJK Unified Ideographs Extension C", unicodeInCJK_Unified_Ideographs_Extension_C),
UnicodeProperty("InCJK Unified Ideographs Extension D", unicodeInCJK_Unified_Ideographs_Extension_D),
UnicodeProperty("InCombining Diacritical Marks", unicodeInCombining_Diacritical_Marks),
UnicodeProperty("InCombining Diacritical Marks for Symbols", unicodeInCombining_Diacritical_Marks_for_Symbols),
UnicodeProperty("InCombining Diacritical Marks Supplement", unicodeInCombining_Diacritical_Marks_Supplement),
UnicodeProperty("InCombining Half Marks", unicodeInCombining_Half_Marks),
UnicodeProperty("InCommon Indic Number Forms", unicodeInCommon_Indic_Number_Forms),
UnicodeProperty("InControl Pictures", unicodeInControl_Pictures),
UnicodeProperty("InCoptic", unicodeInCoptic),
UnicodeProperty("InCounting Rod Numerals", unicodeInCounting_Rod_Numerals),
UnicodeProperty("InCuneiform", unicodeInCuneiform),
UnicodeProperty("InCuneiform Numbers and Punctuation", unicodeInCuneiform_Numbers_and_Punctuation),
UnicodeProperty("InCurrency Symbols", unicodeInCurrency_Symbols),
UnicodeProperty("InCypriot Syllabary", unicodeInCypriot_Syllabary),
UnicodeProperty("InCyrillic", unicodeInCyrillic),
UnicodeProperty("InCyrillic Extended-A", unicodeInCyrillic_Extended_A),
UnicodeProperty("InCyrillic Extended-B", unicodeInCyrillic_Extended_B),
UnicodeProperty("InCyrillic Supplement", unicodeInCyrillic_Supplement),
UnicodeProperty("InDeseret", unicodeInDeseret),
UnicodeProperty("InDevanagari", unicodeInDevanagari),
UnicodeProperty("InDevanagari Extended", unicodeInDevanagari_Extended),
UnicodeProperty("InDingbats", unicodeInDingbats),
UnicodeProperty("InDomino Tiles", unicodeInDomino_Tiles),
UnicodeProperty("InEgyptian Hieroglyphs", unicodeInEgyptian_Hieroglyphs),
UnicodeProperty("InEmoticons", unicodeInEmoticons),
UnicodeProperty("InEnclosed Alphanumerics", unicodeInEnclosed_Alphanumerics),
UnicodeProperty("InEnclosed Alphanumeric Supplement", unicodeInEnclosed_Alphanumeric_Supplement),
UnicodeProperty("InEnclosed CJK Letters and Months", unicodeInEnclosed_CJK_Letters_and_Months),
UnicodeProperty("InEnclosed Ideographic Supplement", unicodeInEnclosed_Ideographic_Supplement),
UnicodeProperty("InEthiopic", unicodeInEthiopic),
UnicodeProperty("InEthiopic Extended", unicodeInEthiopic_Extended),
UnicodeProperty("InEthiopic Extended-A", unicodeInEthiopic_Extended_A),
UnicodeProperty("InEthiopic Supplement", unicodeInEthiopic_Supplement),
UnicodeProperty("InGeneral Punctuation", unicodeInGeneral_Punctuation),
UnicodeProperty("InGeometric Shapes", unicodeInGeometric_Shapes),
UnicodeProperty("InGeorgian", unicodeInGeorgian),
UnicodeProperty("InGeorgian Supplement", unicodeInGeorgian_Supplement),
UnicodeProperty("InGlagolitic", unicodeInGlagolitic),
UnicodeProperty("InGothic", unicodeInGothic),
UnicodeProperty("InGreek and Coptic", unicodeInGreek_and_Coptic),
UnicodeProperty("InGreek Extended", unicodeInGreek_Extended),
UnicodeProperty("InGujarati", unicodeInGujarati),
UnicodeProperty("InGurmukhi", unicodeInGurmukhi),
UnicodeProperty("InHalfwidth and Fullwidth Forms", unicodeInHalfwidth_and_Fullwidth_Forms),
UnicodeProperty("InHangul Compatibility Jamo", unicodeInHangul_Compatibility_Jamo),
UnicodeProperty("InHangul Jamo", unicodeInHangul_Jamo),
UnicodeProperty("InHangul Jamo Extended-A", unicodeInHangul_Jamo_Extended_A),
UnicodeProperty("InHangul Jamo Extended-B", unicodeInHangul_Jamo_Extended_B),
UnicodeProperty("InHangul Syllables", unicodeInHangul_Syllables),
UnicodeProperty("InHanunoo", unicodeInHanunoo),
UnicodeProperty("InHebrew", unicodeInHebrew),
UnicodeProperty("Inherited", unicodeInherited),
UnicodeProperty("InHigh Private Use Surrogates", unicodeInHigh_Private_Use_Surrogates),
UnicodeProperty("InHigh Surrogates", unicodeInHigh_Surrogates),
UnicodeProperty("InHiragana", unicodeInHiragana),
UnicodeProperty("InIdeographic Description Characters", unicodeInIdeographic_Description_Characters),
UnicodeProperty("InImperial Aramaic", unicodeInImperial_Aramaic),
UnicodeProperty("InInscriptional Pahlavi", unicodeInInscriptional_Pahlavi),
UnicodeProperty("InInscriptional Parthian", unicodeInInscriptional_Parthian),
UnicodeProperty("InIPA Extensions", unicodeInIPA_Extensions),
UnicodeProperty("Initial_Punctuation", unicodePi),
UnicodeProperty("InJavanese", unicodeInJavanese),
UnicodeProperty("InKaithi", unicodeInKaithi),
UnicodeProperty("InKana Supplement", unicodeInKana_Supplement),
UnicodeProperty("InKanbun", unicodeInKanbun),
UnicodeProperty("InKangxi Radicals", unicodeInKangxi_Radicals),
UnicodeProperty("InKannada", unicodeInKannada),
UnicodeProperty("InKatakana", unicodeInKatakana),
UnicodeProperty("InKatakana Phonetic Extensions", unicodeInKatakana_Phonetic_Extensions),
UnicodeProperty("InKayah Li", unicodeInKayah_Li),
UnicodeProperty("InKharoshthi", unicodeInKharoshthi),
UnicodeProperty("InKhmer", unicodeInKhmer),
UnicodeProperty("InKhmer Symbols", unicodeInKhmer_Symbols),
UnicodeProperty("InLao", unicodeInLao),
UnicodeProperty("InLatin-1 Supplement", unicodeInLatin_1_Supplement),
UnicodeProperty("InLatin Extended-A", unicodeInLatin_Extended_A),
UnicodeProperty("InLatin Extended Additional", unicodeInLatin_Extended_Additional),
UnicodeProperty("InLatin Extended-B", unicodeInLatin_Extended_B),
UnicodeProperty("InLatin Extended-C", unicodeInLatin_Extended_C),
UnicodeProperty("InLatin Extended-D", unicodeInLatin_Extended_D),
UnicodeProperty("InLepcha", unicodeInLepcha),
UnicodeProperty("InLetterlike Symbols", unicodeInLetterlike_Symbols),
UnicodeProperty("InLimbu", unicodeInLimbu),
UnicodeProperty("InLinear B Ideograms", unicodeInLinear_B_Ideograms),
UnicodeProperty("InLinear B Syllabary", unicodeInLinear_B_Syllabary),
UnicodeProperty("InLisu", unicodeInLisu),
UnicodeProperty("InLow Surrogates", unicodeInLow_Surrogates),
UnicodeProperty("InLycian", unicodeInLycian),
UnicodeProperty("InLydian", unicodeInLydian),
UnicodeProperty("InMahjong Tiles", unicodeInMahjong_Tiles),
UnicodeProperty("InMalayalam", unicodeInMalayalam),
UnicodeProperty("InMandaic", unicodeInMandaic),
UnicodeProperty("InMathematical Alphanumeric Symbols", unicodeInMathematical_Alphanumeric_Symbols),
UnicodeProperty("InMathematical Operators", unicodeInMathematical_Operators),
UnicodeProperty("InMeetei Mayek", unicodeInMeetei_Mayek),
UnicodeProperty("InMiscellaneous Mathematical Symbols-A", unicodeInMiscellaneous_Mathematical_Symbols_A),
UnicodeProperty("InMiscellaneous Mathematical Symbols-B", unicodeInMiscellaneous_Mathematical_Symbols_B),
UnicodeProperty("InMiscellaneous Symbols", unicodeInMiscellaneous_Symbols),
UnicodeProperty("InMiscellaneous Symbols and Arrows", unicodeInMiscellaneous_Symbols_and_Arrows),
UnicodeProperty("InMiscellaneous Symbols And Pictographs", unicodeInMiscellaneous_Symbols_And_Pictographs),
UnicodeProperty("InMiscellaneous Technical", unicodeInMiscellaneous_Technical),
UnicodeProperty("InModifier Tone Letters", unicodeInModifier_Tone_Letters),
UnicodeProperty("InMongolian", unicodeInMongolian),
UnicodeProperty("InMusical Symbols", unicodeInMusical_Symbols),
UnicodeProperty("InMyanmar", unicodeInMyanmar),
UnicodeProperty("InMyanmar Extended-A", unicodeInMyanmar_Extended_A),
UnicodeProperty("InNew Tai Lue", unicodeInNew_Tai_Lue),
UnicodeProperty("InNKo", unicodeInNKo),
UnicodeProperty("InNumber Forms", unicodeInNumber_Forms),
UnicodeProperty("InOgham", unicodeInOgham),
UnicodeProperty("InOl Chiki", unicodeInOl_Chiki),
UnicodeProperty("InOld Italic", unicodeInOld_Italic),
UnicodeProperty("InOld Persian", unicodeInOld_Persian),
UnicodeProperty("InOld South Arabian", unicodeInOld_South_Arabian),
UnicodeProperty("InOld Turkic", unicodeInOld_Turkic),
UnicodeProperty("InOptical Character Recognition", unicodeInOptical_Character_Recognition),
UnicodeProperty("InOriya", unicodeInOriya),
UnicodeProperty("InOsmanya", unicodeInOsmanya),
UnicodeProperty("InPhags-pa", unicodeInPhags_pa),
UnicodeProperty("InPhaistos Disc", unicodeInPhaistos_Disc),
UnicodeProperty("InPhoenician", unicodeInPhoenician),
UnicodeProperty("InPhonetic Extensions", unicodeInPhonetic_Extensions),
UnicodeProperty("InPhonetic Extensions Supplement", unicodeInPhonetic_Extensions_Supplement),
UnicodeProperty("InPlaying Cards", unicodeInPlaying_Cards),
UnicodeProperty("InPrivate Use Area", unicodeInPrivate_Use_Area),
UnicodeProperty("InRejang", unicodeInRejang),
UnicodeProperty("InRumi Numeral Symbols", unicodeInRumi_Numeral_Symbols),
UnicodeProperty("InRunic", unicodeInRunic),
UnicodeProperty("InSamaritan", unicodeInSamaritan),
UnicodeProperty("InSaurashtra", unicodeInSaurashtra),
UnicodeProperty("Inscriptional_Pahlavi", unicodeInscriptional_Pahlavi),
UnicodeProperty("Inscriptional_Parthian", unicodeInscriptional_Parthian),
UnicodeProperty("InShavian", unicodeInShavian),
UnicodeProperty("InSinhala", unicodeInSinhala),
UnicodeProperty("InSmall Form Variants", unicodeInSmall_Form_Variants),
UnicodeProperty("InSpacing Modifier Letters", unicodeInSpacing_Modifier_Letters),
UnicodeProperty("InSpecials", unicodeInSpecials),
UnicodeProperty("InSundanese", unicodeInSundanese),
UnicodeProperty("InSuperscripts and Subscripts", unicodeInSuperscripts_and_Subscripts),
UnicodeProperty("InSupplemental Arrows-A", unicodeInSupplemental_Arrows_A),
UnicodeProperty("InSupplemental Arrows-B", unicodeInSupplemental_Arrows_B),
UnicodeProperty("InSupplemental Mathematical Operators", unicodeInSupplemental_Mathematical_Operators),
UnicodeProperty("InSupplemental Punctuation", unicodeInSupplemental_Punctuation),
UnicodeProperty("InSupplementary Private Use Area-A", unicodeInSupplementary_Private_Use_Area_A),
UnicodeProperty("InSupplementary Private Use Area-B", unicodeInSupplementary_Private_Use_Area_B),
UnicodeProperty("InSyloti Nagri", unicodeInSyloti_Nagri),
UnicodeProperty("InSyriac", unicodeInSyriac),
UnicodeProperty("InTagalog", unicodeInTagalog),
UnicodeProperty("InTagbanwa", unicodeInTagbanwa),
UnicodeProperty("InTags", unicodeInTags),
UnicodeProperty("InTai Le", unicodeInTai_Le),
UnicodeProperty("InTai Tham", unicodeInTai_Tham),
UnicodeProperty("InTai Viet", unicodeInTai_Viet),
UnicodeProperty("InTai Xuan Jing Symbols", unicodeInTai_Xuan_Jing_Symbols),
UnicodeProperty("InTamil", unicodeInTamil),
UnicodeProperty("InTelugu", unicodeInTelugu),
UnicodeProperty("InThaana", unicodeInThaana),
UnicodeProperty("InThai", unicodeInThai),
UnicodeProperty("InTibetan", unicodeInTibetan),
UnicodeProperty("InTifinagh", unicodeInTifinagh),
UnicodeProperty("InTransport And Map Symbols", unicodeInTransport_And_Map_Symbols),
UnicodeProperty("InUgaritic", unicodeInUgaritic),
UnicodeProperty("InUnified Canadian Aboriginal Syllabics", unicodeInUnified_Canadian_Aboriginal_Syllabics),
UnicodeProperty("InUnified Canadian Aboriginal Syllabics Extended", unicodeInUnified_Canadian_Aboriginal_Syllabics_Extended),
UnicodeProperty("InVai", unicodeInVai),
UnicodeProperty("InVariation Selectors", unicodeInVariation_Selectors),
UnicodeProperty("InVariation Selectors Supplement", unicodeInVariation_Selectors_Supplement),
UnicodeProperty("InVedic Extensions", unicodeInVedic_Extensions),
UnicodeProperty("InVertical Forms", unicodeInVertical_Forms),
UnicodeProperty("InYijing Hexagram Symbols", unicodeInYijing_Hexagram_Symbols),
UnicodeProperty("InYi Radicals", unicodeInYi_Radicals),
UnicodeProperty("InYi Syllables", unicodeInYi_Syllables),
UnicodeProperty("Javanese", unicodeJavanese),
UnicodeProperty("Join_Control", unicodeJoin_Control),
UnicodeProperty("Kaithi", unicodeKaithi),
UnicodeProperty("Kannada", unicodeKannada),
UnicodeProperty("Katakana", unicodeKatakana),
UnicodeProperty("Kayah_Li", unicodeKayah_Li),
UnicodeProperty("Kharoshthi", unicodeKharoshthi),
UnicodeProperty("Khmer", unicodeKhmer),
UnicodeProperty("Lao", unicodeLao),
UnicodeProperty("Latin", unicodeLatin),
UnicodeProperty("Lepcha", unicodeLepcha),
UnicodeProperty("Letter_Number", unicodeNl),
UnicodeProperty("Limbu", unicodeLimbu),
UnicodeProperty("Linear_B", unicodeLinear_B),
UnicodeProperty("Line_Separator", unicodeZl),
UnicodeProperty("Lisu", unicodeLisu),
UnicodeProperty("Lm", unicodeLm),
UnicodeProperty("Lo", unicodeLo),
UnicodeProperty("Logical_Order_Exception", unicodeLogical_Order_Exception),
UnicodeProperty("Lt", unicodeLt),
UnicodeProperty("Lycian", unicodeLycian),
UnicodeProperty("Lydian", unicodeLydian),
UnicodeProperty("Malayalam", unicodeMalayalam),
UnicodeProperty("Mandaic", unicodeMandaic),
UnicodeProperty("Math_Symbol", unicodeSm),
UnicodeProperty("Mc", unicodeMc),
UnicodeProperty("Me", unicodeMe),
UnicodeProperty("Meetei_Mayek", unicodeMeetei_Mayek),
UnicodeProperty("Mn", unicodeMn),
UnicodeProperty("Modifier_Letter", unicodeLm),
UnicodeProperty("Modifier_Symbol", unicodeSk),
UnicodeProperty("Mongolian", unicodeMongolian),
UnicodeProperty("Myanmar", unicodeMyanmar),
UnicodeProperty("Nd", unicodeNd),
UnicodeProperty("New_Tai_Lue", unicodeNew_Tai_Lue),
UnicodeProperty("Nko", unicodeNko),
UnicodeProperty("Nl", unicodeNl),
UnicodeProperty("No", unicodeNo),
UnicodeProperty("Noncharacter_Code_Point", unicodeNoncharacter_Code_Point),
UnicodeProperty("Nonspacing_Mark", unicodeMn),
UnicodeProperty("Ogham", unicodeOgham),
UnicodeProperty("Ol_Chiki", unicodeOl_Chiki),
UnicodeProperty("Old_Italic", unicodeOld_Italic),
UnicodeProperty("Old_Persian", unicodeOld_Persian),
UnicodeProperty("Old_South_Arabian", unicodeOld_South_Arabian),
UnicodeProperty("Old_Turkic", unicodeOld_Turkic),
UnicodeProperty("Open_Punctuation", unicodePs),
UnicodeProperty("Oriya", unicodeOriya),
UnicodeProperty("Osmanya", unicodeOsmanya),
UnicodeProperty("Other_Alphabetic", unicodeOther_Alphabetic),
UnicodeProperty("Other_Default_Ignorable_Code_Point", unicodeOther_Default_Ignorable_Code_Point),
UnicodeProperty("Other_Grapheme_Extend", unicodeOther_Grapheme_Extend),
UnicodeProperty("Other_ID_Continue", unicodeOther_ID_Continue),
UnicodeProperty("Other_ID_Start", unicodeOther_ID_Start),
UnicodeProperty("Other_Letter", unicodeLo),
UnicodeProperty("Other_Lowercase", unicodeOther_Lowercase),
UnicodeProperty("Other_Math", unicodeOther_Math),
UnicodeProperty("Other_Number", unicodeNo),
UnicodeProperty("Other_Punctuation", unicodePo),
UnicodeProperty("Other_Symbol", unicodeSo),
UnicodeProperty("Other_Uppercase", unicodeOther_Uppercase),
UnicodeProperty("Paragraph_Separator", unicodeZp),
UnicodeProperty("Pattern_Syntax", unicodePattern_Syntax),
UnicodeProperty("Pattern_White_Space", unicodePattern_White_Space),
UnicodeProperty("Pc", unicodePc),
UnicodeProperty("Pd", unicodePd),
UnicodeProperty("Pe", unicodePe),
UnicodeProperty("Pf", unicodePf),
UnicodeProperty("Phags_Pa", unicodePhags_Pa),
UnicodeProperty("Phoenician", unicodePhoenician),
UnicodeProperty("Pi", unicodePi),
UnicodeProperty("Po", unicodePo),
UnicodeProperty("Private_Use", unicodeCo),
UnicodeProperty("Ps", unicodePs),
UnicodeProperty("Quotation_Mark", unicodeQuotation_Mark),
UnicodeProperty("Radical", unicodeRadical),
UnicodeProperty("Rejang", unicodeRejang),
UnicodeProperty("Runic", unicodeRunic),
UnicodeProperty("Samaritan", unicodeSamaritan),
UnicodeProperty("Saurashtra", unicodeSaurashtra),
UnicodeProperty("Sc", unicodeSc),
UnicodeProperty("Shavian", unicodeShavian),
UnicodeProperty("Sinhala", unicodeSinhala),
UnicodeProperty("Sk", unicodeSk),
UnicodeProperty("Sm", unicodeSm),
UnicodeProperty("So", unicodeSo),
UnicodeProperty("Soft_Dotted", unicodeSoft_Dotted),
UnicodeProperty("Space_Separator", unicodeZs),
UnicodeProperty("Spacing_Mark", unicodeMc),
UnicodeProperty("STerm", unicodeSTerm),
UnicodeProperty("Sundanese", unicodeSundanese),
UnicodeProperty("Surrogate", unicodeCs),
UnicodeProperty("Syloti_Nagri", unicodeSyloti_Nagri),
UnicodeProperty("Syriac", unicodeSyriac),
UnicodeProperty("Tagalog", unicodeTagalog),
UnicodeProperty("Tagbanwa", unicodeTagbanwa),
UnicodeProperty("Tai_Le", unicodeTai_Le),
UnicodeProperty("Tai_Tham", unicodeTai_Tham),
UnicodeProperty("Tai_Viet", unicodeTai_Viet),
UnicodeProperty("Tamil", unicodeTamil),
UnicodeProperty("Telugu", unicodeTelugu),
UnicodeProperty("Terminal_Punctuation", unicodeTerminal_Punctuation),
UnicodeProperty("Thaana", unicodeThaana),
UnicodeProperty("Thai", unicodeThai),
UnicodeProperty("Tibetan", unicodeTibetan),
UnicodeProperty("Tifinagh", unicodeTifinagh),
UnicodeProperty("Titlecase_Letter", unicodeLt),
UnicodeProperty("Ugaritic", unicodeUgaritic),
UnicodeProperty("Unassigned", unicodeCn),
UnicodeProperty("Unified_Ideograph", unicodeUnified_Ideograph),
UnicodeProperty("Vai", unicodeVai),
UnicodeProperty("Variation_Selector", unicodeVariation_Selector),
UnicodeProperty("White_Space", unicodeWhite_Space),
UnicodeProperty("Yi", unicodeYi),
UnicodeProperty("Zl", unicodeZl),
UnicodeProperty("Zp", unicodeZp),
UnicodeProperty("Zs", unicodeZs),
];

