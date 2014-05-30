//
//  ZSChain.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSChain.h"

@implementation ZSChain {
    NSMutableArray *chain;
}

-(ZSChain*)init {
    self = [super init];
    
    chain = [[NSMutableArray alloc] init];
    _runningSum = -1;
    
    return self;
}

-(void)addTile:(ZSTileNode*)tile {
    if(_runningSum == -1) {
        _runningSum = 0; // Chain with tiles
    }
    
    [chain addObject:tile];
    _runningSum += tile.value;
}

-(ZSTileNode*)lastTile {
    return [chain lastObject];
}

-(ZSTileNode*)popTile {
    if(_runningSum == -1)
        return nil; // Empty chain
    
    ZSTileNode* ret = [chain lastObject];
    [chain removeLastObject];
    _runningSum += -1 * ret.value;
    
    if([chain count] == 0) {
        _runningSum = -1;
    }
    return ret;
}

@end
