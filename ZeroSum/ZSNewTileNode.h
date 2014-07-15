//
//  ZSNewTile.h
//  ZeroSum
//
//  Created by Akshay Nathan on 6/5/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZSTileNode.h"

@interface ZSNewTileNode : SKNode

@property(atomic, readwrite) int column;
@property(atomic, readonly) int value;
@property(atomic, readonly) BOOL isEmerging;

/**
 *  Returns a ZSNewTileNode with the given value.
 *
 *  @param value The integer value -9 - 9 of the tile.
 *
 *  @return The constructed ZSNewTileNode.
 */
+ (ZSNewTileNode *)nodeWithValue:(int)value;

/**
 *  Returns an actual ZSTileNode (row = 1).
 *
 *  @return The actual on board ZSTileNode.
 */
- (ZSTileNode *)toRealTile;

/**
 *  Start the border animation.
 *
 *  @param duration The time before the new tile emerges.
 */
- (void)startAnimation:(double)duration;
@end
