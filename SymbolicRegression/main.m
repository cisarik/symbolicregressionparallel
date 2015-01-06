//
//  main.m
//  SymbolicRegression
//
//  Created by Michal Cisarik on 8/14/13.
//  Copyright (c) 2013 Michal Cisarik. All rights reserved.
//
/*
 #import <SenTestingKit/SenTestingKit.h>
 #import "GFS.h"
 
 @interface GFSTests : SenTestCase
 @property GFS *gfs;
 @end
 
 @implementation GFSTests
 @synthesize gfs;
 - (void)setUp {
 gfs = [[GFS alloc]initWithFunctionSet:(uint64_t)98930 *98930];
 [super setUp];
 }
 
 - (void)tearDown {
 [super tearDown];
 }
 
 -(void)testDescription {
 NSString *expected=@"GFS={+, -, *, /, log, sin, cos, tan, x, 2, 3, }";
 NSString *evaluated=[gfs description];
 STAssertTrue([evaluated isEqualToString:expected],@"GFS Description");
 }
 
 
 
 -(void)testEvaluate {
 [gfs setValueOf:@"x" value:(double)7];
 int a[20]={0,5,6,7,8,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
 int b[20]={10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10};
 
 Calculation *c=[[Calculation alloc]initWithArray:a andRepairing:b];
 
 NSString *calculated=[NSString stringWithFormat:@"%.11f", [gfs evaluateRepairing:c]];
 NSString *expected=@"0.34911499659";
 STAssertTrue([calculated isEqualToString:expected],@"Calculate");
 
 }
 
 -(void)testEvaluate_DivisionByZero {
 [gfs setValueOf:@"x" value:(double)3];
 int a[20]={3,6,8,8,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
 int b[20]={9,9,9,9,9,9,10,10,10,10,10,10,10,10,10,10,10,10,10,10};
 
 Calculation *c=[[Calculation alloc]initWithArray:a andRepairing:b];
 
 NSString *calculated=[NSString stringWithFormat:@"%.11f", [gfs evaluateRepairing:c]];
 NSString *repr=[[[GFSrein alloc]initWithArray:a andGFS:gfs repairing:b] name];
 
 STAssertTrue([@"(cos(3)/3)" isEqualToString:repr],@"Calculate");
 
 // google: cos ( 3 radians ) / 3 =
 // -0.32999749886
 
 STAssertTrue([@"-0.32999749887" isEqualToString:calculated],@"Calculate");
 
 
 }

 
 */
#import "Heuristic.h"

@import Cocoa;

int main(int argc, const char * argv[]) {
    
    
    
    // ARC enabled  - input function, blocks & thread groups are created within main block
    @autoreleasepool { // this may cause problems in tests because there is one global pool
        
        //Heuristic* heuristic=[[Heuristic alloc]initWithGFSbin:UINT64_MAX];
        
        //[heuristic search];
        
        /*
         for (int i =33; i<64; i++) {
         actualbit=1 << i;
        
        /*
        HMGL gr = mgl_create_graph(600,400);
        
        mgl_set_origin(gr,0,0,0);
        mgl_set_ranges(gr,-1,1,0,0.17,0,0);
        mgl_axis(gr,"xy","","");
        
        mgl_fplot(gr,"x^6-2*x^4+x^2","w","");
        mgl_fplot(gr,"(cos(((6/6)^5))^5)","","");
        
        //(cos(((6/6)^5))^5)
        
        
        mgl_title(gr,"((\\cos{((\\frac{6}{6})^5)})^5)","",9.9);
        mgl_write_frame(gr,"/Users/cisary/SymbolicRegression/SymbolicRegression/graph.png","desc");
        mgl_delete_graph(gr);
         */
        return NSApplicationMain(argc, argv);
    }
    
}
