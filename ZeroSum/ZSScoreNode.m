//
//  ZSScore.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSScoreNode.h"
#import "ZSUtility.h"

@implementation ZSScoreNode {
  SKLabelNode *scoreNode;
  double startingScore, finalScore, currentScore;
  CFTimeInterval endTime;
}

- (id)init {
  if (self = [super init]) {
    _score = 0;
    finalScore = 0;
    startingScore = 0;
    currentScore = 0;
    endTime = 0;

    [self draw];
  }

  return self;
}

+ (int)calculateScoreForLevel:(int)level andChainLength:(int)length {
  return LEVEL_MULTIPLIER * level + LENGTH_MULTIPLIER * length;
}

- (int)addScore:(int)amount {
  [self animateScore];

  // Set current and final scores for the update method.
  startingScore = _score;
  _score += amount;
  finalScore = _score;
  endTime += UPDATE_TIME;
  return _score;
}

- (void)updateScore:(CFTimeInterval)now {
  if (currentScore == finalScore) {
    endTime = now;
    return;
  }
  if (now >= endTime) {
    currentScore = finalScore;
  } else {
    // Calculate how far we've gone and update the score based on
    // how much time is left.
    double progress = 1 - ((endTime - now) / UPDATE_TIME);
    currentScore =
        ceil(startingScore + (progress * (finalScore - startingScore)));
  }
  scoreNode.text = [NSString stringWithFormat:@"%d", (int)currentScore];
}

// This animation runs on every score update
- (void)animateScore {
  SKAction *sizeUp = [SKAction scaleBy:SCALE_FACTOR duration:SCALE_TIME / 2];
  sizeUp.timingMode = SKActionTimingEaseOut;
  SKAction *sizeDown =
      [SKAction scaleBy:1 / SCALE_FACTOR duration:SCALE_TIME / 2];
  sizeDown.timingMode = SKActionTimingEaseOut;
  [scoreNode runAction:[SKAction sequence:@[ sizeUp, sizeDown ]]];
}

/**
 *  Draws the initial score text.
 */
- (void)draw {
  scoreNode = [SKLabelNode node];
  scoreNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;

  scoreNode.fontSize = SCORE_FONT_SIZE;
  scoreNode.fontName = SCORE_FONT_NAME;
  scoreNode.fontColor = UIColorFromRGB(SCORE_COLOR);

  scoreNode.text = @"0";
  [self addChild:scoreNode];
}

@end
