//
//  XLMainMenuLayer.m
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "XLMainMenuLayer.h"


@implementation XLMainMenuLayer

+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	XLMainMenuLayer *layer = [XLMainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    if( (self=[super init] )) {
        
        
    }
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    //添加背景
    CCSprite *background = [CCSprite spriteWithFile:@"bg.png"];
    background.position = ccp(s.width/2,s.height/2);
    [self addChild:background];
    
    CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"简单"];
    [item1 setBlock:^(id sender) {
        [[CCDirector sharedDirector] pushScene:[XLGameBackground scene]];
    }];
    
    CCMenuItemFont *item2 = [CCMenuItemFont itemWithString:@"中等"];
    
    CCMenuItemFont *item3 = [CCMenuItemFont itemWithString:@"困难"];
    
    CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3,nil];
    [menu alignItemsVertically];
    
    int i=0;
    for( CCNode *child in [menu children] ) {
        CGPoint dstPoint = child.position;
        int offset = s.width/2 + 50;
        
        if( i % 2 == 0)
            offset = -offset;
        
        child.position = ccp( dstPoint.x + offset, dstPoint.y);
        [child runAction:
         [CCEaseElasticInOut actionWithAction:
          [CCMoveBy actionWithDuration:2 position:ccp(dstPoint.x - offset,0)]
                                     period: 0.35f]
         ];
        i++;
    }
    
    [self addChild:menu];
    menu.position = ccp(s.width/2,s.height/2);
}

- (void)onEnterTransitionDidFinish
{
    
}

@end
