//
//  ZSScore.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSScore.h"
#import "ZSUtility.h"

@implementation ZSScore {
  SKLabelNode *scoreNode;
  NSTimer *scoreUpdateTimer;
  int currentScoreText;
}

- (id)init {
  if (self = [super init]) {
    _score = 0;
    currentScoreText = 0;

    scoreNode = [SKLabelNode node];
    scoreNode.text = @"0";
    scoreNode.fontSize = 24;
    scoreNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    scoreNode.fontName = @"TimesNewRoman";
    scoreNode.fontColor = [UIColor blackColor];
    [self addChild:scoreNode];
  }

  return self;
}

+ (int)calculateScoreForLevel:(int)level andChainLength:(int)length {
  return level + (length * 10);
}

- (int)updateScore:(int)amount {
  _score += amount;
  // scoreNode.text = [NSString stringWithFormat:@"%d", _score];
  scoreUpdateTimer =
      [NSTimer scheduledTimerWithTimeInterval:SCORE_UPDATE / amount
                                       target:self
                                     selector:@selector(updateScoreText)
                                     userInfo:nil
                                      repeats:YES];
  return _score;
}

- (void)updateScoreText {
  if (currentScoreText == _score) {
    [scoreUpdateTimer invalidate];
    return;
  }
  currentScoreText = currentScoreText + 1;
  scoreNode.text = [NSString stringWithFormat:@"%d", currentScoreText];
}

@end
