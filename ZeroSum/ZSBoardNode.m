//
//  ZSBoardNode.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/3/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSBoardNode.h"
#import "ZSUtility.h"
#import "ZSTileNode.h"
#import "ZSNewTileNode.h"


@implementation ZSBoardNode {
    NSMutableArray *tiles; // 2d array of tiles
    id new_tiles[8]; // Array of newTiles
}

+(ZSBoardNode*)node {
    ZSBoardNode* ret = [[ZSBoardNode alloc] init];
    [ret draw];
    return ret;
}

-(id)init {
    self = [super init];
    
    // Initialize arrays
    tiles = [[NSMutableArray alloc] init];
    for (int i = 0; i < BOARD_COLUMNS; i++) {
        [tiles addObject:[[NSMutableArray alloc] init]];
        new_tiles[i] = nil;
    }

    return self;
}

/**
 *  Get the actual position of the Tile relative to board dimensions.
 *
 *  @param tile The tile to set position of.
 */
-(CGPoint)getPositionForTile:(ZSTileNode*)tile {
    return CGPointMake(tile.column * TILE_SIZE - (BOARD_COLUMNS * TILE_SIZE)/2,
                                  tile.row * TILE_SIZE - (BOARD_ROWS * TILE_SIZE)/2);
}

/**
 *  Get the actual position of the NewTile relative to board dimensions.
 *
 *  @param tile The tile to set position of.
 */
-(CGPoint)getPositionForNewTile:(ZSNewTileNode*)tile {
    return CGPointMake(tile.column * TILE_SIZE - (BOARD_COLUMNS * TILE_SIZE)/2,
                       - (BOTTOM_BUFFER/2) - (BOARD_ROWS * TILE_SIZE)/2);
}

/**
 *  Adds an action to shift the given tile (vertically).
 *
 *  @param shift The number of rows to shift the tile.
 *  @param tile  The tile to shift.
 */
-(void)addShift:(int)shift forTile:(ZSTileNode*)tile {
    CGPoint newpos = [self getPositionForTile:tile];
    
    // This is for testing
    NSString *key = [NSString stringWithFormat:@"moveTo(%d, %d)", (int)newpos.x, (int)newpos.y];
    
    SKAction *action = [SKAction moveTo:newpos
                               duration:(shift > 0 ? UPWARD_SHIFT_DURATION : DOWNWARD_SHIFT_DURATION)];
    
    [tile runAction:action
            withKey:key];
}

-(ZSTileNode*)addTile:(ZSTileNode *)tile atColumn:(int)col andRow:(int)row {
    // Sanity checks
    if((row >= BOARD_ROWS || row < 0) ||
       (col >= BOARD_COLUMNS || col < 0)) {
        return nil;
    }
    
    NSMutableArray *column_array = [tiles objectAtIndex:col];
    
    // Set the tile position
    tile.row = (int)MIN([column_array count], row); // Tile falls down
    tile.column = col;
    [tile setPosition:[self getPositionForTile:tile]];
    
    // Insert the tile into the grid
    [column_array insertObject:tile atIndex:tile.row];
    
    // Shift up the other tile
    int i = tile.row + 1;
    while(i < [column_array count]) {
        ZSTileNode *neighbor = [column_array objectAtIndex:i];
        neighbor.row++; // Increment row

        [self addShift:1 forTile:neighbor]; // Shift the tile

        i++;
    }
    
    // Insert the tile onto the actual board
    [self addChild:tile];
    return tile;
}


-(ZSTileNode*)removeTileAtColumn:(int)col andRow:(int)row {
    // Sanity checks
    if((row >= BOARD_ROWS || row < 0) ||
       (col >= BOARD_COLUMNS || col < 0)) {
        return nil;
    }
    
    NSMutableArray *column_array = [tiles objectAtIndex:col];
    if(row >= [column_array count])
        return nil;
    
    ZSTileNode *n = [column_array objectAtIndex:row];
    
    // Remove the object from the grid
    [column_array removeObjectAtIndex:row];
    
    // Delete the tile from the board
    [n removeFromParent];
    
    // Remove the connector if it exists
    [n disconnect];
    
    // Shift down the other tiles
    int i = n.row; // Start at the new occupant
    while(i < [column_array count]) {
        ZSTileNode *neighbor = [column_array objectAtIndex:i];
        neighbor.row--; // Increment row
        [neighbor runAction:[SKAction moveByX:0
                                            y:-TILE_SIZE
                                     duration:DOWNWARD_SHIFT_DURATION]];
        i++;
    }
    return n;
}

-(ZSTileNode*)tileAtColumn:(int)col andRow:(int)row {
    // Sanity checks
    if((row >= BOARD_ROWS || row < 0) ||
       (col >= BOARD_COLUMNS || col < 0)) {
        return nil;
    }
    
    NSMutableArray *column_array = [tiles objectAtIndex:col];
    if(row >= [column_array count])
        return nil;
    
    return [column_array objectAtIndex:row];
}

-(ZSNewTileNode*)addNewTile:(ZSNewTileNode *)tile atColumn:(int)col {
    // Sanity checks
    if(col >= BOARD_COLUMNS || col < 0) {
        return nil;
    }
    
    ZSNewTileNode *k = new_tiles[col];
    if(k != nil)
        return nil; // there is already a new tile here
    
    new_tiles[col] = tile;
    // Add the tile to the actual board
    tile.position = [self getPositionForNewTile:tile];
    [self addChild:tile];
    
    return tile;
}

-(ZSNewTileNode*)newTileAtColumn:(int)col {
    // Sanity checks
    if(col >= BOARD_COLUMNS || col < 0) {
        return nil;
    }
    
    return new_tiles[col];
}

-(ZSNewTileNode*)removeNewTileAtColumn:(int)col {
    // Sanity checks
    if(col >= BOARD_COLUMNS || col < 0) {
        return nil;
    }
    
    ZSNewTileNode *k = [self newTileAtColumn:col];
    if(k == nil)
        return nil;
    
    
    new_tiles[col] = nil;
    // Remove the tile from the actual grid
    [k removeFromParent];
    
    return k;
}

/**
 *  Draws the board
 */
// TODO: Replace the manual drawing with a sprite.
-(void)draw {
    // Draw Board (to be replaced with image)
    int base_y = 0 - (TILE_SIZE * BOARD_ROWS/2);
    int top_y = base_y + (TILE_SIZE * BOARD_ROWS);
    int border_l = 0 - (TILE_SIZE * BOARD_COLUMNS/2);
    
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
    grid.lineWidth = 1;
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
