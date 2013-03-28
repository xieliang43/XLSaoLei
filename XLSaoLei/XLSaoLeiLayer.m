//
//  XLSaoLeiLayer.m
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "XLSaoLeiLayer.h"

const int hard_lei_num = 20;
const int middle_lei_num = 15;
const int simple_lei_num = 10;

@implementation XLSaoLeiLayer

@synthesize level = _level;

- (void)dealloc
{
    [allLeiSprites release];
    [leiSprites release];
    [super dealloc];
}

#pragma mark - 初始化
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setHardLavel:(HardLevel)level
{
    _level = level;
    switch (_level) {
        case HardGame:
        {
            lei_num = hard_lei_num;
            break;
        }
        case MiddleGame:
        {
            lei_num = middle_lei_num;
            break;
        }
        case SimpleGame:
        {
            lei_num = simple_lei_num;
            break;
        }
        default:
            break;
    }
}

- (void)onEnter
{
    [super onEnter];
    
    allLeiSprites = [[CCArray alloc] initWithCapacity:rows];
    leiSprites = [[CCArray alloc] initWithCapacity:lei_num];
    
    //init parameters
    CGSize s = [[CCDirector sharedDirector] winSize];
    if (s.height > 480) {
        rows = 11;
    }else{
        rows = 9;
    }
    cols = 9;
    cell_width = 32;
    width = cell_width * cols + cols + 1;
    
    [self createPan];
    [self randCreateLei];
    [self setSpriteNumber];
    [self addAllSprite];
}

- (void)createPan
{    
    for (int i = 0; i < rows; i++) {
        CCArray *row_arr = [CCArray arrayWithCapacity:cols];
        for (int j = 0; j < cols; j++) {
            CCLeiSprite *sprite = [CCLeiSprite spriteWithFile:@"cell.png"];
            sprite.contentSize = CGSizeMake(cell_width, cell_width);
            sprite.delegate = self;
            sprite.row = i;
            sprite.col = j;
            [row_arr addObject:sprite];
        }
        [allLeiSprites addObject:row_arr];
    }
}

- (void)randCreateLei
{
    int leis = 0;
    do {
        int result = arc4random()%(rows*cols);
        int row = result%rows;
        int col = result/rows;
        
        CCLeiSprite *sprite = [[allLeiSprites objectAtIndex:row] objectAtIndex:col];
        if (!sprite.isBoom) {
            leis += 1;
            sprite.isBoom = YES;
            [leiSprites addObject:sprite];
        }
        
    } while (leis < lei_num);
}

- (void)setSpriteNumber
{
    for (int i = 0; i < [leiSprites count]; i++) {
        CCLeiSprite *sprite = [leiSprites objectAtIndex:i];
        
        //lt
        int row = sprite.row - 1;
        int col = sprite.col - 1;;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
        //t
        row = sprite.row - 1;
        col = sprite.col;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
        //rt
        row = sprite.row - 1;
        col = sprite.col + 1;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
        //l
        row = sprite.row;
        col = sprite.col - 1;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
        //r
        row = sprite.row;
        col = sprite.col + 1;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
        //lb
        row = sprite.row + 1;
        col = sprite.col - 1;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
        //b
        row = sprite.row + 1;
        col = sprite.col;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
        //rb
        row = sprite.row + 1;
        col = sprite.col + 1;
        [self changeNumberOfSpriteWithRow:row withCol:col];
        
    }
}

- (void)changeNumberOfSpriteWithRow:(int)row withCol:(int)col
{
    if (row >= 0 && row < rows && col >= 0 && col < cols) {
        CCLeiSprite *sprite = [[allLeiSprites objectAtIndex:row] objectAtIndex:col];
        if (!sprite.isBoom) {
            sprite.number += 1;
        }
    }
}

- (void)addAllSprite
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    int startx = (winSize.width - width)/2 + cell_width/2 + 1;
    int starty = winSize.height - 120 + cell_width/2;
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            CCLeiSprite *sprite = [[allLeiSprites objectAtIndex:i] objectAtIndex:j];
            CGPoint point = ccp(startx+j*(cell_width+1),starty-i*(cell_width+1));
            sprite.position = point;
            [self addChild:sprite];
            
            CCLOG(@"%d",sprite.number);
        }
    }
}

#pragma mark - CCLeiSpriteDelegate
- (void)didClickSprite:(CCLeiSprite *)sprite
{
    CCLOG(@"click sprite");
    if (sprite.number == 0 && !sprite.isBoom) {
        [self ergodicNode:sprite];
    }
}

#pragma mark - 遍历相关接点，设置状态
- (void)ergodicNode:(CCLeiSprite *)sprite
{
    [sprite cleanColor];
    
    //t
    int row = sprite.row - 1;
    int col = sprite.col;
    [self changeSpriteState:row withCol:col];
    
    //l
    row = sprite.row;
    col = sprite.col - 1;
    [self changeSpriteState:row withCol:col];
    
    //r
    row = sprite.row;
    col = sprite.col + 1;
    [self changeSpriteState:row withCol:col];
    
    //b
    row = sprite.row + 1;
    col = sprite.col;
    [self changeSpriteState:row withCol:col];
    
}

- (void)changeSpriteState:(int)row withCol:(int)col
{
    if (row >= 0 && row < rows && col >= 0 && col < cols) {
        CCLeiSprite *sprite = [[allLeiSprites objectAtIndex:row] objectAtIndex:col];
        CCLOG(@"%d-%d-%d",sprite.row,sprite.col,sprite.number);
        if (sprite.isClear) {
            return;
        }else if (sprite.number == 0){
            [self ergodicNode:sprite];
        }else{
            [sprite displayNumber];
        }
    }else{
        return;
    }
}

@end
