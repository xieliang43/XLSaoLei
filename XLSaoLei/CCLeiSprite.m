//
//  CCLeiSprite.m
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CCLeiSprite.h"


@implementation CCLeiSprite

@synthesize row = _row;
@synthesize col = _col;
@synthesize isBoom = _isBoom;
@synthesize number = _number;
@synthesize isFlag = _isFlag;
@synthesize delegate = _delegate;
@synthesize isClear = _isClear;

- (id)initWithFile:(NSString *)filename
{
    self = [super initWithFile:filename];
    if (self) {
        _number = 0;
        _isFlag = NO;
        _isBoom = NO;
        _isClear = NO;
    }
    return self;
}

- (void) onEnter
{
    [super onEnter];
    
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void) onExit
{
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return [self containsTouchLocation:touch];
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self containsTouchLocation:touch]) {
        CCLOG(@"%d-%d",_row,_col);
        if ([self.delegate respondsToSelector:@selector(didClickSprite:)]) {
            [self.delegate didClickSprite:self];
        }
    }
}

- (CGRect)rect
{
    CGSize s = [self.texture contentSize];
    return CGRectMake(self.position.x-(s.width/2), self.position.y-(s.height/2), s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
    CGPoint p = [self convertToWorldSpace:[self convertTouchToNodeSpace:touch]];
    CGRect r = [self rect];
    return CGRectContainsPoint(r,p);
}

- (void)cleanColor
{
    [self setTexture:nil];
    [self setTextureRect:CGRectZero];
    _isClear = YES;
}

- (void)displayNumber
{
    [self cleanColor];
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",_number]
                                           fontName:@"Helvetica"
                                           fontSize:16];
    [self addChild:label];
}

- (void)setFlag
{
    _isFlag = YES;
}

- (void)removeFlag
{
    _isFlag = NO;
}



- (void)setBoom
{
    
}

@end
