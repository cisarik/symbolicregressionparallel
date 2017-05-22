//
//  Optimization.h
//  SymbolicRegression
//
//  Created by Michal Cisarik on 7/12/14.
//  Copyright (c) 2014 Michal Cisarik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFS.h"

@interface Optimization : NSObject {
    
    // properties
	int dimension;
	int numberGenerations;
	int numberVectors;
    
    // matrix arrays pointers for malloc
	int **a_;
    int **b_;
    
    // array defining "spiece" - intervals of optimization
	double *au;
    double *al;
    double *bu;
    double *bl;
    
    double* averageFitness;
    double* bestFitnesses;
    
    int i,j,generation,iBest,jBest;
    
    double al_,au_,bl_,bu_,bestFitness;
    
    GFS *gfs;
    
    // random generator:
    MersenneTwister *mersennetwister;
    
    // output
    OUT *output;
    
    NSString *defaultMethod;
}

@property(readwrite) double al_;
@property(readwrite) double au_;
@property(readwrite) double bl_;
@property(readwrite) double bu_;

-(instancetype) initWithFunctionSet:(uint64)bin andDefaultMethod:(NSString*)name NS_DESIGNATED_INITIALIZER;
-(void) search;
-(void) free;

@end
