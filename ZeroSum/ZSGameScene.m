//
//  ZSMyScene.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSGameScene.h"
#import "ZSBoardNode.h"
#import "ZSUtility.h"
#import "ZSGod.h"

@class ZSTileNode;

@implementation ZSGameScene {
    ZSBoardNode *board;         // Game board
    ZSGod *god;
}

/**
 * Creates the game scene (board and level manager)
 */
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        ZSBoardNode *gameboard = [self createBoard];
        ZSGod *g = [[ZSGod alloc] initWithBoard:gameboard];
        [g start];
    }
    return self;
}

/**
 * Creates a game board. Dimension constants are defined in ZSUtility
 */
-(ZSBoardNode*)createBoard {
    ZSBoardNode *b = [ZSBoardNode node];
    b.position = CGPointMake(SCREEN_WIDTH/2,
                                 TILE_SIZE * BOARD_ROWS/2 + BOTTOM_BUFFER);
    [self addChild:b];
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
