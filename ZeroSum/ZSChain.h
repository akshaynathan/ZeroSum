//
//  ZSChain.h
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSTileNode.h"
#import "ZSUtility.h"

@interface ZSChain : NSObject

// A stack to hold the running chain of tiles
@property (atomic, readwrite) NSMutableArray* chain;

// The current sum of the chain
@property (atomic, readonly) int runningSum;

// Create a new chain
-(ZSChain*)init;

// Add a new tile to the chain
-(void)addTile:(ZSTileNode*)tile;

-(void)clearChain;

-(int)removeChain;

@end
