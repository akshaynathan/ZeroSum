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

#define STARTING_TILES 5

// Returns a board node
+(ZSBoardNode*)node;

// Override init
-(id)init;

// Adds a tile at a column (shifts other tiles up)
-(void)addTileAtColumn:(ZSTileNode*)n atCol:(int)col andRow:(int)row;

// Removes a tile, and shifts other tiles down
-(void)removeTileAtColumn:(int)col andRow:(int)row;

// Add num tiles to each row
-(void)initTiles:(int)num;


@end
