//
//  HRayNode.m
//  Solo Test Open
//
//  Created by efe ertugrul on 26/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import "HRayNode.h"

@implementation HRayNode

@synthesize startupPosition;

- (id)initWithBoardSize:(CGSize)boardSize name:(NSString *)theName andPosition:(CGPoint)thePosition
{
    self = [super init];
    if (self)
    {
        self=[self initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                             color:[SKColor clearColor]
                              size:CGSizeMake(boardSize.width, (boardSize.width/8)/4)];
        [self setPosition:thePosition];
        [self setName:theName];
    }
    return self;
}


@end
