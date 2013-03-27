//
//  XLGameBackground.m
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "XLGameBackground.h"


@implementation XLGameBackground

+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	XLGameBackground *layer = [XLGameBackground node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
    XLSaoLeiLayer *sLayer = [XLSaoLeiLayer node];
    sLayer.level = HardGame;
    [scene addChild:sLayer];
    
	// return the scene
	return scene;
}

- (void)onEnter
{
    [super onEnter];
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"bg.png"];
    background.position = ccp(s.width/2,s.height/2);
    [self addChild:background];

}

@end
