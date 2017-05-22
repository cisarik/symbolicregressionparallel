//
//  Coevolution.m
//  MDME
//
//  Created by Michal Cisarik on 11/12/13.
//  Copyright (c) 2013 Michal Cisarik. All rights reserved.
//

#import "Coevolution.h"

@implementation Coevolution {
    // Variables, which are usable inside block
    // "dispatch_group_async(evolutions,high,^{ ... });"
    // where MDME algorithms take place.
    // race conditions are solved by global high-priority OSX dispatcher
    
    __block NSMutableArray* evolutions;
    
    // Variables for grand central dispatch:
    dispatch_group_t evolution_threads;
    dispatch_queue_t high;
    dispatch_queue_t queue;
    
    // Migrating vectors matrix:
    uint64 **migrating;
    
    // other variables which blocks need (configuration):
    __block NSNumber *vect;
    __block NSNumber *generations;
    __block NSNumber *scalingFactor;
    __block NSNumber *crossProb;
    __block NSNumber *mutProb;
    __block NSNumber *migProb;
    __block NSNumber *migrations;
    
    // just indexes used within the block
    __block int i,ib;
    
    // loop indexes and 'constants'
    int j,k,threads,gen,dimension;
    
    // stats:
    double current;
    double maximum;
    double minimum;
    double average;
    
    // string buffer:
    NSString *s;
    
    MersenneTwister *mersennetwister;
    
    int index,groups;
    
    DE *de;
}

// Instantiation
-(instancetype)initAndSeed:(unsigned int) seed{
    self = [super init];
    if (self) {
        
        
        NSLog(@"MersenneTwister seed=%d",seed);
        mersennetwister=[[MersenneTwister alloc] initWithSeed:seed];
        
        evolutions=[[NSMutableArray alloc]init];
        
        // load all needed configuration from Configuration class:
        vect = [Configuration all][@"MDME_vectors"];
        generations = [Configuration all][@"MDME_generations"];
        scalingFactor = [Configuration all][@"MDME_scalingFactor"];
        crossProb = [Configuration all][@"MDME_crossProb"];
        mutProb = [Configuration all][@"MDME_mutProb"];
        migProb = [Configuration all][@"MDME_migProb"];
        migrations = [Configuration all][@"MDME_migrations"];
        
        // set threads count according to migrations
        threads = 2;//[migrations intValue];
        groups = 1;
        dimension = migrations.intValue;
        
        // create grand central dispatch queue:
        queue = dispatch_queue_create("com.cisary.queue",0);
        
        // obtain global queue:
        high = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0);
        
        // apply high-priority:
        dispatch_set_target_queue(queue,high);
        
        // with grand central dispatch set we can create our own block 'group':
        evolution_threads = dispatch_group_create();

        // allocate matrix for vector migration:
        migrating = (uint64 **) malloc(sizeof(uint64*) * dimension);
        migrating[0] = (uint64 *) malloc(sizeof(uint64) * threads * dimension);
        
        // reconfigure migrating matrix for correct indexing: TODO
        for ( i = 0; i < threads; i++ )
			if(i)
                migrating[i] = migrating[i-1] + threads;
        
        for ( i = 0; i < threads; i++ ) {
                migrating[0][i] = [mersennetwister randomUInt32From:0 to:2147483648];
                [evolutions addObject: [[DE alloc]initWith64bits:migrating[0][i]]];
        }
        
    }
    return self;
}

-(void)analyze {
    for (gen = 0; gen < 1; gen++) {
        for (index = 0; index < 1; index++) {
            [self coevolve];
            
        }
    }
}

-(void)evolve {
    de=[[DE alloc]initWith64bits:UINT32_MAX];
    [de evolve];
    
}

-(void)blind {
    de=[[DE alloc]initWith64bits:UINT32_MAX];
    [de blind];
}

-(void)coevolve {

    __block NSMutableDictionary *indexes;
    // DE *des;
    
    indexes= [[NSMutableDictionary alloc] initWithObjectsAndKeys:@0,@"i",@0,@"ia",@0,@"ib",nil];
    
    i=0;
    ib=0;
    
    
    // synchronized part: we increment i of the __block dictionary indexes in the begging
    // of the thread so that we have to set -1 because first thread needs 0 as (it's array) index
    //
    [indexes setValue:@-1 forKey:@"i"];
    
    // dispatch all threads in the <evolution_threads> group with high priority
    //
    for (j = 0; j < threads; j++) {
        
            dispatch_group_async(evolution_threads, high, ^{ // parallel BLOCK starts here...
              
                @try {
                    
                    // declare block's local variable for one actual evolution:
                    //
                    DE *de;
                    
                    // we have to ensure that every thread will have right instance of DE
                    //
                    @synchronized (indexes) {
                        
                        // get shared object i from NSMutableDictionary allocated once
                        // and save it to newly created local variable
                        //
                        int _index=[indexes[@"i"]intValue];
                        
                        // in every thread we use defferent index by incrementing it right away:
                        [indexes
                         setValue:@(_index+1)
                         forKey:@"i"];
                        
                        // set local variables of the block (thread-specific) according to thread index
                        // variable <evolutions> is declared as:
                        // __block NSMutableArray* evolutions; in Coevolution interface itself
                        //
                        de=evolutions[_index];
                    }
                    
                    // async call - main work of the thread: metaevolution itsef:
                    [de blind];
                    
                }
                
                // if anything went wrong catch exception, log it and do what is needed to continue evaluation of coevolution
                //
                @catch(NSException *e) {
                    
                    NSString *tt= [NSString stringWithFormat:@"\n!\n!\n!Exception: %@",e.name];
                    
                    /*
                    if ([[e name] isEqualToString:@"generationswithnochange reached!"]){
                        [alg resetMigrate];
                    }
                    
                    
                    else if ([[e name] isEqualToString:@"newest extreme ever found!"]) {
                        
                        //@throw e; ?? What should I do with exception in the parallel BLOCK?
                    }
                     */
                    NSLog(@"!!EXCEPTION!!%@",tt);
                }
            });
    }
    //});
    
    //high = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,NULL);
    
    // apply high-priority:
    //dispatch_set_target_queue(queue,high);
    
    // we have to wait for each thread to evolve <DE_
    //
    dispatch_group_wait(evolution_threads, INFINITY); // barrier!
    
    // parse results:
    //
    
    for (DE* de in evolutions) {
        NSLog(@">>%@",de);
    }
    
        //s=[NSString stringWithString:@""];
        
        //int x=32;
        
        
        //average = 0;
        //i=0;
        /*TODO06
        for (MDME* alg in evolutions) {
            for(j=0;j<x;j++)
                migrating[i][j]=[alg bestbuffer][j];
            i++;
            average+=[alg bestFitness];
        }
        
        average = average/(double)i;
        i=0;
        
        for (MDME* alg in evolutions) {
            
            s=[NSString stringWithFormat:@"MDME%i Best:\n%@\n", i, alg];
      
            NSLog(@"%@",s);
            
            
            if ([alg bestFitness] < current) {
                current = [alg bestFitness];
                best = alg;
            }
            i++;
        }
        
        s=[NSString stringWithFormat:@"%i\n", index];
        NSLog(@"------------------------------------------------------------------------");

        NSLog(@"%i. generation of coevolution\nbest :\n %@\n",gen,1.0);
        NSLog(@"Coevolution average : %.0f",average);
        NSLog(@"------------------------------------------------------------------------");
        */
        /*TODO07
        for (MDME* alg in evolutions) {
            
            [alg migrate:migrating];
            
        }
        */
   // }
    //NSLog(@"------------------------------------------------------------------------");
}

-(NSString*)description{
    
    NSMutableString *mutableout=[NSMutableString stringWithFormat:@""];
    NSMutableString* buffer=[NSMutableString stringWithFormat:@""];
    
    for (id e in evolutions)
        [buffer appendString:[NSString stringWithFormat:@"%@\n",e]];
    
    
    [mutableout appendString:[NSString stringWithFormat:@"===\n%@===",buffer]];
    
    return mutableout;

}

-(void)free{
    for (id e in evolutions)
        [e free];
    [evolutions removeAllObjects];
    evolutions=nil;
    free(migrating[0]);
    free(migrating);
}
@end
