//
//  ZSTileAdder.h
//  ZeroSum
//
//  Created by Akshay Nathan on 6/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZSGod;

@interface ZSTileAdder : NSObject

/**
 *  These properties can be modified atomically while the
 *  tileadder is running.
 */
@property (atomic, readwrite) double addDuration;
@property (atomic, readwrite) double emergeDuration;

/**
 *  Init the tile adder with the given board.
 *
 *  @param board The game board.
 *
 *  @return The constructed tileadder.
 */
-(ZSTileAdder*)initWithGod:(ZSGod*)god;

/**
 *  Start the tileadder after the given waitTime.
 *
 *  @param waitTime The time to wait before adding the first tile.
 */
-(void)start:(double)waitTime;


/**
 *  If the tile backlog has items, this will add the first new tile
 *  to the newly opened position.
 *
 *  @param column The column to add the new tile to.
 */
-(void)clearQueue:(int)column;

@end
