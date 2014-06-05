//
//  ZSBoardNode.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZSTileNode.h"

@class ZSTileNode;

@interface ZSBoardNode : SKSpriteNode

/**
 *  Builds a board node.
 *
 *  @return The constructed ZSBoardNode.
 */
+(ZSBoardNode*)node;

/**
 *  Returns the tile at the given position or nil if no such tile exists.
 *
 *  @param col Column position.
 *  @param row Row position.
 *
 *  @return The ZSTileNode at the position.
 */
-(ZSTileNode*)tileAtColumn:(int)col andRow:(int)row;

/**
 *  Adds a tile to the given position. Returns the added tile, or nil
 *  if the tile cannot be added (it is not contiguous with existing tiles
 *  or off the board. Shifts higher tiles up.
 *
 *  @param tile The ZSTileNode to be added.
 *  @param col  Column position.
 *  @param row  Row position.
 *
 *  @return The added ZSTileNode or nil if it could not be added.
 */
-(ZSTileNode*)addTile:(ZSTileNode*)tile atColumn:(int)col andRow:(int)row;

/**
 *  Removes a tile at the given position. Returns removed tile, or nil
 *  if the tile cannot be removed. Shifts higher tiles down.
 *
 *  @param col Column position.
 *  @param row Row position.
 *
 *  @return The removed ZSTileNode or nil if the tile cannot be removed.
 */
-(ZSTileNode*)removeTileAtColumn:(int)col andRow:(int)row;




@end
