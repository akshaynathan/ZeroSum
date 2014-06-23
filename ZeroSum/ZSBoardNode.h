//
//  ZSBoardNode.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class ZSTileNode;
@class ZSNewTileNode;

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

/**
 *  Adds a NewTile in the column. If there is already a NewTile here,
 *  the method will return nil.
 *
 *  @param col The column to add the tile in.
 *
 *  @return The ZSNewTileNode if it is successfully added.
 */
-(ZSNewTileNode*)addNewTile:(ZSNewTileNode*)tile atColumn:(int)col;

/**
 *  Gets the ZSNewTileNode in the column. If there is nothing there,
 *  the method will return nil.
 *
 *  @param col The column to look in.
 *
 *  @return The ZSNewTileNode in the column.
 */
-(ZSNewTileNode*)newTileAtColumn:(int)col;

/**
 *  Removes the ZSNewTileNode from the column.
 *
 *  @param col The column.
 *
 *  @return The past NewTile or nil if there was nothing there.
 */
-(ZSNewTileNode*)removeNewTileAtColumn:(int)col;

/**
 *  Returns a random empty column.
 *
 *  @return The index of an empty column or -1 if no such column is available.
 */
-(int)getFreeColumn;

@end
