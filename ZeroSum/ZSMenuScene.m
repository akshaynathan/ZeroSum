//
//  ZSMenuScene.m
//  ZeroSum
//
//  Created by Akshay Nathan on 8/5/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSMenuScene.h"
#import "ZSGameScene.h"
#import "ZSUtility.h"

@implementation ZSMenuScene

/**
 * Creates the game scene (board and level manager)
 */
- (id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
    [self addOptions];
  }
  return self;
}

/**
 *  Add all menu items.
 */
- (void)addOptions {
  SKLabelNode *playGame = [SKLabelNode labelNodeWithFontNamed:MENU_FONT];
  playGame.text = @"PLAY";
  playGame.fontSize = 24;
  playGame.fontColor = UIColorFromRGB(PLAY_BUTTON_COLOR);
  playGame.horizontalAlignmentMode = NSTextAlignmentLeft;
  playGame.name = @"playButton";
  playGame.position =
      CGPointMake(BUTTON_SIDE_BUFFER, SCREEN_HEIGHT - BUTTON_TOP_BUFFER);
  [self addChild:playGame];
}

/**
 * Manages new touch events
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *t = [touches anyObject];
  NSArray *nodes = [self nodesAtPoint:[t locationInNode:self]];
  for (SKNode *n in nodes) {
    if ([n.name isEqualToString:@"playButton"]) {
      // Switch to the game scene.
      SKScene *gameScene = [ZSGameScene sceneWithSize:self.view.bounds.size];
      gameScene.scaleMode = SKSceneScaleModeAspectFill;
      gameScene.backgroundColor = [UIColor whiteColor];

      [self.view presentScene:gameScene
                   transition:[SKTransition
                                  revealWithDirection:SKTransitionDirectionDown
                                             duration:TRANSITION_DURATION]];
    }
  }
}

/**
 * Manages touch move events
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

/**
 * Manages touch end events
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)update:(CFTimeInterval)currentTime {
}

@end
