//
//  Heuristic.m
//  SymbolicRegression
//
//  Created by Michal Cisarik on 7/12/14.
//  Copyright (c) 2014 Michal Cisarik. All rights reserved.
//

#import "Heuristic.h"

@implementation Heuristic {
    
    // Variables, which are usable inside block
    // "dispatch_group_async(evolutions,high,^{ ... });"
    // where MDME algorithms take place.
    // race conditions are solved by global high-priority OSX dispatcher
    
    __block NSMutableArray* optimizations;
    __block int i,ib;
    
    // Variables for grand central dispatch:
    dispatch_group_t optimization_threads;
    dispatch_queue_t high;
    dispatch_queue_t queue;
    
    // loop indexes and 'constants'
    int j,k,threads;
    
    uint64 bin;
}

- (id)initWithGFSbin:(uint64)gfsbin
{
    self = [super init];
    if (self) {
        
        optimizations=[[NSMutableArray alloc]initWithCapacity:7];
        
        // set threads count according to migrations
        threads = 6;//[migrations intValue];
        
        // create grand central dispatch queue:
        //queue = dispatch_queue_create("com.cisary.symbolicregression.queue",DISPATCH_QUEUE_CONCURRENT);
        
        // obtain global queue:
        //high = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0);
        
        //high=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        
        // apply high-priority:
        //dispatch_set_target_queue(queue,high);
        
        // with grand central dispatch set we can create our own block 'group':
        //optimization_threads = dispatch_group_create();
        
        /*
        for ( i = 0; i < threads; i++ ) {
            
        }
        */
        /*
        [optimizations addObject:[[Optimization alloc]initWithFunctionSet:bin
                                                         andDefaultMethod:@"Blind Search"]];
        
        [optimizations addObject:[[Optimization alloc]initWithFunctionSet:bin
                                                         andDefaultMethod:@"Tabu Search"]];
        
        [optimizations addObject:[[Optimization alloc]initWithFunctionSet:bin
                                                         andDefaultMethod:@"Simulated Annealing"]];
        
        [optimizations addObject:[[Optimization alloc]initWithFunctionSet:bin
                                                         andDefaultMethod:@"Genetic Algorithm"]];
        
        [optimizations addObject:[[Optimization alloc]initWithFunctionSet:bin
                                                         andDefaultMethod:@"Differential Evolution"]];
        
        [optimizations addObject:[[Optimization alloc]initWithFunctionSet:bin
                                                         andDefaultMethod:@"SOMA"]];
        */
        
        /*
        dispatch_queue_t queue1=dispatch_queue_create("com.cisary.symbolicregression.queue1",DISPATCH_QUEUE_SERIAL);
        
        dispatch_group_async(dispatch_group_create(),queue1, ^{ // Blind Search
            [[[Optimization alloc]initWithFunctionSet:bin
                                    andDefaultMethod:@"Blind Search"]search];
        });
        dispatch_queue_t queue2=dispatch_queue_create("com.cisary.symbolicregression.queue2",DISPATCH_QUEUE_SERIAL);
        dispatch_group_async(dispatch_group_create(),queue2, ^{ // Blind Search
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Tabu Search"]search];
        });
        dispatch_queue_t queue3=dispatch_queue_create("com.cisary.symbolicregression.queue3",DISPATCH_QUEUE_SERIAL);
        dispatch_group_async(dispatch_group_create(),queue3, ^{ // Blind Search
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Simulated Annealing"]search];
        });
        dispatch_queue_t queue4=dispatch_queue_create("com.cisary.symbolicregression.queue4",DISPATCH_QUEUE_SERIAL);
        dispatch_group_async(dispatch_group_create(),queue4, ^{ // Blind Search
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Genetic Algorithm"]search];
        });
        dispatch_queue_t queue5=dispatch_queue_create("com.cisary.symbolicregression.queue5",DISPATCH_QUEUE_SERIAL);
        dispatch_group_async(dispatch_group_create(),queue5, ^{ // Blind Search
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Differential Evolution"]search];
        });
        dispatch_queue_t queue6=dispatch_queue_create("com.cisary.symbolicregression.queue6",DISPATCH_QUEUE_SERIAL);
        dispatch_group_async(dispatch_group_create(),queue6, ^{ // Blind Search
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"SOMA"]search];
        });
         */
        
        
        
        
        
        /*
        NSOperationQueue *operations = [[NSOperationQueue alloc] init];
        [operations setMaxConcurrentOperationCount:17];
        
        
        NSOperation *complete = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"END");
        }];
        
        
        NSOperation *blindSearch = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Blind Search"]search];
        }];
        
        //[complete addDependency:blindSearch];
        [operations addOperation:blindSearch];
        [blindSearch start];
        NSOperation *tabuSearch = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Tabu Search"]search];
        }];
        
        //[complete addDependency:tabuSearch];
        [operations addOperation:tabuSearch];
        [tabuSearch start];
        NSOperation *simulatedAnnealing = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Simulated Annealing"]search];
        }];
        
        //[complete addDependency:simulatedAnnealing];
        [operations addOperation:simulatedAnnealing];
        [simulatedAnnealing start];
        NSOperation *geneticAlgorithm = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Genetic Algorithm"]search];
        }];
        
        //[complete addDependency:geneticAlgorithm];
        [operations addOperation:geneticAlgorithm];
        [geneticAlgorithm start];
        NSOperation *differentialEvolution = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Differential Evolution"]search];
        }];
        
        //[complete addDependency:differentialEvolution];
        [operations addOperation:differentialEvolution];
        [differentialEvolution start];
        NSOperation *soma = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"SOMA"]search];
        }];
        //[complete addDependency:soma];
        [operations addOperation:soma];
        //BOOL a=[soma isConcurrent];
        [soma start];
        //[operations se]
        //[operations addOperation:complete];
         */
        
        
        /*
        NSOperationQueue *op1 = [[NSOperationQueue alloc] init];
        NSOperation *blindSearch = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Blind Search"]search];
        }];
        [op1 addOperation:blindSearch];
        //[blindSearch start];
        
        NSOperationQueue *op2 = [[NSOperationQueue alloc] init];
        NSOperation *tabuSearch = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Tabu Search"]search];
        }];
        
        //[complete addDependency:tabuSearch];
        [op2 addOperation:tabuSearch];
        //[tabuSearch start];
        NSOperation *simulatedAnnealing = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Simulated Annealing"]search];
        }];
        NSOperationQueue *op3 = [[NSOperationQueue alloc] init];
        //[complete addDependency:simulatedAnnealing];
        [op3 addOperation:simulatedAnnealing];
        //[simulatedAnnealing start];
        NSOperation *geneticAlgorithm = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Genetic Algorithm"]search];
        }];
        NSOperationQueue *op4 = [[NSOperationQueue alloc] init];
        //[complete addDependency:geneticAlgorithm];
        [op4 addOperation:geneticAlgorithm];
        //[geneticAlgorithm start];
        NSOperation *differentialEvolution = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"Differential Evolution"]search];
        }];
        NSOperationQueue *op5 = [[NSOperationQueue alloc] init];
        //[complete addDependency:differentialEvolution];
        [op5 addOperation:differentialEvolution];
        //[differentialEvolution start];
        NSOperation *soma = [NSBlockOperation blockOperationWithBlock:^(void){
            [[[Optimization alloc]initWithFunctionSet:bin
                                     andDefaultMethod:@"SOMA"]search];
        }];
        //[complete addDependency:soma];
        NSOperationQueue *op6 = [[NSOperationQueue alloc] init];
        [op6 addOperation:soma];
        //BOOL a=[soma isConcurrent];
        //[soma start];
        //[operations se]
        //[operations addOperation:complete];
         
         */
        
        //[NSThread detachNewThreadSelector:@selector(aMethod:) toTarget:[MyObject class] withObject:nil];
        
        bin=gfsbin;
        
        /*
        
         */
    }
    return self;
}

-(void)search{
    
    Optimization *o1=[[Optimization alloc]initWithFunctionSet:bin andDefaultMethod:@"Blind Search"];
    NSThread *thr1 = [[NSThread alloc] initWithTarget:o1 selector:@selector(search) object:nil];
    [thr1 start];
    
    Optimization *o2=[[Optimization alloc]initWithFunctionSet:bin andDefaultMethod:@"Tabu Search"];
    NSThread *thr2 = [[NSThread alloc] initWithTarget:o2 selector:@selector(search) object:nil];
    [thr2 start];
    
    Optimization *o3=[[Optimization alloc]initWithFunctionSet:bin andDefaultMethod:@"Simulated Annealing"];
    NSThread *thr3 = [[NSThread alloc] initWithTarget:o3 selector:@selector(search) object:nil];
    [thr3 start];
    
    Optimization *o4=[[Optimization alloc]initWithFunctionSet:bin andDefaultMethod:@"Genetic Algorithm"];
    NSThread *thr4 = [[NSThread alloc] initWithTarget:o4 selector:@selector(search) object:nil];
    [thr4 start];
    
    Optimization *o5=[[Optimization alloc]initWithFunctionSet:bin andDefaultMethod:@"Differential Evolution"];
    NSThread *thr5 = [[NSThread alloc] initWithTarget:o5 selector:@selector(search) object:nil];
    [thr5 start];
    
    Optimization *o6=[[Optimization alloc]initWithFunctionSet:bin andDefaultMethod:@"SOMA"];
    NSThread *thr6 = [[NSThread alloc] initWithTarget:o6 selector:@selector(search) object:nil];
    [thr6 start];
    
    
    /*
    __block NSMutableDictionary *indexes;
    
    indexes= [[NSMutableDictionary alloc] initWithObjectsAndKeys:@0,@"i",@0,@"ia",@0,@"ib",nil];
    
    i=0;
    ib=0;
    
    
    // synchronized part: we increment i of the __block dictionary indexes in the begging
    // of the thread so that we have to set -1 because first thread needs 0 as (it's array) index
    //
    [indexes setValue:[NSNumber numberWithInt:0]forKey:@"i"];
    
//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0), ^{ // 1
    
    // dispatch all threads in the <optimization_threads> group with high priority
    //
    for (j = 0; j < threads; j++) {
        //dispatch_group_enter(optimization_threads);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0), ^{ // parallel BLOCK starts here...
            
            @try {
                
                // declare block's local variable for one actual evolution:
                //
                Optimization *optimization;
                
                // we have to ensure that every thread will have right instance of DE
                //
                @synchronized (indexes) {
                    
                    // get shared object i from NSMutableDictionary allocated once
                    // and save it to newly created local variable
                    //
                    int _index=[[indexes objectForKey:@"i"]intValue];
                    
                    // in every thread we use different index by incrementing it right away:
                    [indexes
                     setValue:[NSNumber numberWithInt:_index+1]
                     forKey:@"i"];
                    
                    // set local variables of the block (thread-specific) according to thread index
                    optimization=[optimizations objectAtIndex: _index ];
                }
                //dispatch_group_leave(optimization_threads);
                // async call - main work of the thread: metaevolution itsef:
                [optimization search];
                //dispatch_group_leave(optimization_threads);
            }
            
            // if anything went wrong catch exception, log it and do what is needed to continue evaluation of coevolution
            //
            @catch(NSException *e) {
                
                NSString *tt= [NSString stringWithFormat:@"\n!\n!\n!Exception: %@",[e name]];
                
     
                 if ([[e name] isEqualToString:@"generationswithnochange reached!"]){
                 //[alg resetMigrate];
                 }
                 
                 
                 else if ([[e name] isEqualToString:@"newest extreme ever found!"]) {
                 
                 //@throw e; ?? What should I do with exception in the parallel BLOCK?
                 }
     
                NSLog(@"!!EXCEPTION!!%@",tt);
            }
        });
        //dispatch_group_leave(optimization_threads);
    }
//});
//dispatch_release(optimization_threads);
    
    
    // we have to wait for each thread to finish it's optimization
    //
    //dispatch_barrier_async(queue, ^{
    //    NSLog(@"Hi, I'm the final block!\n");
    //});
    //dispatch_group_wait(optimization_threads, INFINITY); // barrier!
*/
}

@end
