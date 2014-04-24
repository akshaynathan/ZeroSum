//
//  ZSNewTileNode.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZSBoardNode.h"
#import "ZSLevelManager.h"

@interface ZSNewTileNode : SKNode

typedef enum {
    moving,
    waiting,
    held,
    standing
} TileState;

@property (readwrite, atomic) int column, value;

+(ZSNewTileNode*)nodeWithValue:(int)value
                      inColumn:(int)column
                    waitingFor:(float)duration
                    forManager:(ZSLevelManager*)z;

// Move to a new position
-(void)moveTo:(int)pos;

// Snap to a column
-(void)snapTo:(int)column;

// Enter the column
-(void)realize;


@end
