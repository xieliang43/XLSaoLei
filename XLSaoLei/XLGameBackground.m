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
    //id action1=[CCScaleTo actionWithDuration:0.5 scale:1.25];
    id action2=[CCScaleBy actionWithDuration:0.5 scale:.25];
//    id action3=[CCScaleTo actionWithDuration:0.5 scale:1.25];
//    id action4=[CCScaleTo actionWithDuration:0.5 scale:.25];
    id action3=[CCScaleTo actionWithDuration:0.5 scaleX:-1 scaleY:1];
    id action4=[action2 reverse];
    [background runAction:[CCSequence actions:action2,action4, nil]];

}

@end
