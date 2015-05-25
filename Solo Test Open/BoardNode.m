//
//  BoardNode.m
//  Solo Test Open
//
//  Created by efe ertugrul on 25/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import "BoardNode.h"

@implementation BoardNode

- (id)initFromFrame:(CGRect)theFrame
{
    self = [super init];
    if (self)
    {
        self=[self initWithColor:[SKColor clearColor] size:theFrame.size];
        [self setPosition:CGPointMake(CGRectGetMidX(theFrame), CGRectGetMidY(theFrame))];
        [self setName:@"board"];
    }
    return self;
}

@end
