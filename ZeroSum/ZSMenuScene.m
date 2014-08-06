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
  [self addButton:@"playButton"
             withText:@"PLAY"
           atPosition:0
      withRibbonColor:UIColorFromRGB(RIBBON_COLOR_1)];
  [self addButton:@"settingsButton"
             withText:@"SETTINGS"
           atPosition:1
      withRibbonColor:UIColorFromRGB(RIBBON_COLOR_2)];
  [self addButton:@"scoresButton"
             withText:@"LEADERBOARD"
           atPosition:2
      withRibbonColor:UIColorFromRGB(RIBBON_COLOR_3)];
}

- (void)addButton:(NSString *)buttonName
           withText:(NSString *)buttonText
         atPosition:(int)position
    withRibbonColor:(UIColor *)ribbonColor {
  // Draw the ribbon
  CGFloat y_pos =
      SCREEN_HEIGHT - BUTTON_TOP_BUFFER - MENU_BUTTON_SPACING * position;
  SKShapeNode *ribbon = [SKShapeNode node];
  ribbon.fillColor = ribbonColor;
  CGMutablePathRef k = CGPathCreateMutable();
  CGPathAddRect(k, NULL, CGRectMake(0, y_pos + RIBBON_BUFFER, SCREEN_WIDTH,
                                    RIBBON_HEIGHT));
  ribbon.path = k;
  CGPathRelease(k);
  [self addChild:ribbon];

  SKLabelNode *button = [SKLabelNode labelNodeWithFontNamed:MENU_FONT];
  button.text = buttonText;
  button.fontSize = MENU_BUTTON_SIZE;
  button.fontColor = UIColorFromRGB(PLAY_BUTTON_COLOR);
  button.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
  button.name = buttonName;
  button.position =
      CGPointMake(BUTTON_SIDE_BUFFER, SCREEN_HEIGHT - BUTTON_TOP_BUFFER -
                                          MENU_BUTTON_SPACING * position);

  [self addChild:button];
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
