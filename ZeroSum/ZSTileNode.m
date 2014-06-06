//
//  ZSTileNode.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/17/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSTileNode.h"
#import "ZSUtility.h"

@implementation ZSTileNode {
    SKNode *connector;
}

+(ZSTileNode*)nodeWithValue:(int)value {
    ZSTileNode *ret = [[ZSTileNode alloc] initWithValue:value];
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
-(ZSTileNode*)initWithValue:(int)value {
    self = [super init];
    _value = value;
    return self;
}


-(void)connectTo:(ZSTileNode*)next {
    // Check if the next node is a neighbor.
    if([self isNeighborsWith:next] == NO) {
        DEBUG_LOG(@"Cannot connect non-neighboring nodes.");
        return;
    }
    
    // TODO: Replace connector with sprite.
    SKShapeNode* conn = [SKShapeNode node];
    
    CGMutablePathRef k = CGPathCreateMutable();
    CGPathMoveToPoint(k, NULL,
                      self.position.x + SQUARE_SIZE / 2,
                      self.position.y + SQUARE_SIZE / 2);
    CGPathAddLineToPoint(k, NULL,
                         next.position.x + SQUARE_SIZE / 2,
                         next.position.y + SQUARE_SIZE / 2);
    conn.path = k;
    conn.strokeColor = [UIColor yellowColor];
    conn.lineWidth = 1;
    
    connector = conn; // Set this node to connected.
    
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
    if(connector != nil) {
        [connector removeFromParent];
        connector = nil;
    } else {
        DEBUG_LOG(@"Cannot disconnect unconnected node.");
    }
}

/**
 *  Draws the actual tile.
 */
// TODO: Replace with sprite.
-(void)draw {
    SKShapeNode* s = [SKShapeNode node];
    s.path = CGPathCreateWithRect(CGRectMake(0, 0, SQUARE_SIZE, SQUARE_SIZE), NULL);
    s.position = CGPointMake(1, 1);
    s.strokeColor = _value < 0 ? [UIColor redColor] : [UIColor cyanColor];
    
    SKLabelNode* l = [SKLabelNode node];
    l.text = [NSString stringWithFormat:@"%d", abs(_value)];
    l.fontSize = SQUARE_SIZE / 2;
    l.position = CGPointMake(SQUARE_SIZE / 2, SQUARE_SIZE / 4);
    l.fontColor = [UIColor blackColor];
    [s addChild:l];
    
    [self addChild:s];
}



@end
