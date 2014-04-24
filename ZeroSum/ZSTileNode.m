//
//  ZSTileNode.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSTileNode.h"

@implementation ZSTileNode {
    SKShapeNode *connector;
}

-(void)shift:(int)num withDuration:(float)duration {
    _row = _row + num;
    [self runAction:[SKAction moveByX:0 y:num * 40 duration:duration]];
}

+(ZSTileNode*)nodeWithValue:(int)value inColumn:(int)col andRow:(int)row {
    return [[ZSTileNode alloc] initWithValue:value inColumn:col andRow:row];
}

-(ZSTileNode*)initWithValue:(int)value inColumn:(int)col andRow:(int)row {
    self = [[ZSTileNode alloc] init];
    _value = value; _row = row; _column = col;
    self.position = CGPointMake(-160 + _column * 40 + 1,
                                -240 + _row * 40 + 2);
    [self draw];
    return self;
}

-(void)draw {
    SKShapeNode* s = [SKShapeNode node];
    s.path = CGPathCreateWithRect(CGRectMake(0, 0, 36, 36), NULL);
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

-(void)connectTo:(ZSTileNode *)next {
    connector = [SKShapeNode node];
    
    CGMutablePathRef k = CGPathCreateMutable();
    CGPathMoveToPoint(k, NULL, self.position.x + 18, self.position.y + 18);
    CGPathAddLineToPoint(k, NULL, next.position.x + 18, next.position.y + 18);
    connector.path = k;
    connector.strokeColor = [UIColor yellowColor];
    connector.lineWidth = 1;
    
    [self.parent addChild:connector];
}

-(BOOL)isNeighborsWith:(ZSTileNode*)other {
    return (other.column == _column + 1 && other.row == _row)
    || (other.column == _column - 1 && other.row == _row)
    || (other.column == _column && other.row == _row + 1)
    || (other.column == _column && other.row == _row - 1);
}

-(BOOL)isConnected {
    return connector != NULL;
}

-(void)disconnect {
    [connector removeFromParent];
    connector = NULL;
}

-(void)removeSelf {
    ZSBoardNode *board = (ZSBoardNode*)[self parent];
    [board removeTileAtColumn:self.column andRow:self.row];
    [self disconnect];
}



@end
