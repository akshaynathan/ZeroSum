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
    [self addChild:rootNode];
    [self restartScene];
  }
  return self;
}

/**
 *  Generates the scene on start/restart.
 */
- (void)restartScene {
  // If we are actually restarting remove all children
  [self removeAllChildren];
  [rootNode removeAllChildren];
  rootNode.filter = NULL;
  [rootNode setShouldEnableEffects:NO];
  [self addChild:rootNode];

  ZSBoardNode *gameboard = [self createBoard];
  god = [[ZSGod alloc] initWithBoard:gameboard inScene:self];
  ZSScore *score = god.score;
  score.position = CGPointMake(
      SCREEN_WIDTH / 2, BOTTOM_BUFFER + TILE_SIZE * BOARD_ROWS + SCORE_BUFFER);
  [rootNode addChild:score];
  [god start];
}

/**
 *  Runs game over actions.
 */
- (void)gameOver {
  // Blur the game scene.
  [rootNode setShouldEnableEffects:YES];
  [rootNode setShouldRasterize:YES];
  [rootNode setFilter:[CIFilter filterWithName:@"CIGaussianBlur"
                                 keysAndValues:@"inputRadius", @5.0f, nil]];

  // Display the game over menu
  [self addChild:[self gameOverMenu]];
}

/**
 *  Generates the game over menu.
 *
 *  @return The game over menu in a node.
 */
- (SKNode *)gameOverMenu {
  SKNode *gameOverRoot = [SKNode node];
  gameOverRoot.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);

  // Game Over text
  SKLabelNode *go = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
  go.text = @"GAME OVER";
  go.fontSize = 25;
  go.fontColor = [UIColor blackColor];
  [gameOverRoot addChild:go];

  // Restart button
  SKLabelNode *restart = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
  restart.text = @"restart";
  restart.fontSize = 20;
  restart.fontColor = [UIColor blackColor];
  restart.position = CGPointMake(0, -40);
  restart.name = @"restartButton";
  [gameOverRoot addChild:restart];

  return gameOverRoot;
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
    if ([n.name isEqualToString:@"restartButton"]) {
      [self restartScene];
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
