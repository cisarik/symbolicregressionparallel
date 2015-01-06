//
//  AppDelegate.m
//  SymbolicRegression
//
//  Created by Michal Cisarik on 8/14/13.
//  Copyright (c) 2013 Michal Cisarik. All rights reserved.
//

#import "AppDelegate.h"
#include <mgl2/mgl_cf.h>



@implementation AppDelegate {
    __block IBOutlet NSTextView *_console;
    __block IBOutlet NSImageView *_bestGraph;
    IBOutlet NSTextField *_gfsField;
    IBOutlet NSTextField *_gfsDescriptionField;
    __block IBOutlet NSButton *_BlindSearch;
    __block NSButton *activeButton;
}
@synthesize _console,pipe,pipeReadHandle,_bestGraph,_gfsField,_gfsDescriptionField,_BlindSearch;


-(void)nslog:(NSNotification *)notification {
    [pipeReadHandle readInBackgroundAndNotify] ;
    
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,NULL),^{
    
    //lock = [[NSLock alloc] init];
    [lock lock];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        NSString *str = [[NSString alloc] initWithData: [[notification userInfo] objectForKey: NSFileHandleNotificationDataItem] encoding: NSASCIIStringEncoding];
        
        NSAttributedString* stdOutAttributedString = [[NSAttributedString alloc] initWithString:str];
        
        
        NSColor *green=[NSColor
                       colorWithRed:0/255.0
                       green:217/255.0
                       blue:54/255.0
                       alpha:1];
        
        @synchronized(_console){
            [_console.textStorage appendAttributedString:stdOutAttributedString];
            [_console.textStorage addAttribute:NSForegroundColorAttributeName value:green range:NSMakeRange(0, [_console.textStorage length])];
            
            [_console scrollRangeToVisible:NSMakeRange([_console.textStorage length],0)];
        }
        
        @synchronized(_bestGraph){
            HMGL gr = mgl_create_graph(600,400);
            
            mgl_set_origin(gr,0,0,0);
            
            
            if ([[[Configuration all] objectForKey:@"function2D"] isEqualTo:@"x^6-2*x^4+x^2"])
                mgl_set_ranges(gr,-1,1,0,0.17,0,0);
            else if ([[[Configuration all] objectForKey:@"function2D"] isEqualTo:@"x^5−2*x^3+x"])
                mgl_set_ranges(gr,-1,1,-2,2,0,0);
            
            
            mgl_axis(gr,"xy","","");
            
            NSArray *tmp = [NSArray arrayWithArray: [str componentsSeparatedByString:@"\n"]];
        
        if ([tmp count]>3) {
            
            NSString* method=[NSString stringWithString:[tmp objectAtIndex:1]];
            
            if ([method isEqualToString:@"Blind Search"]) {
                
            } else if ([method isEqualToString:@"Tabu Search"]) {
                
            } else if ([method isEqualToString:@"Simulated Annealing"]) {
                
            } else if ([method isEqualToString:@"Genetic Algorithm"]) {
                
            } else if ([method isEqualToString:@"Differential Evolution"]) {
                
            } else if ([method isEqualToString:@"SOMA"]) {
                
            }
            
            
            NSString *expression=[NSString stringWithString:[tmp objectAtIndex:6]];
            
            mgl_fplot(gr,[[[Configuration all] objectForKey:@"function2D"]UTF8String],"h","");
            
            mgl_fplot(gr,[expression UTF8String],"","");
            
            mgl_title(gr,[[NSString stringWithString:[tmp objectAtIndex:7]] UTF8String],"",8.9);
            mgl_write_frame(gr,"/Users/cisary/SymbolicRegression/SymbolicRegression/graph.png","");
            mgl_delete_graph(gr);
            
            NSImage *graph=[[NSImage alloc]initWithContentsOfFile:@"/Users/cisary/SymbolicRegression/SymbolicRegression/graph.png"];
            
            [_bestGraph setImage:graph];
            
        } else {
            mgl_fplot(gr,[[[Configuration all] objectForKey:@"function2D"]UTF8String],"h","");
            
            mgl_title(gr,[[[Configuration all] objectForKey:@"function2D"]UTF8String],"",8.9);
            
            
            mgl_write_frame(gr,"/Users/cisary/SymbolicRegression/SymbolicRegression/graph.png","");
            mgl_delete_graph(gr);
            
            NSImage *graph=[[NSImage alloc]initWithContentsOfFile:@"/Users/cisary/SymbolicRegression/SymbolicRegression/graph.png"];
            
            [_bestGraph setImage:graph];
            
            
            
        }
        }
    });
    [lock unlock];
}

-(void)describeGFS:(uint64)bin{
    [_gfsDescriptionField setStringValue:[NSString stringWithFormat:@"%@",[[GFS alloc]initWithFunctionSet:bin andSeed:(uint32)time(NULL)]]];
}

-(IBAction)randomize:(id)sender {
    uint64 val=[mt randomUInt32];
    [_gfsField setStringValue:[NSString stringWithFormat:@"%llu",val]];
    [self describeGFS:val];
}

-(IBAction)doAnalyze:(id)sender {
    /*
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        BlindSearch *blindSearch=[[BlindSearch alloc]initWith64bits:UINT64_MAX];
        
        [blindSearch search];
        
        });
    */
//dispatch_async(dispatch_get_main_queue(), ^(void){
//dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    uint64 val=UINT64_MAX;
    
    if (![[_gfsField stringValue]isEqualToString:@"UINT64 MAX"]) {
        val=(uint64_t)[_gfsField integerValue];
    }
    
    
           heuristic= [[Heuristic alloc]initWithGFSbin:val];
        
        [heuristic search];
    
//});
        //BlindSearch *blindSearch=[[BlindSearch alloc]initWith64bits:UINT64_MAX];
        
        //[blindSearch search];
    /*
    Coevolution *coevolution=[[Coevolution alloc]
                              
                              initAndSeed:(unsigned int)time(NULL)];
    
    //NSLog(@"DONE");
    
    [coevolution blind];//analyze?
    
    //[coevolution analyze];
    [coevolution free];*/
    
}

-(void)markButton:(NSButton*)button withColor:(NSColor*)color{
    NSString *title=[button title];
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:title];
    NSUInteger len = [attrTitle length];
    NSRange range = NSMakeRange(0, len);
    
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[NSColor blackColor]];
    [shadow setShadowOffset: NSMakeSize(1, -1)];
    [shadow setShadowBlurRadius: 5];
    
    
    //[attrTitle addAttribute:NSBackgroundColorAttributeName value:[NSColor blackColor] range:range];
    [attrTitle addAttribute:NSFontAttributeName value:[NSFont boldSystemFontOfSize:12.0] range:range];
    [attrTitle addAttribute:NSShadowAttributeName value:shadow range:range];
    [attrTitle addAttribute:NSForegroundColorAttributeName value:[NSColor whiteColor] range:range];
    [attrTitle fixAttributesInRange:range];
    [button setAttributedTitle:attrTitle];
}

-(void)applicationWillFinishLaunching:(NSNotification *)notification {
    mt=[[MersenneTwister alloc]init];
    [_gfsField setStringValue:@"UINT64 MAX"];
    
    
    [_BlindSearch setState:NSOffState];
    
    //[_BlindSearch setButtonType:NSPushOnPushOffButton];
    NSColor *green=[NSColor
                    colorWithRed:0/255.0
                    green:217/255.0
                    blue:54/255.0
                    alpha:1];
    [self markButton:_BlindSearch withColor:green];
    
    
    //[_BlindSearch setShadow:shadow];
    [_BlindSearch setShowsBorderOnlyWhileMouseInside:YES];
    lock=[[NSLock alloc]init];
    
}

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification {
        pipe = [NSPipe pipe];
        pipeReadHandle = [pipe fileHandleForReading];
    
        dup2([[pipe fileHandleForWriting] fileDescriptor], fileno(stderr));
        
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(nslog:) name: NSFileHandleReadCompletionNotification object: pipeReadHandle] ;
        [pipeReadHandle readInBackgroundAndNotify];
    
}

@end
