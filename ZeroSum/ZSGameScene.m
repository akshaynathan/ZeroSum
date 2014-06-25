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
#import "ZSTileNode.h"
#import "ZSNewTileNode.h"
#import "ZSScore.h"

@implementation ZSGameScene {
  ZSGod *god;
}

/**
 * Creates the game scene (board and level manager)
 */
- (id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    ZSBoardNode *gameboard = [self createBoard];
    god = [[ZSGod alloc] initWithBoard:gameboard];
    ZSScore *score = god.score;
    score.position =
        CGPointMake(SCREEN_WIDTH / 2,
                    BOTTOM_BUFFER + TILE_SIZE * BOARD_ROWS + SCORE_BUFFER);
    [self addChild:score];
    [god start];
  }
  return self;
}

/**
 * Creates a game board. Dimension constants are defined in ZSUtility
 */
- (ZSBoardNode *)createBoard {
  ZSBoardNode *b = [ZSBoardNode node];
  b.position =
      CGPointMake(SCREEN_WIDTH / 2, TILE_SIZE * BOARD_ROWS / 2 + BOTTOM_BUFFER);
  [self addChild:b];
  return b;
}

/**
 * Manages new touch events
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *t = [touches anyObject];
  NSArray *nodes = [self nodesAtPoint:[t locationInNode:self]];
  for (SKNode *n in nodes) {
    if ([n isKindOfClass:[ZSTileNode class]]) {
      [god addTileToChain:(ZSTileNode *)n];
      break;
    }
    if ([n isKindOfClass:[ZSNewTileNode class]]) {
      [god transitionNewTile:(ZSNewTileNode *)n];
      break;
    }
  }
}

/**
 * Manages touch move events
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *t = [touches anyObject];
  NSArray *nodes = [self nodesAtPoint:[t locationInNode:self]];
  for (SKNode *n in nodes) {
    if ([n isKindOfClass:[ZSTileNode class]]) {
      if ([(ZSTileNode *)n isCentered:[t locationInNode:n]]) {
        [god addTileToChain:(ZSTileNode *)n];
        break;
      }
    }
  }
}

/**
 * Manages touch end events
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [god clearChain];
}

- (void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

@end
