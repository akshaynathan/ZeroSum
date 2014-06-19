//
//  ZSGod.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/16/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSGod.h"
#import "ZSUtility.h"
#import "ZSBoardNode.h"
#import "ZSTileNode.h"
#import "ZSChain.h"

@implementation ZSGod {
    ZSBoardNode* gameboard;
    ZSChain *chain;
}

-(ZSGod*)initWithBoard:(ZSBoardNode*)board {
    self = [super init];
    gameboard = board;
    chain = [[ZSChain alloc] init];
    return self;
}

-(void)start {
    [self initStartingTiles];
}

/**
 *  Add the starting tiles to each row.
 */
-(void)initStartingTiles {
    for(int i = 0; i < BOARD_COLUMNS; i++) {
        for(int k = 0; k < STARTING_TILES; k++) {
            ZSTileNode *t = [ZSTileNode nodeWithValue:[ZSUtility randomValue]];
            [gameboard addTile:t atColumn:i andRow:k];
        }
    }
}

-(ZSTileNode*)addTileToChain:(ZSTileNode*)tile {
    // No repeats
    if(tile == [chain lastTile])
        return nil;
    // No non neighbors
    if(!([tile isNeighborsWith:[chain lastTile]])
       && [chain lastTile] != nil)
        return nil;
    // No cycles
    if([tile isConnected])
        return nil;
    [[chain lastTile] connectTo:tile];
    [chain addTile:tile];
    return tile;
}

-(int)clearChain {
    int sum = [chain runningSum];
    if(sum == 0) {
        while([chain lastTile] != nil) {
            ZSTileNode *t = [chain popTile];
            [gameboard removeTileAtColumn:t.column andRow:t.row];
        }
    } else {
        while([chain lastTile] != nil) {
            ZSTileNode *t = [chain popTile];
            [t disconnect];
        }
    }
    return sum;
}

@end
