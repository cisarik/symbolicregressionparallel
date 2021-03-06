////  GFS.h //  Testovanie //  Created by Michal Cisarik on 8/1/13.  //
////  Copyright (c) 2013 Michal Cisarik. All rights reserved.        //

#import <Foundation/Foundation.h>
#import "MersenneTwister.h"

// ================== // ERRORS AND EXCEPTIONS // ================== //
@interface NotEnoughTerminalsInRepairingArray : NSException
@end

@interface UnexpectedBehavior : NSException
@end

// ====================== // CONSTANTS // ========================== //
//
// This values should be experimentally tested and optimal values should be determined according to stats
//
#define MAXWIDTH 6
#define MAXDEPTH 9
#define MAXSIZE 32
#define MAXCONSTANTS 32
#define MINCONSTANT 0.1
#define MAXCONSTANT 100

// ========================= // TYPES // =========================== //
typedef double (^func2)(double,double);
typedef double (^func1)(double);
typedef double (^func0)(void);

typedef double (^input2D)(double);
typedef double (^input3D)(double,double);


// ====================== // PROTOCOLS // ========================== //
@protocol GFS2args <NSObject>
-(double) eval:(double)parameter1 and:(double)parameter2;
@end

@protocol GFS1args <NSObject>
-(double) eval:(double)a;
@end

@protocol GFS0args <NSObject>
@property (NS_NONATOMIC_IOSONLY, readonly) double eval;
@end

@protocol GFSvariable <NSObject>
@end

@protocol GFSconstant <NSObject>
@end

@protocol GFSreinforced <NSObject>
@end


// ======================== // INTERFACES // ======================= //
@interface Configuration : NSObject {
    
}
+(NSDictionary*) all;
@end


@interface GFSelement : NSObject {
    NSString *name;
}
@property (retain) NSString* name;
@end

@interface GFSvar : GFSelement <GFSvariable>{
    double* variable;
}
-(instancetype)initWith:(double *)n name:(NSString *)s NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, readonly) double value;
@end

@interface GFSconst : GFSelement <GFSconstant>{
    double* constant;
}
-(instancetype)initWith:(double *)n NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, readonly) double value;
@end

@interface GFS1 : GFSelement <GFS1args>{
    func1 function;
}
-(double) eval:(double)parameter1;
@end

@interface GFS2 : GFSelement <GFS2args>{
    func2 function;
}
-(double) eval:(double)parameter1 and:(double)parameter2;
@end

@interface GFS0 : GFSelement <GFS0args>{
    func0 function;
}
@property (NS_NONATOMIC_IOSONLY, readonly) double eval;
@end

@interface FS : NSObject {
    
}
+(NSDictionary*) mask:(uint64)b;
@end




@interface Calculation : NSObject{
@public
    int  i;
    int* array;
    int* last;
    int* len;
    int* repairing;
    int* lastrepairing;
    int* lastbigger;
    int  depth;
    int  last_static;
    int  len_static;
    int  lastrepairing_static;
    int  lastbigger_static;
}
-(instancetype)initWithArray:(int*)a andRepairing:(int*)b;
-(void)nullCalculation;
@end

@interface IN : NSObject
+(NSMutableArray*) ekvidistantDoublesCount:(int)count min:(double)m max:(double)mx;
@end



@interface GFS : NSObject {
    NSMutableArray* elements;
    MersenneTwister *mersennetwister;
    uint64 bin;
    int functions;
    int constants;
    int reinforcementStartingIndex;
    int size;
    int xpos;
    int terminalsStartingIndex;
    int bit1;
    int bit2;
    int bit3;
    int bit4;
    int bit5;
    int bit6;
    int bit7;
    int bit8;
    int bit9;
    int bit10;
    int bit11;
    int bit12;
    int bit13;
    int bit14;
    int bit15;
    int bit16;
    int bit17;
    int bit18;
    int bit19;
    int bit20;
    int bit21;
    int bit22;
    int bit23;
    int bit24;
    int bit25;
    int bit26;
    int bit27;
    int bit28;
    int bit29;
    int bit30;
    int bit31;
    int bit32;
}
@property int functions;
@property int constants;
@property int size;
@property int reinforcementStartingIndex;
@property int xpos;
@property BOOL variableNameInsteadOfValue;
@property int terminalsStartingIndex;
@property uint64 bin;

@property (retain) NSMutableArray* elements;

-(void)reinforceWith:(NSString *)s;

-(instancetype)initWithFunctionSet:(uint64)fsb andSeed:(uint32)seed NS_DESIGNATED_INITIALIZER;

-(NSString *)toStringRecursive:(int[])array at:(int) i last:(int*)last max:

(int*)len repairing:(int [])repairing lastrepairing:(int*)lastrepairing lastbigger:(int*)lastbigger;

-(double)evaluateRepairingRecursive:(int[])array at:(int) i last:(int*)last max:(int*)len repairing:(int [])repairing lastrepairing:(int*)lastrepairing lastbigger:(int*)lastbigger depth:(int*)depth;

-(double)evaluateRecursive:(int[])array at:(int) i last:(int*)last max:(int*)len repairing:(int [])repairing lastrepairing:(int*)lastrepairing lastbigger:(int*)lastbigger depth:(int*)depth;

-(void)setValueOf:(NSString*)var value:(double)val;

-(int)repairA:(int[])_a withB:(int[])_b;

-(double)errorA:(int[])_a withB:(int[])_b;

-(double)errorA:(int[])_a withB:(int[])_b andC:(double[])_c;

-(NSString *)stringA:(int[])_a withB:(int[])_b;

-(NSString *)describeA:(int[])_a withB:(int[])_b;

-(int)implantReinsOf:(int[])a len:(int)len;

-(void)null;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *description;

@end

@interface GFSrein : GFSelement <GFSreinforced> {
    int endmarker;
    NSString *tex;
}
//@property (strong) GFS* gfs;
@property int endmarker;
@property NSString *tex;

@property (NS_NONATOMIC_IOSONLY, readonly) double eval;
-(instancetype)initWithArray:(int [])n andGFS:(GFS *)gfs repairing:(int[])rep NS_DESIGNATED_INITIALIZER;
-(instancetype)initWithString:(NSString *)s andGFS:(GFS*)g NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, getter=getArray, readonly) int *array;
@property (NS_NONATOMIC_IOSONLY, getter=getEnd, readonly) int end;
@end

@interface OUT : NSObject {
    GFS *gfs;
    NSDictionary *configuration;
    NSMutableDictionary *calculations;
    
}
@property (readwrite,retain) GFS* gfs;
@property (readwrite) NSDictionary *configuration;
@property (readwrite) NSMutableDictionary *calculations;
-(instancetype)initWithConfiguration:(NSDictionary*) conf andGFS:(GFS*)gfs NS_DESIGNATED_INITIALIZER;
-(BOOL)insertFitness:(double)i string:(NSString*)s ofMethod:(NSString*)m;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *description;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *bestDescription;
@end

