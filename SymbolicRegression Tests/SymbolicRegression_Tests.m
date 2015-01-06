//
//  SymbolicRegression_Tests.m
//  SymbolicRegression Tests
//
//  Created by Michal Cisarik on 5/25/14.
//  Copyright (c) 2014 Michal Cisarik. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DE.h"


@interface SymbolicRegression_Tests : XCTestCase {
    int **buffer;
    DE *de;
    GFS *gfs;
    OUT *output;
    MersenneTwister *mt;
    double fitness;
}
@property int** buffer;
@property DE *de;
@property GFS *gfs;
@property OUT* output;
@property MersenneTwister *mt;

@end

@implementation SymbolicRegression_Tests
@synthesize output,gfs,buffer,mt,de;
- (void)setUp
{
    [super setUp];
    //gfs = [[GFS alloc]initWithFunctionSet:UINT64_MAX];
    mt=[[MersenneTwister alloc]initWithSeed:(uint32)time(NULL)];
    
    //NSLog(@"%@",[Configuration all]);
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDE{
    
   de = [[DE alloc]initWith64bits:UINT32_MAX];
    
    [de metaEvolve];
    
    NSLog(@"%@",de);
    int i=0;
}



- (void)testGFSdescription
{
    NSString *s=[NSString stringWithFormat:@"%@",[[GFS alloc]initWithFunctionSet:UINT64_MAX]];
    
    XCTAssertEqualObjects(s, @"{+,-,*,/,sin,cos,tan,log,log2,log10,^2,^3,^4,^5,^6,^,2^,pi^,e^,x,1,2,3,4,5,6,7,8,9,pi,e,phi,}", @"Hmm");
    
    s=[NSString stringWithFormat:@"%@",[[GFS alloc]initWithFunctionSet:UINT16_MAX]];
    
    XCTAssertEqualObjects(s, @"{+,-,*,/,sin,cos,tan,log,log2,log10,^2,^3,^4,^5,^6,x,1,}", @"Hmm");
    
    s=[NSString stringWithFormat:@"%@",[[GFS alloc]initWithFunctionSet:UINT8_MAX]];
    
    XCTAssertEqualObjects(s, @"{+,-,*,/,sin,cos,tan,log,x,}", @"Hmm");
    
    int i=8;
}

- (void)testGFSrein{
    gfs = [[GFS alloc]initWithFunctionSet:33554431];
    NSString *gfsdesc=[gfs description];
    int gfs_size_before_reinforcement=[gfs size];
    
    NSString *str=@"\n33554431\n[3,1,16,14,16,7,16,3,8,12,3,0,14,0,14,10,9,14,13,6,12,10,7,6,7,7,13,6,4,8,14,1,]\n[18,20,24,22,19,19,15,20,19,23,20,16,22,23,17,17,17,16,24,24,17,22,17,18,25,18,15,16,25,21,19,17,]\n(((tan(x))^5-x)/x)\n35.67489850579427\n\n";
    
    
    NSString *str2=@"\n33554431\n[7,0,7,22,9,0,22,22,0,0,0,5,14,2,0,0,14,0,0,9,0,10,0,14,0,0,8,7,0,0,0,9,]\n[22,22,22,15,22,17,19,24,16,25,22,16,24,23,21,22,19,22,22,22,21,22,22,16,22,22,22,22,21,22,22,22,]\ntan((tan(log2((6+6)))+6))\n5.895613405502197\n\n";
    
    //NSString *str3=@"
    
    [gfs reinforceWith:str];
    
    [gfs reinforceWith:str2];
    
    int* a = (int *) malloc(sizeof(int) * MAXSIZE);
    int* b = (int *) malloc(sizeof(int) * MAXSIZE);
    
    for (int i=0; i<200; i++) {
        a[i]=0;
        b[i]=[gfs terminalsStartingIndex];
    }
    a[1]=1;
    b[0]=26;
    //b[1]=27;
    
    NSMutableString *buffer1=[NSMutableString stringWithFormat:@""];
    NSMutableString *buffer2=[NSMutableString stringWithFormat:@""];
    int v;
    for (v = 0; v < 20; v++) {
        [buffer1 appendString:[NSString stringWithFormat:@"%d,",a[v]]];
        [buffer2 appendString:[NSString stringWithFormat:@"%d,",b[v]]];
    }
    
    int end=[gfs repairA:&a[0] withB:&b[0]];
    //int afterimplantlength=[gfs implantReinsOf:&a[0] len:end];
    buffer1=[NSMutableString stringWithFormat:@""];
    buffer2=[NSMutableString stringWithFormat:@""];
    
    for (v = 0; v < end; v++) {
        [buffer1 appendString:[NSString stringWithFormat:@"%d,",a[v]]];
        [buffer2 appendString:[NSString stringWithFormat:@"%d,",b[v]]];
    }
    
    
    NSString* name=[NSString stringWithFormat:@"%@",[gfs describeA:&a[0] withB:&b[0]]];
    
    
    //XCTAssertEqualObjects([NSNumber numberWithInt:gfs_size_before_reinforcement+1],[NSNumber numberWithInt:[gfs size]],"- add reinforcement string o.k. gfs is now bigger");
    
    //XCTAssertEqualObjects([testing_reinforcement name], @"(((tan(x))^5-x)/x)", @"- function name parsed o.k.");
}

- (void)testGFScalculationRepairing{
    gfs=[[GFS alloc]initWithFunctionSet:UINT8_MAX];
    output=[[OUT alloc ]initWithConfiguration:[Configuration all] andGFS:gfs];
    
    
    int _t=[gfs terminalsStartingIndex];
    
    int* a = (int *) malloc(sizeof(int) * 32);
    int* b = (int *) malloc(sizeof(int) * 32);
    
    for (int i=0; i<32; i++) {
        a[i]=[mt randomUInt32From:0 to:[gfs terminalsStartingIndex]];
        b[i]=[mt randomUInt32From:[gfs terminalsStartingIndex] to:[gfs size]];
    }
    
    
    NSMutableString *buffer1=[NSMutableString stringWithFormat:@""];
    NSMutableString *buffer2=[NSMutableString stringWithFormat:@""];
    
    for (int v = 0; v < 32; v++) {
        [buffer1 appendString:[NSString stringWithFormat:@"%d,",a[v]]];
        [buffer2 appendString:[NSString stringWithFormat:@"%d,",b[v]]];
    }
    
    NSLog(@"\na=[%@]\nb=[%@]\n",buffer1,buffer2);
    
    [gfs repairA:a withB:b];
    
    buffer1=[NSMutableString stringWithFormat:@""];
    
    for (int v = 0; v < 32; v++) {
        [buffer1 appendString:[NSString stringWithFormat:@"%d,",a[v]]];
    }
    
    NSLog(@"%@\n",buffer1);
    
    fitness=[gfs errorA:a withB:b];
    
    gfs.variableNameInsteadOfValue=YES;
    
    

    [output insertFitness:fitness string:[NSString stringWithFormat:@"\n%d\n[%@]\n[%@]\n%@\n>%@",[gfs bin],buffer1,buffer2,[gfs stringA:a withB:b],[NSNumber numberWithDouble:fitness]]];
    
    NSLog(@"%@",output);
    int sdi=3;
    XCTAssertEqualObjects(output, @"s", @"Hmm");
}


@end
