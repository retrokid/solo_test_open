//
//  GeoCalc.m
//  Solo Test Open
//
//  Created by efe ertugrul on 20/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//
/*
 Redistribution and use in source and binary forms, with or without modification, are permitted provided
 that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this list of conditions and
 the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions
 and the following disclaimer in the documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
//nslog characters

//positive ✅
//negative ⛔️
//routine info 🔵
//live info ⚪️

#import "GeoCalc.h"

@implementation GeoCalc

/*
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
*/
-(id)initWithSceneFrame:(CGRect)theFrame
{
    NSLog(@"🔵 %@ -(id)initWithFrame:(CGRect)theFrame CALLED",NSStringFromClass(self.class));
    self = [super init];
    if (self)
    {
        frame=theFrame;
        NSLog(@"✅ %@ -(id)initWithFrame:(CGRect)theFrame SUCCESS",NSStringFromClass(self.class));
        NSLog(@"🔵 %@ -(id)initWithFrame:(CGRect)theFrame -- theFrame=%@",NSStringFromClass(self.class),NSStringFromCGRect(frame));
    }
    else
    {
        NSLog(@"⛔️ %@ -(id)initWithFrame:(CGRect)theFrame FAIL",NSStringFromClass(self.class));
    }
    return self;
}

#pragma mark - Ray Dimensions

-(CGFloat)hRayWidth
{
    return self.boardMaxWidth;
}

-(CGFloat)hRayHeight
{
    return ((self.boardMaxWidth/8)/4);
}

-(CGFloat)vRayWidth
{
    return ((self.boardMaxWidth/8)/4);
}

-(CGFloat)vRayHeight
{
    return self.boardMaxWidth;
}

#pragma mark - Board Dimensions

-(CGFloat)boardMaxWidth
{
    return CGRectGetWidth(frame);
}

-(CGFloat)boardMaxHeight
{
    return CGRectGetWidth(frame);
}

-(CGFloat)boardMinX
{
    return (CGRectGetWidth(frame)/8);
}

-(CGFloat)boardMinY
{
    return (CGRectGetWidth(frame)/8);
}

#pragma mark - Pawn Dimensions

-(CGFloat)pawnHeight
{
    return self.boardMaxHeight/10;
}

-(CGFloat)pawnWidth
{
    return self.boardMaxWidth/10;
}

#pragma mark - Positioning

//returns possible board pawn points coordinates

-(NSArray *)boardPawnPointsCoordinates
{
    CGFloat minX=self.boardMinX;
    CGFloat minY=self.boardMinY;

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
    
    NSArray *pawnPoints=@[[NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYMinusThree)],
                          [NSValue valueWithCGPoint:CGPointMake(0, originYMinusThree)],
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYMinusThree)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYMinusTwo)],
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
                          [NSValue valueWithCGPoint:CGPointMake(originXPlusOne, originYPlusThree)],
                          [NSValue valueWithCGPoint:CGPointMake(0, originYPlusThree)],
                          [NSValue valueWithCGPoint:CGPointMake(originXMinusOne, originYPlusThree)]];
    
    //To Access Value Use : CGPoint value=[pawnPoints[0] CGPointValue];
    
    return pawnPoints;
}

//returns boardPawnPointsCoordinates[index]'s index if it can be drop to that point.Returns -1 if it can't be drop

-(NSInteger)findDropPointOfSelectedPawn:(CGPoint)lastPositionWhenTouchEnded inCoordinates:(NSArray *)boardPawnPointsCoordinates
{
    for(NSInteger i=0;i<[boardPawnPointsCoordinates count];i++)
    {
        if(CGRectIntersectsRect(CGRectMake(lastPositionWhenTouchEnded.x, lastPositionWhenTouchEnded.y, [self pawnWidth], [self pawnHeight]), CGRectMake([boardPawnPointsCoordinates[i] CGPointValue].x, [boardPawnPointsCoordinates[i] CGPointValue].y, [self pawnWidth], [self pawnHeight])))
        {
            return i;
        }
    }
    return -1;
}

//returns boardPawnPointsCoordinates[index]'s index or -1 if it fails

-(NSInteger)findPickupPointOfSelectedPawn:(CGPoint)selectedPawnPosition inCoordinates:(NSArray *)boardPawnPointsCoordinates
{
    for(NSInteger i=0;i<[boardPawnPointsCoordinates count];i++)
    {
        if([boardPawnPointsCoordinates[i] CGPointValue].x==selectedPawnPosition.x && [boardPawnPointsCoordinates[i] CGPointValue].y==selectedPawnPosition.y)
        {
            return i;
        }
    }
    return -1;
}


@end
