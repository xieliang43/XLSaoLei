//
//  CCLeiSprite.h
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol CCLeiSpriteDelegate;

@interface CCLeiSprite : CCSprite<CCTargetedTouchDelegate> {
    CCSprite *mask;
    CCSprite *boomSprite;
}

@property (nonatomic,assign) NSInteger row;
@property (nonatomic,assign) NSInteger col;
@property (nonatomic,assign) BOOL isBoom;
@property (nonatomic,assign,readonly) BOOL isFlag;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,assign) id<CCLeiSpriteDelegate> delegate;

- (void)displayNumber;
- (void)setFlag;
- (void)removeFlag;
- (void)cleanColor;
- (void)setBoom;

@end

@protocol CCLeiSpriteDelegate <NSObject>

@optional
- (void)didClickSprite:(CCLeiSprite *)sprite;

@end
