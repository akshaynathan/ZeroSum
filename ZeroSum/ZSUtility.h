//
//  ZSUtility.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/18/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <Foundation/Foundation.h>

// Basic dimensions
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 640

// Game specific dimensions
#define TILE_SIZE 40
#define BOARD_COLUMNS 8
#define BOARD_ROWS 12
#define BOTTOM_BUFFER TILE_SIZE + 4
#define SQUARE_SIZE (TILE_SIZE - 4)
#define SCORE_BUFFER 10

// Game Dynamics
#define STARTING_TILES 5
#define GRACE_PERIOD 5.0

// Animation
#define UPWARD_SHIFT_DURATION 0.3
#define DOWNWARD_SHIFT_DURATION 0.5
#define NEW_TILE_FADE_DURATION 0.2

// Debugging and logging
#define DEBUG 1
#ifdef DEBUG
#define DEBUG_LOG( s, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DEBUG_LOG( s, ... )
#endif

@interface ZSUtility : NSObject

+(int)randomValue;

@end
