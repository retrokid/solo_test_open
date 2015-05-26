//
//  VRayNode.m
//  Solo Test Open
//
//  Created by efe ertugrul on 26/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import "VRayNode.h"

@implementation VRayNode

- (id)initWithBoardSize:(CGSize)boardSize name:(NSString *)theName andPosition:(CGPoint)thePosition
{
    self = [super init];
    if (self)
    {
        self=[self initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                             color:[SKColor clearColor]
                             size:CGSizeMake((boardSize.width/8)/4, boardSize.width)];
        [self setPosition:thePosition];
        [self setName:theName];
    }
    return self;
}

@end
