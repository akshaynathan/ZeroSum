//
//  ZSScore.h
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

// The color of the score text.
#define SCORE_COLOR 0x000000

// Font of the score text
#define SCORE_FONT_NAME @"Menlo-Regular"
#define SCORE_FONT_SIZE 26

// Multipliers for score calculation
#define LEVEL_MULTIPLIER 3
#define LENGTH_MULTIPLIER 10

// Time it takes for score to fully update
#define UPDATE_TIME 0.5

// Scaling of score settings
#define SCALE_FACTOR 1.2
#define SCALE_TIME 0.5

@interface ZSScoreNode : SKNode

@property(atomic, readonly) int score;

/**
 *  Calculates the score to add.
 *
 *  @param level  The level we are on.
 *  @param length The length of the chain thats been cleared.
 *
 *  @return The amount to add to the score.
 */
+ (int)calculateScoreForLevel:(int)level andChainLength:(int)length;

/**
 *  Increases the score by amount.
 *
 *  @param update The amount to increment by.
 *
 *  @return Returns the new score.
 */
- (int)addScore:(int)amount;

/**
 *  Called in the update method of the gamescene. This
 *  will update the actual score text so we can have the incremental
 *  counter animation.
 *
 *  @param now The current time.
 */
- (void)updateScore:(CFTimeInterval)now;

@end
