//
//  ZSLevelManager.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ZSBoardNode.h"
#import "ZSNewTileNode.h"

@interface ZSLevelManager : SKNode

// Initializes the manager for a given board
-(ZSLevelManager*)initWithBoard:(ZSBoardNode*)n;

// Start the levels
-(void)start;

// Changes the given newtile to an actual tile (deletes the newtile)
-(void)createReal:(ZSNewTileNode*)tile;

@end
