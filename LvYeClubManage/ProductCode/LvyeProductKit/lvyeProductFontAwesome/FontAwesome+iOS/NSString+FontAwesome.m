//
//  NSString+FontAwesome.m
//
//  Copyright (c) 2012 Alex Usbergo. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//

#import "NSString+FontAwesome.h"

@implementation NSString (FontAwesome)

#pragma mark - Public API
+ (FMIconFont)fontAwesomeEnumForIconIdentifier:(NSString*)string {
    NSDictionary *enums = [self enumDictionary];
    return [enums[string] integerValue];
}

+ (NSString*)fontAwesomeIconStringForEnum:(FMIconFont)value {
    
    
    
//    [NSString fontAwesomeUnicodeStrings][value]
    return [NSString fontAwesomeUnicodeStrings][value];
}

+ (NSString*)fontAwesomeIconStringForIconIdentifier:(NSString*)identifier {
    return [self fontAwesomeIconStringForEnum:[self fontAwesomeEnumForIconIdentifier:identifier]];
}


#pragma mark - Data Initialization
+ (NSArray *)fontAwesomeUnicodeStrings {
    
    static NSArray *fontAwesomeUnicodeStrings;
    
    static dispatch_once_t unicodeStringsOnceToken;
    dispatch_once(&unicodeStringsOnceToken, ^{
        
        
//        fontAwesomeUnicodeStrings = @[@"\ue900", @"\ue901", @"\ue902",@"\ue903",
//                                      @"\ue904", @"\ue905", @"\ue906",@"\ue907",
//                                      @"\ue908", @"\ue909", @"\ue90A",@"\ue90B",
//                                      @"\ue90C", @"\ue90D", @"\ue90E",@"\ue90F",
//                                      @"\ue910", @"\ue911", @"\ue912",@"\ue913",
//                                      @"\ue914", @"\ue915", @"\ue916",@"\ue917",
//                                      @"\ue918", @"\ue919", @"\ue91A",@"\ue91B",
//                                      @"\ue91C", @"\ue91D", @"\ue91E",@"\ue91F",
//                                      @"\ue920", @"\ue921", @"\ue922",@"\ue923",
//                                      @"\ue924", @"\ue925", @"\ue926",@"\ue927",
//                                      @"\ue928", @"\ue929", @"\ue92A",@"\ue92B",
//                                      @"\ue92C", @"\ue92D", @"\ue92E",@"\ue92F",
//                                      @"\ue930", @"\ue931", @"\ue932",@"\ue933",
//                                      @"\ue934", @"\ue935", @"\ue936",@"\ue937",
//                                      @"\ue938", @"\ue939", @"\ue93A",@"\ue93B",
//                                      @"\ue93C", @"\ue93D", @"\ue93E",@"\ue93F",
//                                      @"\ue940", @"\ue941", @"\ue642",@"\ue943",
//                                      @"\ue944", @"\ue645", @"\ue646",@"\ue647",
//                                      @"\ue948", @"\ue649", @"\ue64A",@"\ue64B",
//                                      @"\ue94C", @"\ue64D", @"\ue64E",@"\ue64F",];
//    });
        
        fontAwesomeUnicodeStrings = @[@"\uf000",@"\uf001",@"\uf002",@"\uf003",@"\uf004",@"\uf005",@"\uf006",@"\uf007",
                                      @"\uf008",@"\uf009",@"\uf00A",@"\uf00B",@"\uf00C",@"\uf00D",@"\uf00E",
                                      @"\uf010",@"\uf011",@"\uf012",@"\uf013",@"\uf014",@"\uf015",@"\uf016",@"\uf017",
                                      @"\uf018",@"\uf019",@"\uf01A",@"\uf01B",@"\uf01C",@"\uf01D",@"\uf01E",
                                      @"\uf021",@"\uf022",@"\uf023",@"\uf024",@"\uf025",@"\uf026",@"\uf027",
                                      @"\uf028",@"\uf029",@"\uf02A",@"\uf02B",@"\uf02C",@"\uf02D",@"\uf02E",@"\uf02F",
                                      @"\uf030",@"\uf031",@"\uf032",@"\uf033",@"\uf034",@"\uf035",@"\uf036",@"\uf037",
                                      @"\uf038",@"\uf039",@"\uf03A",@"\uf03B",@"\uf03C",@"\uf03D",@"\uf03E",
                                      @"\uf040",@"\uf041",@"\uf042",@"\uf043",@"\uf044",@"\uf045",@"\uf046",@"\uf047",
                                      @"\uf048",@"\uf049",@"\uf04A",@"\uf04B",@"\uf04C",@"\uf04D",@"\uf04E",
                                      @"\uf050",@"\uf051",@"\uf052",@"\uf053",@"\uf054",@"\uf055",@"\uf056",@"\uf057",
                                      @"\uf058",@"\uf059",@"\uf05A",@"\uf05B",@"\uf05C",@"\uf05D",@"\uf05E",
                                      @"\uf060",@"\uf061",@"\uf062",@"\uf063",@"\uf064",@"\uf065",@"\uf066",@"\uf067",
                                      @"\uf068",@"\uf069",@"\uf06A",@"\uf06B",@"\uf06C",@"\uf06D",@"\uf06E",
                                      @"\uf070",@"\uf071",@"\uf072",@"\uf073",@"\uf074",@"\uf075",@"\uf076",@"\uf077",
                                      @"\uf078",@"\uf079",@"\uf07A",@"\uf07B",@"\uf07C",@"\uf07D",@"\uf07E",
                                      @"\uf080",@"\uf081",@"\uf082",@"\uf083",@"\uf084",@"\uf085",@"\uf086",@"\uf087",
                                      @"\uf088",@"\uf089",@"\uf08A",@"\uf08B",@"\uf08C",@"\uf08D",@"\uf08E",
                                      @"\uf090",@"\uf091",@"\uf092",@"\uf093",@"\uf094",@"\uf095",@"\uf096",@"\uf097",
                                      @"\uf098",@"\uf099",@"\uf09A",@"\uf09B",@"\uf09C",@"\uf09D",@"\uf09E",
                                      @"\uf0A0",@"\uf0A1",@"\uf0A2",@"\uf0A3",@"\uf0A4",@"\uf0A5",@"\uf0A6",@"\uf0A7",
                                      @"\uf0A8",@"\uf0A9",@"\uf0AA",@"\uf0AB",@"\uf0AC",@"\uf0AD",@"\uf0AE",
                                      @"\uf0B0",@"\uf0B1",@"\uf0B2",@"\uf0B3",@"\uf0B4",@"\uf0B5",@"\uf0B6",@"\uf0B7",
                                      @"\uf0B8",@"\uf0B9",@"\uf0BA",@"\uf0BB",@"\uf0BC",@"\uf0BD",@"\uf0BE",
                                      @"\uf0C0",@"\uf0C1",@"\uf0C2",@"\uf0C3",@"\uf0C4",@"\uf0C5",@"\uf0C6",@"\uf0C7",
                                      @"\uf0C8",@"\uf0C9",@"\uf0CA",@"\uf0CB",@"\uf0CC",@"\uf0CD",@"\uf0CE",
                                      @"\uf0D0",@"\uf0D1",@"\uf0D2",@"\uf0D3",@"\uf0D4",@"\uf0D5",@"\uf0D6",@"\uf0D7",
                                      @"\uf0D8",@"\uf0D9",@"\uf0DA",@"\uf0DB",@"\uf0DC",@"\uf0DD",@"\uf0DE",
                                      @"\uf0E0",@"\uf0E1",@"\uf0E2",@"\uf0E3",@"\uf0E4",@"\uf0E5",@"\uf0E6",@"\uf0E7",
                                      @"\uf0E8",@"\uf0E9",@"\uf0EA",@"\uf0EB",@"\uf0EC",@"\uf0ED",@"\uf0EE",
                                      @"\uf0F0",@"\uf0F1",@"\uf0F2",@"\uf0F3",@"\uf0F4",@"\uf0F5",@"\uf0F6",@"\uf0F7",
                                      @"\uf0F8",@"\uf0F9",@"\uf0FA",@"\uf0FB",@"\uf0FC",@"\uf0FD",@"\uf0FE",
                                      @"\uf100",@"\uf101",@"\uf102",@"\uf103",@"\uf104",@"\uf105",@"\uf106",@"\uf107",
                                      @"\uf108",@"\uf109",@"\uf10A",@"\uf10B",@"\uf10C",@"\uf10D",@"\uf10E",
                                      @"\uf110",@"\uf111",@"\uf112",@"\uf113",@"\uf114",@"\uf115",@"\uf116",@"\uf117",
                                      @"\uf118",@"\uf119",@"\uf11A",@"\uf11B",@"\uf11C",@"\uf11D",@"\uf11E",
                                      @"\uf120",@"\uf121",@"\uf122",@"\uf123",@"\uf124",@"\uf125",@"\uf126",@"\uf127",
                                      @"\uf128",@"\uf129",@"\uf12A",@"\uf12B",@"\uf12C",@"\uf12D",@"\uf12E",
                                      @"\uf130",@"\uf131",@"\uf132",@"\uf133",@"\uf134",@"\uf135",@"\uf136",@"\uf137",
                                      @"\uf138",@"\uf139",@"\uf13A",@"\uf13B",@"\uf13C",@"\uf13D",@"\uf13E",
                                      @"\uf140",@"\uf141",@"\uf142",@"\uf143",@"\uf144",@"\uf145",@"\uf146",@"\uf147",
                                      @"\uf148",@"\uf149",@"\uf14A",@"\uf14B",@"\uf14C",@"\uf14D",@"\uf14E",
                                      @"\uf150",@"\uf151",@"\uf152",@"\uf153",@"\uf154",@"\uf155",@"\uf156",@"\uf157",
                                      @"\uf158",@"\uf159",@"\uf15A",@"\uf15B",@"\uf15C",@"\uf15D",@"\uf15E",
                                      @"\uf160",@"\uf161",@"\uf162",@"\uf163",@"\uf164",@"\uf165",@"\uf166",@"\uf167",
                                      @"\uf168",@"\uf169",@"\uf16A",@"\uf16B",@"\uf16C",@"\uf16D",@"\uf16E",
                                      @"\uf170",@"\uf171",@"\uf172",@"\uf173",@"\uf174",@"\uf175",@"\uf176",@"\uf177",
                                      @"\uf178",@"\uf179",@"\uf17A",@"\uf17B",@"\uf17C",@"\uf17D",@"\uf17E",
                                      @"\uf180",@"\uf181",@"\uf182",@"\uf183",@"\uf184",@"\uf185",@"\uf186",@"\uf187",
                                      @"\uf188",@"\uf189",@"\uf18A",@"\uf18B",@"\uf18C",@"\uf18D",@"\uf18E",
                                      @"\uf190",@"\uf191",@"\uf192",@"\uf193",@"\uf194",@"\uf195",@"\uf196",@"\uf197",
                                      @"\uf198",@"\uf199",@"\uf19A",@"\uf19B",@"\uf19C",@"\uf19D",@"\uf19E",
                                      @"\uf1A0",@"\uf1A1",@"\uf1A2",@"\uf1A3",@"\uf1A4",@"\uf1A5",@"\uf1A6",@"\uf1A7",
                                      @"\uf1A8",@"\uf1A9",@"\uf1AA",@"\uf1AB",@"\uf1AC",@"\uf1AD",@"\uf1AE",
                                      @"\uf1B0",@"\uf1B1",@"\uf1B2",@"\uf1B3",@"\uf1B4",@"\uf1B5",@"\uf1B6",@"\uf1B7",
                                      @"\uf1B8",@"\uf1B9",@"\uf1BA",@"\uf1BB",@"\uf1BC",@"\uf1BD",@"\uf1BE",
                                      @"\uf1C0",@"\uf1C1",@"\uf1C2",@"\uf1C3",@"\uf1C4",@"\uf1C5",@"\uf1C6",@"\uf1C7",
                                      @"\uf1C8",@"\uf1C9",@"\uf1CA",@"\uf1CB",@"\uf1CC",@"\uf1CD",@"\uf1CE",
                                      @"\uf1D0",@"\uf1D1",@"\uf1D2",@"\uf1D3",@"\uf1D4",@"\uf1D5",@"\uf1D6",@"\uf1D7",
                                      @"\uf1D8",@"\uf1D9",@"\uf1DA",@"\uf1DB",@"\uf1DC",@"\uf1DD",@"\uf1DE",
                                      @"\uf1E0",@"\uf1E1",@"\uf1E2",@"\uf1E3",@"\uf1E4",@"\uf1E5",@"\uf1E6",@"\uf1E7",
                                      @"\uf1E8",@"\uf1E9",@"\uf1EA",@"\uf1EB",@"\uf1EC",@"\uf1ED",@"\uf1EE",
                                      @"\uf1F0",@"\uf1F1",@"\uf1F2",@"\uf1F3",@"\uf1F4",@"\uf1F5",@"\uf1F6",@"\uf1F7",
                                      @"\uf1F8",@"\uf1F9",@"\uf1FA",@"\uf1FB",@"\uf1FC",@"\uf1FD",@"\uf1FE",
                                      @"\uf200",@"\uf201",@"\uf202",@"\uf203",@"\uf204",@"\uf205",@"\uf206",@"\uf207",
                                      @"\uf208",@"\uf209",@"\uf20A",@"\uf20B",@"\uf20C",@"\uf20D",@"\uf20E",
                                      @"\uf211",@"\uf212",@"\uf213",@"\uf214",@"\uf215",@"\uf216",@"\uf217",
                                      @"\uf218",@"\uf219",@"\uf21A",@"\uf21B",@"\uf21C",@"\uf21D",@"\uf21E",
                                      @"\uf220",@"\uf221",@"\uf222",@"\uf223",@"\uf224",@"\uf225",@"\uf226",@"\uf227",
                                      @"\uf228",@"\uf229",@"\uf22A",@"\uf22B",@"\uf22C",
                                      @"\uf230",@"\uf231",@"\uf232",@"\uf233",@"\uf234",@"\uf235",@"\uf236",@"\uf237",
                                      @"\uf238",@"\uf239",@"\uf23A",@"\uf23B",@"\uf23C",@"\uf23D",@"\uf23E",];
        
    });
    
    return fontAwesomeUnicodeStrings;
}

+ (NSDictionary *)enumDictionary {
    
	static NSDictionary *enumDictionary;
    
    static dispatch_once_t enumDictionaryOnceToken;
    dispatch_once(&enumDictionaryOnceToken, ^{
        
		NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
		enumDictionary = tmp;
	});
    
    return enumDictionary;
}

@end
