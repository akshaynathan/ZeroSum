//
//  ZSMyScene.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSGameScene.h"

@class ZSTileNode;

@implementation ZSGameScene {
    ZSBoardNode *board;
    ZSChain *chain;
    ZSLevelManager *manager;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        board = [ZSBoardNode node];
        board.size = CGSizeMake(320, 480);
        board.position = CGPointMake(160, 284);
        
        [board initTiles:5];
        [self addChild:board];
        
        manager = [[ZSLevelManager alloc] init];
        [manager start];
        
        chain = [[ZSChain alloc] init];
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInNode:self];
    
    NSArray *nodes = [self nodesAtPoint:pos];
    
    for (SKNode *n in nodes) {
        if ([n isKindOfClass:[ZSTileNode class]]) {
            [chain addTile:(ZSTileNode*) n];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInNode:self];
    
    NSArray *nodes = [self nodesAtPoint:pos];
    
    for (SKNode *n in nodes) {
        if ([n isKindOfClass:[ZSTileNode class]]) {
            [chain addTile:(ZSTileNode*) n];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (chain.runningSum == 0) {
        [chain removeChain];
    } else {
        [chain clearChain];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
