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

  [self drawConnector:next];
}

/**
 *  Draws the connector the next tile node.
 *
 *  @param next The next tile node.
 */
- (void)drawConnector:(ZSTileNode *)next {
  SKShapeNode *conn = [SKShapeNode node];

  CGMutablePathRef k = CGPathCreateMutable();
  CGFloat center = SQUARE_SIZE / 2;
  CGFloat buffer = center - CONNECTOR_BUFFER;
  CGPathMoveToPoint(
      k, NULL, self.position.x + center + ((next.column - _column) * buffer),
      self.position.y + center + ((next.row - _row) * buffer));
  CGPathAddLineToPoint(
      k, NULL, next.position.x + center + ((_column - next.column) * buffer),
      next.position.y + center + ((_row - next.row) * buffer));

  conn.strokeColor = UIColorFromRGB(CONNECTOR_COLOR);
  conn.lineWidth = CONNECTOR_WIDTH;
  conn.path = k;
  CGPathRelease(k);

  connector = conn;
  [self.parent addChild:connector];
}

- (BOOL)isNeighborsWith:(ZSTileNode *)other {
  return (ABS(other.column - _column) <= 1 && ABS(other.row - _row) <= 1) &&
         !((other.row == _row) && (other.column == _column));
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
