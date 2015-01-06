//
//  BlindSearch.h
//  SymbolicRegression
//
//  Created by Michal Cisarik on 7/10/14.
//  Copyright (c) 2014 Michal Cisarik. All rights reserved.
//

#import "GFS.h"

@interface BlindSearch : NSObject {
    
    // properties
	int dimension;
	int numberGenerations;
	int numberVectors;
    
    // matrix arrays pointers for malloc
	int **a_;
    int **b_;
    
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
}
@property(readwrite) double al_;
@property(readwrite) double au_;
@property(readwrite) double bl_;
@property(readwrite) double bu_;
-(id) initWith64bits:(uint64) bits;
-(void) search;
-(void) free;
@end
