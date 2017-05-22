//
//  Heuristic.h
//  SymbolicRegression
//
//  Created by Michal Cisarik on 7/12/14.
//  Copyright (c) 2014 Michal Cisarik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Optimization.h"

@interface Heuristic : NSObject 
-(instancetype)initWithGFSbin:(uint64)gfsbin NS_DESIGNATED_INITIALIZER;
-(void)search;
@end
