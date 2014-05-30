//
//  ZSChain.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSTileNode.h"
#import "ZSUtility.h"

@interface ZSChain : NSObject

/**
 *  Current sum of the chain.
 */
@property (atomic, readonly) int runningSum;

/**
 *  Creates and returns a new chain.
 *  Empty chains have sum = -1.
 *
 *  @return The constructed chain.
 */
-(ZSChain*)init;

/**
 *  Adds a tile to the chain.
 *
 *  @param tile The tile to add.
 */
-(void)addTile:(ZSTileNode*)tile;

/**
 *  Stack order removes the last added tile.
 *
 *  @return The removed tile.
 */
-(ZSTileNode*)popTile;

/**
 *  Returns a reference to the last tile.
 *
 *  @return The last tile in the chain.
 */
-(ZSTileNode*)lastTile;

@end
