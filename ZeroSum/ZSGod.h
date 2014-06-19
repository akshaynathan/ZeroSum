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

@interface ZSGod : NSObject

/**
 *  Create a God object with a given board.
 *
 *  @param board The game board.
 *
 *  @return The constructed ZSGod.
 */
-(ZSGod*)initWithBoard:(ZSBoardNode*)board;

/**
 *  Start the game.
 */
-(void)start;

/**
 *  Adds the tile to the chain if its a valid next tile.
 *  Returns the tile or nil if it cant be added.
 */
-(ZSTileNode*)addTileToChain:(ZSTileNode*)tile;

/**
 *  Clears the chain, updates the score if the sum is 0.
 *  Returns the sum of the chain.
 */
-(int)clearChain;

@end
