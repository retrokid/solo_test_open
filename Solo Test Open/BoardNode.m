//
//  BoardNode.m
//  Solo Test Open
//
//  Created by efe ertugrul on 25/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import "BoardNode.h"

@implementation BoardNode

@synthesize numberOfPawnPoints;

-(id)initFromFrame:(CGRect)theFrame
{
    self = [super init];
    if (self)
    {
        self=[self initWithColor:[SKColor clearColor] size:theFrame.size];
        [self setPosition:CGPointMake(CGRectGetMidX(theFrame), CGRectGetMidY(theFrame))];
        [self setName:@"board"];
        //*********order is important!!!
        [self setPawnPointsCoordinates:theFrame];
        [self setNumberOfPawnPoints:[[self pawnPointsCoordinates] count]];
        [self setSize:CGSizeMake(CGRectGetWidth(theFrame), CGRectGetWidth(theFrame))];
        [self setCurrentPawnPoints];
        [self setPossibleMovements];
    }
    return self;
}

-(BOOL)isThereAnyMovementsLeft
{
    for(NSInteger i=0;i<[self.possibleMovements count];i++)
    {
        NSArray *movementRule=self.possibleMovements[i];
        if(([[self.currentPawnPoints objectAtIndex:[[movementRule objectAtIndex:0] integerValue]] boolValue]) &&
           ([[self.currentPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue]) &&
           !([[self.currentPawnPoints objectAtIndex:[[movementRule objectAtIndex:2] integerValue]] boolValue]))
        {
            return YES;
        }
    }
    return NO;
}


-(BOOL)isThisMovePossibleFromPointOf:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint
{
    if([self.currentPawnPoints[theDropPoint] boolValue])
    {
        return NO;
    }
    for(NSInteger i=0;i<[self.possibleMovements count];i++)
    {
        NSArray *movementRule=self.possibleMovements[i];
        if(theSelectedPawn == [[movementRule objectAtIndex:0] integerValue] &&
           [[self.currentPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue] &&
           theDropPoint == [[movementRule objectAtIndex:2] integerValue])
        {
            return YES;
        }
    }
    return NO;
}


-(NSInteger)findRemovePointOfPawn:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint
{
    if([self.currentPawnPoints[theDropPoint] boolValue])
    {
        return -1;
    }
    for(NSInteger i=0;i<[self.possibleMovements count];i++)
    {
        NSArray *movementRule=[self.possibleMovements objectAtIndex:i];
        if(theSelectedPawn == [[movementRule objectAtIndex:0] integerValue] &&
           [[self.currentPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue] &&
           theDropPoint == [[movementRule objectAtIndex:2] integerValue])
        {
            return [[movementRule objectAtIndex:1] integerValue];
        }
    }
    return -1;
}

-(NSInteger)numberOfRemainingPawnsOnBoard
{
    NSUInteger remainingPawns=0;
    for (id isExists in [self currentPawnPoints])
    {
        if([isExists boolValue])
        {
            remainingPawns++;
        }
    }
    return remainingPawns;
}

-(void)setPossibleMovements
{
    possibleMovements=@[@[@0,@1,@2],//
                             @[@0,@3,@8],//
                             @[@1,@4,@9],//
                             @[@2,@1,@0],//
                             @[@2,@5,@10],//
                             @[@3,@4,@5],//
                             @[@3,@8,@15],
                             @[@4,@9,@16],
                             @[@5,@4,@3],
                             @[@5,@10,@17],
                             @[@6,@7,@8],
                             @[@6,@13,@20],//
                             @[@7,@8,@9],//
                             @[@7,@14,@21],//
                             @[@8,@3,@0],//
                             @[@8,@7,@6],//
                             @[@8,@15,@22],//
                             @[@8,@9,@10],
                             @[@9,@16,@23],
                             @[@9,@4,@1],
                             @[@9,@8,@7],
                             @[@9,@10,@11],//
                             @[@10,@5,@2],//
                             @[@10,@9,@8],
                             @[@10,@11,@12],
                             @[@10,@17,@24],//
                             @[@11,@10,@9],//
                             @[@11,@18,@25],
                             @[@12,@11,@10],
                             @[@12,@19,@26],//
                             @[@13,@14,@15],//
                             @[@14,@15,@16],//
                             @[@15,@14,@13],
                             @[@15,@8,@3],
                             @[@15,@16,@17],
                             @[@15,@22,@27],
                             @[@16,@15,@14],
                             @[@16,@9,@4],//
                             @[@16,@17,@18],
                             @[@16,@23,@28],//
                             @[@17,@16,@15],
                             @[@17,@10,@5],
                             @[@17,@18,@19],
                             @[@17,@24,@29],
                             @[@18,@17,@16],
                             @[@19,@18,@17],
                             @[@20,@13,@6],
                             @[@20,@21,@22],
                             @[@21,@14,@7],
                             @[@21,@22,@23],
                             @[@22,@21,@20],
                             @[@22,@15,@8],
                             @[@22,@23,@24],
                             @[@22,@27,@30],
                             @[@23,@22,@21],//
                             @[@23,@16,@9],
                             @[@23,@28,@31],
                             @[@23,@24,@25],
                             @[@24,@23,@22],
                             @[@24,@17,@10],
                             @[@24,@25,@26],
                             @[@24,@29,@32],//
                             @[@25,@18,@11],
                             @[@25,@24,@23],
                             @[@26,@19,@12],
                             @[@26,@25,@24],
                             @[@26,@21,@14],
                             @[@27,@28,@29],
                             @[@27,@22,@15],
                             @[@28,@23,@16],
                             @[@29,@28,@27],
                             @[@29,@24,@17],
                             @[@30,@27,@22],//
                             @[@30,@31,@32],
                             @[@31,@28,@23],
                             @[@32,@31,@30],
                             @[@32,@29,@24]];
}

-(NSArray *)possibleMovements
{
    return possibleMovements;
}

-(void)setCurrentPawnPoints
{
    NSMutableArray *theCurrentPawnPoints=[[NSMutableArray alloc]init];
    for(NSInteger i=0;i<33;i++)
    {
        [theCurrentPawnPoints addObject:@YES];
    }
    theCurrentPawnPoints[16]=@NO;
    currentPawnPoints=theCurrentPawnPoints;
}

-(NSMutableArray *)currentPawnPoints
{
    return currentPawnPoints;
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
