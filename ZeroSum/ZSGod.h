//
//  ZSGod.h
//  ZeroSum
//
//  Created by Akshay Nathan on 6/16/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZSBoardNode;

@interface ZSGod : NSObject

/**
 *  Create a God object with a given board.
 *
 *  @param board The game board.
 *
 *  @return The constructed ZSGod.
 */
-(ZSGod*)initWithBoard:(ZSBoardNode*)board;

/**
 *  Start the game.
 */
-(void)start;

@end
