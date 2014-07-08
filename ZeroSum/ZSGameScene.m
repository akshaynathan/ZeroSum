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
  SKEffectNode *rootNode;
}

/**
 * Creates the game scene (board and level manager)
 */
- (id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    rootNode = [SKEffectNode node];

    ZSBoardNode *gameboard = [self createBoard];
    god = [[ZSGod alloc] initWithBoard:gameboard inScene:self];
    ZSScore *score = god.score;
    score.position =
        CGPointMake(SCREEN_WIDTH / 2,
                    BOTTOM_BUFFER + TILE_SIZE * BOARD_ROWS + SCORE_BUFFER);
    [rootNode addChild:score];
    [god start];
    [self addChild:rootNode];
  }
  return self;
}

- (void)gameOver {
  // Blur the game scene.
  [rootNode setShouldEnableEffects:YES];
  [rootNode setShouldRasterize:YES];
  [rootNode setFilter:[CIFilter filterWithName:@"CIGaussianBlur"
                                 keysAndValues:@"inputRadius", @5.0f, nil]];

  // Display the game over menu
}

/**
 * Creates a game board. Dimension constants are defined in ZSUtility
 */
- (ZSBoardNode *)createBoard {
  ZSBoardNode *b = [ZSBoardNode node];
  b.position =
      CGPointMake(SCREEN_WIDTH / 2, TILE_SIZE * BOARD_ROWS / 2 + BOTTOM_BUFFER);
  [rootNode addChild:b];
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
  UITouch *t = [touches anyObject];
  NSArray *nodes = [self nodesAtPoint:[t locationInNode:self]];
  for (SKNode *n in nodes) {
    if ([n isKindOfClass:[ZSTileNode class]]) {
      [god clearChain];
      break;
    }
  }
}

- (void)update:(CFTimeInterval)currentTime {
  /* Called before each frame is rendered */
}

@end
