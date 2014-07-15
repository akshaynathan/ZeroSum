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

+ (ZSTileNode *)nodeWithValue:(int)value {
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
- (ZSTileNode *)initWithValue:(int)value {
  if (self = [super init]) {
    _value = value;
  }
  return self;
}

- (void)connectTo:(ZSTileNode *)next {
  // Check if the next node is a neighbor.
  if ([self isNeighborsWith:next] == NO) {
    return;
  }

  // TODO: Replace connector with sprite.
  SKShapeNode *conn = [SKShapeNode node];

  CGMutablePathRef k = CGPathCreateMutable();
  CGPathMoveToPoint(k, NULL, self.position.x + SQUARE_SIZE / 2,
                    self.position.y + SQUARE_SIZE / 2);
  CGPathAddLineToPoint(k, NULL, next.position.x + SQUARE_SIZE / 2,
                       next.position.y + SQUARE_SIZE / 2);
  conn.path = k;
  conn.strokeColor = UIColorFromRGB(CONNECTOR_COLOR);
  conn.lineWidth = 3;

  connector = conn;  // Set this node to connected.

  [self.parent addChild:connector];
}

- (BOOL)isNeighborsWith:(ZSTileNode *)other {
  return (other.column == _column + 1 && other.row == _row) ||
         (other.column == _column - 1 && other.row == _row) ||
         (other.column == _column && other.row == _row + 1) ||
         (other.column == _column && other.row == _row - 1) ||
         (other.column == _column + 1 && other.row == _row - 1) ||
         (other.column == _column + 1 && other.row == _row + 1) ||
         (other.column == _column - 1 && other.row == _row - 1) ||
         (other.column == _column - 1 && other.row == _row + 1);
}

- (BOOL)isConnected {
  return connector != NULL;
}

- (void)disconnect {
  if (connector != nil) {
    [connector removeFromParent];
    connector = nil;
  }
}

- (BOOL)isCentered:(CGPoint)p {
  int center = TILE_SIZE / 2;
  return (p.x >= center - CENTER_BUFFER && p.x <= center + CENTER_BUFFER) &&
         (p.y >= center - CENTER_BUFFER && p.y <= center + CENTER_BUFFER);
}

/**
 *  Draws the actual tile.
 */
// TODO: Replace with sprite.
- (void)draw {
  int final_size = SQUARE_SIZE - TILE_EDGE / 2;

  SKShapeNode *s = [SKShapeNode node];
  s.path = CGPathCreateWithRoundedRect(CGRectMake(0, 0, final_size, final_size),
                                       2, 2, nil);
  s.position = CGPointMake(1, 1);
  s.strokeColor = _value < 0 ? UIColorFromRGB(NEGATIVE_COLOR)
                             : UIColorFromRGB(POSITIVE_COLOR);
  s.lineWidth = 3;

  SKLabelNode *l = [SKLabelNode labelNodeWithFontNamed:@"Menlo"];
  l.text = [NSString stringWithFormat:@"%d", abs(_value)];
  l.fontSize = final_size - TILE_EDGE;
  l.position = CGPointMake(final_size / 2, final_size / 2);
  l.fontColor = s.strokeColor;
  l.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
  l.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
  [s addChild:l];

  [self addChild:s];
}

@end
