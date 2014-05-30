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

#define BOTTOM_BUFFER 44

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
