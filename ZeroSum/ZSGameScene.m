//
//  ZSMyScene.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSGameScene.h"

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
        [self addChild:[self createBoard]];
        
        
        // Initialize an empty chain instance
        chain = [[ZSChain alloc] init];
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
    
    // Add the starting tiles
    //[b initTiles:STARTING_TILES];
    return b;
}

/**
 * Manages new touch events
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:pos];
    
    for (SKNode *n in nodes) {
        // Tile Node
        if ([n.name isEqualToString:@"tile"]) {
            // Add the node to the chain
            [chain addTile:(ZSTileNode*) n];
        }
    }
}

/**
 * Manages touch move events
 */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:pos];
    
    for (SKNode *n in nodes) {
        // Tile Node
        if ([n.name isEqualToString:@"tile"]) {
            // Add the node to the chain
            [chain addTile:(ZSTileNode*) n];
        }
    }
}

/**
 * Manages touch end events
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInNode:self];
    NSArray *nodes = [self nodesAtPoint:pos];
    
    for (SKNode *n in nodes) {
        // Tile Node
        if ([n.name isEqualToString:@"tile"]) {
            // Add the node to the chain
            [chain addTile:(ZSTileNode*) n];
            
            // Remove the chain if it sums to 0
            //if (chain.runningSum == 0)
                //[chain removeChain];
            //else
               // [chain clearChain];
        }
        
        // New Tile
        if ([n.name isEqualToString:@"ntile"]) {
            // Push this tile onto the board
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
