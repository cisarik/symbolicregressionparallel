//
//  Optimization.m
//  SymbolicRegression
//
//  Created by Michal Cisarik on 7/12/14.
//  Copyright (c) 2014 Michal Cisarik. All rights reserved.
//

#import "Optimization.h"

@implementation Optimization

@synthesize al_,au_,bl_,bu_;

-(instancetype)initWithFunctionSet:(uint64)bin andDefaultMethod:(NSString*)name
{
    self = [super init];
    if (self) {
        
        //uint32 seed=
        if ([name isEqualToString:@"Blind Search"])
            gfs=[[GFS alloc]initWithFunctionSet:bin andSeed:(unsigned int)time(NULL)*24231];
        else if ([name isEqualToString:@"Tabu Search"])
            gfs=[[GFS alloc]initWithFunctionSet:bin andSeed:(unsigned int)time(NULL)*931];
        else if ([name isEqualToString:@"Simulated Annealing"])
            gfs=[[GFS alloc]initWithFunctionSet:bin andSeed:(unsigned int)time(NULL)*31];
        else if ([name isEqualToString:@"Genetic Algorithm"])
            gfs=[[GFS alloc]initWithFunctionSet:bin andSeed:(unsigned int)time(NULL)*98321];
        else if ([name isEqualToString:@"Differential Evolution"])
            gfs=[[GFS alloc]initWithFunctionSet:bin andSeed:(unsigned int)time(NULL)*1325];
        else if ([name isEqualToString:@"SOMA"])
            gfs=[[GFS alloc]initWithFunctionSet:bin andSeed:(unsigned int)time(NULL)*25];
        
        
        
        
        defaultMethod=name;
        
        al_=0;
        au_=gfs.terminalsStartingIndex-1;
        bl_=gfs.terminalsStartingIndex;
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
    }
    return self;
}

-(void)search {
    
    //if ([defaultMethod isEqualToString:@"Blind Search"]) {
        [self blindSearch];
    //}
  
}


-(void)blindSearch{
    
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
        
        
        if ([output insertFitness:tmp string:[NSString stringWithFormat:@"%@",[gfs describeA:&a_[iBest][0] withB:&b_[jBest][0]]] ofMethod:defaultMethod]) {
            
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
