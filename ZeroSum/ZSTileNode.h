//
//  ZSTileNode.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZSBoardNode.h"

@interface ZSTileNode : SKSpriteNode

@property (atomic, readwrite) int row, column;
@property (atomic, readonly) int value;

+(ZSTileNode*)nodeWithValue:(int)value inColumn:(int)col andRow:(int)row;

// Shifts the node down, runs move action with duration
-(void)shift:(int)num withDuration:(float)duration;

// Returns true if this tile is neighbors with the other tile
-(BOOL)isNeighborsWith: (ZSTileNode*)other;

// Returns whether this tile is connected (forward) already
-(BOOL)isConnected;

// connects to the tile (by adding a connector)
-(void)connectTo: (ZSTileNode*)next;

// Disconnects (removes connector) from forward tile
-(void)disconnect;

// Helper method to remove self from the board
-(void)removeSelf;

@end
