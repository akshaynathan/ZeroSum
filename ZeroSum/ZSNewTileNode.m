//
//  ZSNewTile.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/5/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSNewTileNode.h"
#import "ZSUtility.h"

@implementation ZSNewTileNode

+(ZSNewTileNode*)nodeWithValue:(int)value {
    ZSNewTileNode *ret = [[ZSNewTileNode alloc] initWithValue:value];
    [ret draw];
    return ret;
}

/**
 *  Init helper for setting the value.
 *
 *  @param value The tiles value.
 *
 *  @return Returns the constructed tile.
 */
-(ZSNewTileNode*)initWithValue:(int)value {
    self = [super init];
    _value = value;
    _isEmerging = NO;
    return self;
}

-(ZSTileNode*)toRealTile {
    ZSTileNode *ret = [ZSTileNode nodeWithValue:_value];
    ret.column = _column;
    ret.row = 1; // All new tiles become row 1 real tiles
    _isEmerging = YES;
    return ret;
}

/**
 *  Draws the actual (new) tile.
 */
// TODO: Replace with sprite.
-(void)draw {
    SKShapeNode* s = [SKShapeNode node];
    
    // We want to draw a dotted line
    CGPathRef k = CGPathCreateWithRect(CGRectMake(0, 0, SQUARE_SIZE, SQUARE_SIZE), NULL);
    CGFloat pattern[] = {2, 7};
    CGPathRef dashed = CGPathCreateCopyByDashingPath(k, NULL, 0, pattern, 2);
    s.path = dashed;
    s.position = CGPointMake(1, 1);
    s.strokeColor = _value < 0 ? [UIColor redColor] : [UIColor greenColor];
    
    SKLabelNode* l = [SKLabelNode node];
    l.text = [NSString stringWithFormat:@"%d", abs(_value)];
    l.fontSize = SQUARE_SIZE / 2;
    l.position = CGPointMake(SQUARE_SIZE / 2, SQUARE_SIZE / 4);
    l.fontColor = [UIColor blackColor];
    [s addChild:l];
    
    [self addChild:s];
}

@end
