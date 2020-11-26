//
//  PawnNode.m
//  Solo Test Open
//
//  Created by efe ertugrul on 25/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import "PawnNode.h"

@implementation PawnNode

-(id)initWithBoardSize:(CGSize)boardSize andName:(NSString *)thePawnName
{
    self = [super init];
    if (self)
    {
        self=[self initWithTexture:[SKTexture textureWithImageNamed:@"siyahPiyon"]
                             color:[SKColor clearColor]
                              size:CGSizeMake(boardSize.width/10, boardSize.height/10)];
        [self setPosition:CGPointMake(0-boardSize.width, 0)];
        [self setName:thePawnName];
    }
    return self;
}

@end
