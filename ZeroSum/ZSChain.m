//
//  ZSChain.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSChain.h"

@implementation ZSChain

-(ZSChain*)init {
    self = [super init];
    
    _chain = [[NSMutableArray alloc] init];
    _runningSum = 0;
    
    return self;
}

-(void)addTile:(ZSTileNode*)tile {
    ZSTileNode* last = [_chain lastObject];
    
    if (last == nil // This is the first tile
        || (last != tile // Make sure it is a new tile
        && ![tile isConnected] // No cycles
        && [tile isNeighborsWith:last]) // Only vertical and horizontal neighbors
        ) {
        
        [_chain addObject:tile];
        _runningSum = _runningSum + [tile value];
        
        [ZSUtility debug:[NSString stringWithFormat:@"Chain sum: %d", _runningSum]
                    from:[self class]];
        [last connectTo: tile];
    }
}

-(void) clearChain {
    for(ZSTileNode* t in _chain) {
        [t disconnect];
    }
    
    _chain = [[NSMutableArray alloc] init];
    _runningSum = 0;
}

-(int) removeChain {
    for (ZSTileNode *h in _chain)
        [h removeSelf];
    _chain = [[NSMutableArray alloc] init];
    return 500;
}
@end
