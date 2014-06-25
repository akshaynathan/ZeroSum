//
//  ZSScore.h
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ZSScore : SKNode

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
 *  Updates the score by incrementing by the update val.
 *
 *  @param update The amount to increment by.
 *
 *  @return Returns the new score.
 */
- (int)updateScore:(int)amount;

@end
