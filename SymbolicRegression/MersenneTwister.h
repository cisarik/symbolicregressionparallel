// MTRandom - Objective-C Mersenne Twister
//  Objective-C interface by Adam Preble - adampreble.net - 8/6/12

#import <Foundation/Foundation.h>

@interface MersenneTwister : NSObject <NSCoding, NSCopying>

// Initialize with a given seed value.  This is the designated initializer
- (instancetype)initWithSeed:(uint32_t)seed NS_DESIGNATED_INITIALIZER;

// Seed the generator with the current time.
- (instancetype)init;


// generates a random number on [0,0xffffffff]-interval
@property (NS_NONATOMIC_IOSONLY, readonly) uint32_t randomUInt32;

// generates a random number on [0,1]-real-interval
@property (NS_NONATOMIC_IOSONLY, readonly) double randomDouble;

// generates a random number on [0,1)-real-interval
@property (NS_NONATOMIC_IOSONLY, readonly) double randomDouble0To1Exclusive;

@end


@interface MersenneTwister (Extras)

@property (NS_NONATOMIC_IOSONLY, readonly) BOOL randomBool;

- (uint32_t)randomUInt32From:(uint32_t)start to:(uint32_t)stop;

- (double)randomDoubleFrom:(double)start to:(double)stop;

@end


@interface NSArray (MTRandom)

- (id)mt_randomObjectWithRandom:(MersenneTwister *)r;

@end
