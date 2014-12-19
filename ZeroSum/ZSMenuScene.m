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
    [self addTitle];
    [self addOptions];
  }
  return self;
}

/**
 *  Add the game title at the top.
 */
- (void)addTitle {
  SKNode *titleNode = [[SKNode alloc] init];

  // We are going to programmatically create the title graphic to
  // keep with the theme that the whole game is in spritekit. This involves
  // some rather hacky code, esp for "kerning".

  // Create the attributes so we can find out the size of each label
  double smallFontSize = TITLE_FONT_SIZE - TITLE_FONT_SIZE / 4;
  NSDictionary *bigAttr = @{
    NSFontAttributeName :
        [UIFont fontWithName:TITLE_FONT size:TITLE_FONT_SIZE]
  };
  NSDictionary *smallAttr = @{
    NSFontAttributeName : [UIFont fontWithName:TITLE_FONT size:smallFontSize]
  };

  // Track where we are in the total string
  CGFloat position = 0;

  SKLabelNode *ZNode =
      [self makeTitleLabelWithText:@"Z"
                         fontColor:UIColorFromRGB(TITLE_ZERO_COLOR)
                          fontSize:TITLE_FONT_SIZE
                        atPosition:CGPointMake(position, 0)];
  position += [ZNode.text sizeWithAttributes:bigAttr].width;
  SKLabelNode *eroNode =
      [self makeTitleLabelWithText:@"ER\u2205"
                         fontColor:UIColorFromRGB(TITLE_ZERO_COLOR)
                          fontSize:smallFontSize
                        atPosition:CGPointMake(position, 0)];
  position += [eroNode.text sizeWithAttributes:smallAttr].width;
  SKLabelNode *SNode =
      [self makeTitleLabelWithText:@"S"
                         fontColor:UIColorFromRGB(TITLE_ZERO_COLOR)
                          fontSize:TITLE_FONT_SIZE
                        atPosition:CGPointMake(position, 0)];
  position += [SNode.text sizeWithAttributes:bigAttr].width;
  SKLabelNode *umNode =
      [self makeTitleLabelWithText:@"UM"
                         fontColor:UIColorFromRGB(TITLE_ZERO_COLOR)
                          fontSize:smallFontSize
                        atPosition:CGPointMake(position, 0)];
  position += [umNode.text sizeWithAttributes:smallAttr].width;

  [titleNode addChild:ZNode];
  [titleNode addChild:eroNode];
  [titleNode addChild:SNode];
  [titleNode addChild:umNode];
  // Center titleNode
  titleNode.position =
      CGPointMake((SCREEN_WIDTH - position) / 2, SCREEN_HEIGHT - TITLE_BUFFER);

  [self addChild:titleNode];
}

/**
 *  Helper method to create labels that make up title.
 *
 *  @return Returns an SKLabelNode with the attributes set.
 */
- (SKLabelNode *)makeTitleLabelWithText:(NSString *)text
                              fontColor:(UIColor *)color
                               fontSize:(CGFloat)fontSize
                             atPosition:(CGPoint)position {
  SKLabelNode *node = [SKLabelNode labelNodeWithFontNamed:TITLE_FONT];
  node.text = text;
  node.fontColor = UIColorFromRGB(TITLE_SUM_COLOR);
  node.fontSize = fontSize;
  node.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
  node.position = position;
  return node;
}

/**
 *  Add all menu items.
 */
- (void)addOptions {
  [self addButton:@"playButton" withText:@"play" atPosition:0];
  [self addButton:@"settingsButton" withText:@"scores" atPosition:1];
  [self addButton:@"scoresButton" withText:@"settings" atPosition:2];
  [self addButton:@"instructionsButton" withText:@"instructions" atPosition:3];
}

- (void)addButton:(NSString *)buttonName
         withText:(NSString *)buttonText
       atPosition:(int)position {
  SKLabelNode *button = [SKLabelNode labelNodeWithFontNamed:MENU_FONT];
  button.text = buttonText;
  button.fontSize = MENU_BUTTON_SIZE;
  button.fontColor = [UIColor blackColor];
  button.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
  button.name = buttonName;
  button.position =
      CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - BUTTON_TOP_BUFFER -
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
