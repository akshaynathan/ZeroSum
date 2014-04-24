//
//  ZSLevelManager.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSLevelManager.h"

@implementation ZSLevelManager {
    ZSBoardNode* board;
}

-(ZSLevelManager*)initWithBoard:(ZSBoardNode*)n {
    self = [super init];
    board = n;
    return self;
}

-(void)newTileAtColumn:(int)column {
    [board addChild:[ZSNewTileNode nodeWithValue:3 inColumn:4 waitingFor:10.0]];
}

-(void)createReal:(ZSNewTileNode*)tile {
    [board addChild:[ZSNewTileNode nodeWithValue:3 inColumn:4 waitingFor:10.0]];
}

-(void)start {
    
}

@end
