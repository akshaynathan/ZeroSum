//
//  ZSScore.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSScore.h"

@implementation ZSScore {
  SKLabelNode *scoreNode;
}

- (id)init {
  if (self = [super init]) {
    _score = 0;

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
  scoreNode.text = [NSString stringWithFormat:@"%d", _score];
  return _score;
}

@end
