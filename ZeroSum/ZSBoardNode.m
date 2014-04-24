//
//  ZSBoardNode.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSBoardNode.h"

@implementation ZSBoardNode {
    NSMutableArray *tiles; // 2d array of tiles
}

+(ZSBoardNode*)node {
    ZSBoardNode* ret = [[ZSBoardNode alloc] init];
    [ret draw];
    return ret;
}

-(id)init {
    self = [super init];
    
    // Initialize 2D array of tiles
    tiles = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++)
        [tiles addObject:[[NSMutableArray alloc] init]];
    
    return self;
}

-(void)draw {
    // Draw Board (to be replaced with image)
    int base_y = 45 - (568/2), top_y = base_y + (40 * 12);
    int border_l = -160;
    
    // Draw the horizontal borders
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathMoveToPoint(p, NULL, -160, base_y);
    CGPathAddLineToPoint(p, NULL, 160, base_y);
    CGPathMoveToPoint(p, NULL, -160, top_y);
    CGPathAddLineToPoint(p, NULL, 160, top_y);
    
    // Draw the grid
    for (int i = 1; i < 8; i++) {
        CGPathMoveToPoint(p, NULL, border_l + (i * 40), base_y);
        CGPathAddLineToPoint(p, NULL, border_l + (i * 40), top_y);
    }
    
    SKShapeNode *grid = [SKShapeNode node];
    grid.path = p;
    grid.strokeColor = [UIColor blackColor];
    grid.antialiased = NO;
    grid.lineWidth = 0.5f;
    [self addChild:grid];
}


-(void)initTiles:(int)num {
    for(int i = 0; i < 8; i++) {
        for(int k = 0; k < num; k++) {
            ZSTileNode *p = [ZSTileNode nodeWithValue:[ZSUtility randomValue]
                                             inColumn:i andRow:k];
            [self addChild:p];
            [[tiles objectAtIndex:i] addObject:p];
        }
    }
}

-(void)removeTileAtColumn:(int)col andRow:(int)row {
    NSMutableArray *column = [tiles objectAtIndex:col];
    [column removeObjectAtIndex:row];
    ZSTileNode *n = [column objectAtIndex:row];
    [n removeFromParent];
    [self shiftDownColumn:column atRow:row];
}

-(void)shiftDownColumn:(NSMutableArray*)column atRow:(int)row {
    int size = (int)[column count];
    for (int i = row; i < size; i++) {
        ZSTileNode *node = [column objectAtIndex:i];
        [node shift:-1 withDuration:0.5f];
    }
}

-(void)addTileAtColumn:(ZSTileNode*)tile atCol:(int)col andRow:(int)row {
    NSMutableArray *column = [tiles objectAtIndex:col];
    [column insertObject:tile atIndex:row];
    [self addChild:tile];
    [self shiftUpColumn:column atRow:row];
}

-(void)shiftUpColumn:(NSMutableArray*)column atRow:(int)row {
    int size = (int)[column count];
    for (int i = row + 1; i < size; i++) {
        ZSTileNode *node = [column objectAtIndex:i];
        [node shift:1 withDuration:0.5f];
    }
}

// Prints the tiles array to stdout
-(void)printArray {
    for (int i = 11; i >= 0; i--) {
        for (int k = 0; k < 8; k++) {
            NSMutableArray *p = [tiles objectAtIndex:k];
            if (i > [p count] - 1) {
                printf("--");
            } else {
                printf("%2d", [(ZSTileNode*)[p objectAtIndex:i] value]);
            }
            
            printf(" ");
        }
        printf("\n");
    }
}

@end
