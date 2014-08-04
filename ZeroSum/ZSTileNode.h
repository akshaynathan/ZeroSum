//
//  ZSTileNode.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZSBoardNode.h"

// How deep into the node the connector goes
#define CONNECTOR_BUFFER 8
// Width of connector line
#define CONNECTOR_WIDTH 4

@interface ZSTileNode : SKSpriteNode

@property(atomic, readwrite) int row, column;
@property(atomic, readonly) int value;

/**
 *  Returns a ZSTileNode with the given value.
 *
 *  @param value The integer value -9 - 9 of the tile.
 *
 *  @return The constructed ZSTileNode.
 */
+ (ZSTileNode *)nodeWithValue:(int)value;

/**
 *  Add a connection to the other tile. Does nothing if the other
 *  tile is not a neighbor.
 *
 *  @param next The tile to connect to.
 */
- (void)connectTo:(ZSTileNode *)next;

/**
 *  Disconnect the tile. Does not do anything if the tile is not
 *  connected.
 */
- (void)disconnect;

/**
 *  Check's if this tile neighbors the other tile.
 *  Tiles can be horizontal or vertical neighbors or diagonal neighbors.
 *
 *  @param other The other tile.
 *
 *  @return YES or NO depending on whether the tiles are neighbors.
 */
- (BOOL)isNeighborsWith:(ZSTileNode *)other;

/**
 *  Is the tile already in a chain? Note that this method will
 *  only return YES for all but the last element in the chain,
 *  which is not (forward) connected to any other tile.
 *
 *  @return YES if the tile is connected already, no otherwise.
 */
- (BOOL)isConnected;

/**
 *  Returns YES if the point is in the approximate center of the node.
 *
 *  @param p The point.
 *
 *  @return YES if the point is in the center, no otherwise.
 */
- (BOOL)isCentered:(CGPoint)p;

@end
