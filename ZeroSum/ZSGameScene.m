//
//  ZSMyScene.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSGameScene.h"
#import "ZSNewTileNode.h"

@class ZSTileNode;

@implementation ZSGameScene {
    ZSBoardNode *board;         // Game board
    ZSChain *chain;             // Current chain of tiles
}

/**
 * Creates the game scene (board and level manager)
 */
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        // Create the board
        //[self addChild:[self createBoard]];
        ZSNewTileNode* k = [ZSNewTileNode nodeWithValue:4];
        k.position = CGPointMake(50, 50);
        [self addChild:k];
    }
    return self;
}

/**
 * Creates a game board. Dimension constants are defined in ZSUtility
 */
-(ZSBoardNode*)createBoard {
    ZSBoardNode *b = [ZSBoardNode node];
    b.size = CGSizeMake(SCREEN_WIDTH,
                            TILE_SIZE * BOARD_ROWS);
    b.position = CGPointMake(SCREEN_WIDTH/2,
                                 TILE_SIZE * BOARD_ROWS/2
                                 + BOTTOM_BUFFER); // Save space at bottom
    return b;
}

/**
 * Manages new touch events
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

/**
 * Manages touch move events
 */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

}

/**
 * Manages touch end events
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
