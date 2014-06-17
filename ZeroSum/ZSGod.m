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

@implementation ZSGod {
    ZSBoardNode* gameboard;
}

-(ZSGod*)initWithBoard:(ZSBoardNode*)board {
    self = [super init];
    gameboard = board;
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

@end
