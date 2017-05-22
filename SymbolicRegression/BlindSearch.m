//
//  BlindSearch.m
//  SymbolicRegression
//
//  Created by Michal Cisarik on 7/10/14.
//  Copyright (c) 2014 Michal Cisarik. All rights reserved.
//

#import "BlindSearch.h"

@implementation BlindSearch
@synthesize al_,au_,bl_,bu_;
-(instancetype) initWith64bits:(uint64) bits {
	if ( self = [super init] ) {
        gfs = [[GFS alloc]initWithFunctionSet:(uint64)bits andSeed:(unsigned int)time(NULL)];
        
        al_=0;
        au_=gfs.terminalsStartingIndex-1;
        bl_=au_;
        bu_=gfs.size-1;
        
        
        output=[[OUT alloc ]initWithConfiguration:[[Configuration all]copy] andGFS:gfs];
        
        dimension = MAXSIZE;//[gfs size];
        
        numberVectors = [[Configuration all][@"DE_vectors"]intValue];
		numberGenerations = [[Configuration all][@"DE_generations"]intValue];
      
        
        mersennetwister = [[MersenneTwister alloc] init];
        
		au = (double *)malloc(sizeof(double) * dimension);
        al = (double *)malloc(sizeof(double) * dimension);
        
        bu = (double *)malloc(sizeof(double) * dimension);
        bl = (double *)malloc(sizeof(double) * dimension);
        
        for (j = 0; j < dimension; j++) {
            
            al[j]=al_;
            au[j]=au_;
            
            bl[j]=bl_;
            bu[j]=bu_;
        
        }
        
        a_ = (int **) malloc(sizeof(int*) * numberVectors);
		a_[0] = (int *) malloc(sizeof(int) * dimension * numberVectors);
        
        b_ = (int **) malloc(sizeof(int*) * numberVectors);
		b_[0] = (int *) malloc(sizeof(int) * dimension * numberVectors);
        
        
        averageFitness = (double *) malloc(sizeof(double) * numberGenerations);
		bestFitnesses = (double *) malloc(sizeof(double) * numberGenerations);
		
        bestFitness = FLT_MAX;
        
        for ( i = 0; i < numberVectors; i++ ) {
			if(i) {
                
                a_[i] = a_[i-1] + numberVectors;
                
                b_[i] = b_[i-1] + numberVectors;
                
			}
		}
        
        
        
	} return self;
}

-(void)search{
    
    double best=DBL_MAX;
    double tmp=0;
    
    for (generation = 0; generation < numberGenerations; generation++){
        
        for ( i = 0; i < numberVectors; i++ ) {
            
            for (j = 0; j < dimension; j++) {
                
                a_[i][j]=[mersennetwister randomUInt32From:al[j] to:au[j]];
                b_[i][j]=[mersennetwister randomUInt32From:bl[j] to:bu[j]];
            }
        }
        
        for ( i = 0; i < numberVectors; i++ ) {
            
            for ( j = 0; j < numberVectors; j++ ) {
                [gfs repairA:&a_[i][0] withB:&b_[j][0]];
                
                if([gfs errorA:&a_[i][0] withB:&b_[j][0]] < best) {
                    iBest=i;
                    jBest=j;
                    best=[gfs errorA:&a_[i][0] withB:&b_[j][0]];
                }
            }
        }
        
        
        
        tmp=[gfs errorA:&a_[iBest][0] withB:&b_[jBest][0]];
        
        
        if ([output insertFitness:tmp string:[NSString stringWithFormat:@"%@",[gfs describeA:&a_[iBest][0] withB:&b_[jBest][0]] ] ofMethod:@"Singlethread Blind Search"]) {
            
        }
    }
}

-(void)free{
    free(au);
	free(al);
    free(bu);
    free(bl);
    free(a_[0]);
    free(a_);
    free(b_[0]);
    free(b_);
	free(averageFitness);
	free(bestFitnesses);
}

@end
