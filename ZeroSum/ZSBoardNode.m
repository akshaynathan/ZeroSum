//
//  ZSBoardNode.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSBoardNode.h"
#import "ZSUtility.h"

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
    for (int i = 0; i < BOARD_COLUMNS; i++)
        [tiles addObject:[[NSMutableArray alloc] init]];
    
    return self;
}

/*
 Adds num tiles to each column
 */
-(void)initTiles:(int)num {
    for(int i = 0; i < BOARD_COLUMNS; i++) {
        for(int k = 0; k < num; k++) {
            ZSTileNode *p = [ZSTileNode nodeWithValue:[ZSUtility randomValue]];
            [self addTile:p atColumn:i andRow:k];
        }
    }
}

-(ZSTileNode*)addTile:(ZSTileNode *)tile atColumn:(int)col andRow:(int)row {
    NSMutableArray *column = [tiles objectAtIndex:col];
    
    // Sanity checks
    if([column count] < row || column == nil ||
       row >= BOARD_ROWS || row < 0) {
        return nil;
    }
    
    // Insert the tile into the grid
    [column insertObject:tile atIndex:row];
    
    // Insert the tile onto the actual board
    //[tile setColumn:col andRow:row];
    [self addChild:tile];
    
    // Shift up the other tiles
    return nil;
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
        //[node shift:-1 withDuration:0.5f];
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
        //[node shift:1 withDuration:0.5f];
    }
}

/**
 *  Draws the board
 */
// TODO: Replace the manual drawing with a sprite.
-(void)draw {
    // Draw Board (to be replaced with image)
    int base_y = BOTTOM_BUFFER - (TILE_SIZE * BOARD_ROWS/2);
    int top_y = base_y + (TILE_SIZE * BOARD_ROWS);
    int border_l = -(TILE_SIZE * BOARD_COLUMNS/2);
    
    // Draw the horizontal borders
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathMoveToPoint(p, NULL, border_l, base_y);
    CGPathAddLineToPoint(p, NULL, -border_l, base_y);
    CGPathMoveToPoint(p, NULL, border_l, top_y);
    CGPathAddLineToPoint(p, NULL, -border_l, top_y);
    
    // Draw the grid
    for (int i = 1; i < 8; i++) {
        CGPathMoveToPoint(p, NULL, border_l + (i * TILE_SIZE), base_y);
        CGPathAddLineToPoint(p, NULL, border_l + (i * TILE_SIZE), top_y);
    }
    
    SKShapeNode *grid = [SKShapeNode node];
    grid.path = p;
    grid.strokeColor = [UIColor blackColor];
    grid.antialiased = NO;
    grid.lineWidth = 0.5f;
    [self addChild:grid];
}

/**
 *  Prints the 2d array contents (tiles by value) to stdout.
 */
-(void)printArray {
    for (int i = BOARD_ROWS; i > 1; i--) {
        for (int k = 0; k < BOARD_COLUMNS; k++) {
            NSMutableArray *p = [tiles objectAtIndex:k];
            
            // Above highest tile
            if (i > [p count] - 1)
                printf("--");
            else
                printf("%2d", [(ZSTileNode*)[p objectAtIndex:i] value]);
            
            // Column Separator
            printf(" ");
        }
        // Row Separator
        printf("\n");
    }
}

@end
