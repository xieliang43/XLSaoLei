//
//  XLSaoLeiLayer.m
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "XLSaoLeiLayer.h"


@implementation XLSaoLeiLayer

@synthesize level = _level;

- (id)init
{
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"kuang.png"];
        background.position = ccp(s.width/2,s.height/2);
        [self addChild:background];
    }
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    switch (_level) {
        case HardGame:
        {
            //9*9,32
            width = 9 * 32 + 10;
            break;
        }
        case MiddleGame:
        {
            //7*7,44
            break;
        }
        case SimpleGame:
        {
            //5*5,62
            break;
        }
        default:
            break;
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
