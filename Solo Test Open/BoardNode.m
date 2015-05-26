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
        //*********order is important!!!
        [self setPawnPointsCoordinates:theFrame];
        [self setNumberOfPawnPoints];

    }
    return self;
}

-(void)setNumberOfPawnPoints
{
    numberOfPawnPoints=[[self pawnPointsCoordinates]count];
}

-(NSUInteger)numberOfPawnPoints
{
    return numberOfPawnPoints;
}

-(NSArray *)pawnPointsCoordinates
{
    return pawnPointsCoordinates;
}

//To Access Value Use : CGPoint value=[pawnPoints[0] CGPointValue];
-(void)setPawnPointsCoordinates:(CGRect)theFrame
{
    CGFloat minX=CGRectGetWidth(theFrame)/8;
    CGFloat minY=CGRectGetWidth(theFrame)/8;
    
    CGFloat originXMinusOne=0-minX;
    CGFloat originXMinusTwo=0-(2*minX);
    CGFloat originXMinusThree=0-(3*minX);
    
    CGFloat originXPlusOne=0+minX;
    CGFloat originXPlusTwo=0+(2*minX);
    CGFloat originXPlusThree=0+(3*minX);
    
    CGFloat originYMinusOne=0-minY;
    CGFloat originYMinusTwo=0-(2*minY);
    CGFloat originYMinusThree=0-(3*minY);
    
    CGFloat originYPlusOne=0+minY;
    CGFloat originYPlusTwo=0+(2*minY);
    CGFloat originYPlusThree=0+(3*minY);
    
    pawnPointsCoordinates=@[[NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYMinusThree)],//0
                          [NSValue valueWithCGPoint:CGPointMake(0, originYMinusThree)],//1
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYMinusThree)],//2
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYMinusTwo)],//3
                          [NSValue valueWithCGPoint:CGPointMake(0, originYMinusTwo)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYMinusTwo)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusThree, originYMinusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusTwo, originYMinusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYMinusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(0, originYMinusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYMinusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusTwo, originYMinusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusThree, originYMinusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusThree, 0)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusTwo, 0)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, 0)],
                          [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, 0)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusTwo, 0)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusThree, 0)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusThree, originYPlusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusTwo, originYPlusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYPlusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(0, originYPlusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYPlusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusTwo, originYPlusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusThree, originYPlusOne)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYPlusTwo)],
                          [NSValue valueWithCGPoint:CGPointMake(0, originYPlusTwo)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYPlusTwo)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYPlusThree)],
                          [NSValue valueWithCGPoint:CGPointMake(0, originYPlusThree)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYPlusThree)]];
    
}

@end
