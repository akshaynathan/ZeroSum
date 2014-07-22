//
//  ZSNewTile.m
//  ZeroSum
//
//  Created by Akshay Nathan on 6/5/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSNewTileNode.h"
#import "ZSUtility.h"

@implementation ZSNewTileNode {
  SKShapeNode *border;
}

+ (ZSNewTileNode *)nodeWithValue:(int)value {
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
- (ZSNewTileNode *)initWithValue:(int)value {
  if (self = [super init]) {
    _value = value;
    _isEmerging = NO;
  }
  return self;
}

- (ZSTileNode *)toRealTile {
  ZSTileNode *ret = [ZSTileNode nodeWithValue:_value];
  ret.column = _column;
  ret.row = 1;  // All new tiles become row 1 real tiles
  _isEmerging = YES;
  return ret;
}

- (void)startAnimation:(double)duration {
  // We want to draw a dotted line
  double sideLength = (SQUARE_SIZE - TILE_EDGE / 2);
  [self runAction:[SKAction customActionWithDuration:duration
                                         actionBlock:^(SKNode *node,
                                                       CGFloat elapsedTime) {
                                             double ratio =
                                                 elapsedTime / duration;
                                             int drawDouble =
                                                 (int)(ratio * sideLength * 4);
                                             [self animatePath:border
                                                    withLength:drawDouble];
                                         }]];
}

/**
 *  Draws the actual (new) tile.
 */
- (void)draw {
  border = [SKShapeNode node];
  border.strokeColor = [UIColor blackColor];
  border.position = CGPointMake(1, 1);
  border.strokeColor = _value < 0 ? UIColorFromRGB(NEGATIVE_COLOR)
                                  : UIColorFromRGB(POSITIVE_COLOR);

  double sideLength = (SQUARE_SIZE - TILE_EDGE / 2);
  SKLabelNode *l = [SKLabelNode labelNodeWithFontNamed:@"Menlo"];
  l.text = [NSString stringWithFormat:@"%d", abs(_value)];
  l.fontSize = sideLength - TILE_EDGE;
  l.position = CGPointMake(sideLength / 2, sideLength / 2);
  l.fontColor = border.strokeColor;
  l.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
  l.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
  [border addChild:l];

  [self addChild:border];
}

/**
 *  Adds a CGPath to the border of the shape.
 *
 *  @param s          The ShapeNode to border.
 *  @param drawLength The length of the path.
 */
// TODO: Add tests for this.
- (void)animatePath:(SKShapeNode *)s withLength:(double)drawLength {
  int sideLength = SQUARE_SIZE - TILE_EDGE / 2;
  CGMutablePathRef k = CGPathCreateMutable();
  CGPathMoveToPoint(k, NULL, 0, sideLength);
  int i = 0;
  if (drawLength > 0) {
    i = MIN(sideLength, drawLength);
    CGPathAddLineToPoint(k, NULL, i, sideLength);
    drawLength -= i;
  }
  if (drawLength > 0) {
    i = MIN(sideLength, drawLength);
    CGPathAddLineToPoint(k, NULL, sideLength, sideLength - i);
    drawLength -= i;
  }
  if (drawLength > 0) {
    i = MIN(sideLength, drawLength);
    CGPathAddLineToPoint(k, NULL, sideLength - i, 0);
    drawLength -= i;
  }
  if (drawLength > 0) {
    i = MIN(sideLength, drawLength);
    CGPathAddLineToPoint(k, NULL, 0, i);
    drawLength -= i;
  }
  s.path = k;
  CGPathRelease(k);
}

@end
