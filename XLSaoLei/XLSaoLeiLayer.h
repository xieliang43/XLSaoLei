//
//  XLSaoLeiLayer.h
//  XLSaoLei
//
//  Created by xie liang on 3/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCDrawingPrimitives.h"
#import "CCLeiSprite.h"

typedef enum{
    HardGame,
    MiddleGame,
    SimpleGame
}HardLevel;

@interface XLSaoLeiLayer : CCLayer {
    
    int rows;
    int cols;
    int cell_width;
    int width;
    
    int lei_num;
    
    CCArray *allLeiSprites;
    CCArray *leiSprites;
    
    float delta;
}

@property (nonatomic,assign,setter = setHardLavel:) HardLevel level;

@end
