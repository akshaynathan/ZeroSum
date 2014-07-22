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
#define SQUARE_SIZE (TILE_SIZE - 6)
#define SCORE_BUFFER 12
#define CENTER_BUFFER 10
#define TILE_EDGE 4

// Game Dynamics
#define STARTING_TILES 6
#define GRACE_PERIOD 0
#define SUGGEST_BUFFER 9

// Animation
#define UPWARD_SHIFT_DURATION 0.3
#define DOWNWARD_SHIFT_DURATION 0.5
#define NEW_TILE_FADE_DURATION 0.2
#define SCORE_UPDATE 0.2

// Aesthetics
#define GRID_COLOR 0x000000
#define NEGATIVE_COLOR 0x334D5C
#define POSITIVE_COLOR 0xDF4949
#define CONNECTOR_COLOR 0xEFC94C

// Debugging and logging
#define DEBUG 1
#ifdef DEBUG
#define DEBUG_LOG(s, ...)                                             \
  NSLog(@"<%@:%d> %@",                                                \
        [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
        __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DEBUG_LOG(s, ...)
#endif

// Color from hex string
#define UIColorFromRGB(rgbValue)                                       \
  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                  green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
                   blue:((float)(rgbValue & 0xFF)) / 255.0             \
                  alpha:1.0]

@interface ZSUtility : NSObject

+ (int)randomValue;

@end
