//
//  XLSaoLeiLayer.m
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "XLSaoLeiLayer.h"


@implementation XLSaoLeiLayer

- (void)onEnter
{
    [super onEnter];
    
    CGRect rect = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    CCSprite *bg = [[CCSprite alloc] initWithFile:@"Default.png" rect:rect];
    [self addChild:bg];
    [bg release];
}

@end
