//
//  AppDelegate.h
//  SymbolicRegression
//
//  Created by Michal Cisarik on 8/14/13.
//  Copyright (c) 2013 Michal Cisarik. All rights reserved.
//

//#import "Coevolution.h"
//#import "BlindSearch.h"
#import "Heuristic.h"
#import "MersenneTwister.h"
NSLock *lock;
@import Cocoa;
@interface AppDelegate : NSObject <NSApplicationDelegate> {
    MersenneTwister *mt;
    Heuristic *heuristic;
}
@property NSPipe* pipe;
@property NSFileHandle* pipeReadHandle;
@property (assign) IBOutlet NSWindow *window;
@property (strong,nonatomic)IBOutlet NSTextView *_console;
@property (strong,nonatomic)IBOutlet NSImageView *_bestGraph;
-(void)nslog:(NSNotification *)notification;

@property (strong,nonatomic)IBOutlet NSTextField *_gfsField;
@property (strong,nonatomic)IBOutlet NSTextField *_gfsDescriptionField;

@property (strong,nonatomic)IBOutlet NSButton *_BlindSearch;

-(void)markButton:(NSButton*)button withColor:(NSColor*)color;
-(IBAction)doAnalyze:(id)sender;
-(void)describeGFS:(uint64)bin;
@end
