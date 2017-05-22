//
//  Coevolution.h
//  MDME
//
//  Created by Michal Cisarik on 11/12/13.
//  Copyright (c) 2013 Michal Cisarik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MersenneTwister.h"
#import "DE.h"
#import "GFS.h"

@interface Coevolution : NSObject

-(instancetype)initAndSeed:(unsigned int) seed NS_DESIGNATED_INITIALIZER;
-(unsigned long) migratingTo64bits:(uint64)index;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) id bestEvolution;
-(void)coevolveOptimized;
-(void)coevolve;
-(void)analyze;
-(void)blind;
-(void)evolve;
-(void)free;
@end
