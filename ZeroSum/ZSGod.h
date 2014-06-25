//
//  ZSGod.h
//  ZeroSum
//
//  Created by Akshay Nathan on 6/16/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZSBoardNode;
@class ZSTileNode;
@class ZSNewTileNode;
@class ZSScore;
@class ZSLevelManager;

@interface ZSGod : NSObject

@property(atomic, readonly) ZSBoardNode *gameboard;
@property(atomic, readonly) ZSScore *score;
@property(atomic, readonly) ZSLevelManager *levelMan;

/**
 *  Create a God object with a given board.
 *
 *  @param board The game board.
 *
 *  @return The constructed ZSGod.
 */
- (ZSGod *)initWithBoard:(ZSBoardNode *)board;

/**
 *  Start the game.
 */
- (void)start;

/**
 *  Adds the tile to the chain if its a valid next tile.
 *  Returns the tile or nil if it cant be added.
 */
- (ZSTileNode *)addTileToChain:(ZSTileNode *)tile;

/**
 *  Clears the chain, updates the score if the sum is 0.
 *  Returns the sum of the chain.
 */
- (int)clearChain;

/**
 *  Makes a new tile node into a real tile.
 *  Also adds tiles out of the queue if possible.
 *
 *  @param t The new tile to emerge.
 *
 *  @return The tile that the new tile becomes.
 */
- (ZSTileNode *)transitionNewTile:(ZSNewTileNode *)t;

@end
