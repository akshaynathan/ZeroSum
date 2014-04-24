//
//  ZSNewTileNode.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/24/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSNewTileNode.h"

@implementation ZSNewTileNode {
    TileState state;
    ZSLevelManager* man;
}

+(ZSNewTileNode*)nodeWithValue:(int)value
                      inColumn:(int)column
                    waitingFor:(float)duration
forManager:(ZSLevelManager *)man{
    return [[ZSNewTileNode alloc] initWithValue:value
                                                     inColumn:column
                                                   waitingFor:duration
            forManager:man];

}

-(ZSNewTileNode*)initWithValue:(int)value
                      inColumn:(int)column
                    waitingFor:(float)duration
                    forManager:(ZSLevelManager*)manager {
    self = [super init];
    
    self->man = manager;
    
    self.value = value;
    self.column = column;
    self.position = CGPointMake(-160 + column * 40 + 1,
                               -240 + -1 * 40 + 2);
    [self draw];
    [self changeState:standing];
    [self runAction:[SKAction performSelector:@selector(realize) onTarget:self]];
    
    return self;
}

-(void)draw {
    SKShapeNode* s = [SKShapeNode node];
    CGPathRef k = CGPathCreateWithRect(CGRectMake(0, 0, 36, 36), NULL);
    CGFloat lengths[] = { 1.0 };
    s.path = CGPathCreateCopyByDashingPath(k, NULL, 0.5f, lengths, 0);
    s.position = CGPointMake(1, 1);
    s.strokeColor = _value < 0 ? [UIColor redColor] : [UIColor cyanColor];
    
    SKLabelNode* l = [SKLabelNode node];
    l.text = [NSString stringWithFormat:@"%d", abs(_value)];
    l.fontSize = 24;
    l.position = CGPointMake(18, 8);
    l.fontColor = [UIColor blackColor];
    [s addChild:l];
    
    [self addChild:s];
}

-(void)moveTo:(int)pos {
    [self changeState:held];
    self.position = CGPointMake(pos, self.position.y);
}

-(void)snapTo:(int)column {
    [self changeState:moving];
    [self runAction:[SKAction moveByX:self.position.x - -160 + column * 40 + 1
                                    y:self.position.y
                             duration:1.0f]
         completion:^{
             @synchronized(self) {
                 if(state == waiting) {
                     [self changeState:standing];
                     [self realize];
                 }
             }
        }
     ];
}

-(void)realize {
    
    @synchronized(self) {
        if(state == moving || state == held) {
            [self changeState:waiting];
            return;
        }
    }
    
    // This should all be level manager stuff
    [man makeReal:self];
}

-(void)changeState:(TileState)newState {
    @synchronized(self) {
        self->state = newState;
    }
}

@end
