//
//  PlayScene.m
//  Solo Test Open
//
//  Created by efe ertugrul on 18/05/15.
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
#import "PlayScene.h"

/*
The property tracks information that doesn’t need to be exposed to clients,
so, it is implemented in a private interface declaration inside of the implementation file
*/

@interface PlayScene()
@property BOOL contentCreated;
@end

@implementation PlayScene

-(void)didMoveToView:(SKView *)view
{
    if(!self.contentCreated)
    {
        [self createSceneContents];
        [self setContentCreated:YES];
    }
}

-(void)createSceneContents
{
    self.backgroundColor=[SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    if(-40<0)
    {
        NSLog(@"yes");
    }
    isPawnTouched=NO;
    isThisMovePossible=NO;
    shouldLocationChange=YES;
    selectedPawn=[[SKSpriteNode alloc]init];
    boardPawnPoints=[[NSMutableArray alloc]init];
    for(NSInteger i=0;i<33;i++)
    {
        [boardPawnPoints addObject:@YES];
    }
    boardPawnPoints[16]=@NO;
    //To Access BOOL Values use : [boardPawnPoints[0] boolValue];
    
    
    SKSpriteNode *board=[self createBoardNode];
    [board setName:@"board"];
    
    NSMutableDictionary *rays=[self createStaticRays];
    
    [board addChild:[rays objectForKey:@"h1"]];
    [board addChild:[rays objectForKey:@"h2"]];
    [board addChild:[rays objectForKey:@"h3"]];
    [board addChild:[rays objectForKey:@"v1"]];
    [board addChild:[rays objectForKey:@"v2"]];
    [board addChild:[rays objectForKey:@"v3"]];
    
    NSArray *pawnPositions=[self boardPawnPointsCoordinates];
    
    for (NSInteger i=0;i<[pawnPositions count];i++)
    {
        if(!([pawnPositions[i] CGPointValue].x==0 && [pawnPositions[i] CGPointValue].y==0))
        {
            SKSpriteNode *pawn=[self createPawn];
            [pawn setName:@"pawn"];
            [pawn setPosition:[pawnPositions[i] CGPointValue]];
            [board addChild:pawn];
        }
        
    }
    
    [self addChild:board];
}

#pragma mark - Touch Events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"selectedPawn.position = X:%f Y:%f",selectedPawn.position.x,selectedPawn.position.y);
    for (UITouch *touch in touches)
    {
        touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
        
        if([[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].name isEqualToString:@"pawn"])
        {
        
            selectedPawn=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation];
            selectedPawnZPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].zPosition;
            selectedPawnLastPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].position;
            pickupPoint=[self findPickupPointOfSelectedPawn:selectedPawnLastPosition inCoordinates:[self boardPawnPointsCoordinates]];
            [selectedPawn setZPosition:500];
            [selectedPawn setScale:3.0];
            isPawnTouched=YES;
            shouldLocationChange=YES;
        }
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"selectedPawn.position = X:%f Y:%f",selectedPawn.position.x,selectedPawn.position.y);
    for (UITouch *touch in touches)
    {
        touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
        shouldLocationChange=YES;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"selectedPawn.position = X:%f Y:%f",selectedPawn.position.x,selectedPawn.position.y);
    if(isPawnTouched)
    {
        [selectedPawn setZPosition:selectedPawnZPosition];
        [selectedPawn setScale:1.0];
        NSInteger positionIndex;
        positionIndex=[self findDropPoint:selectedPawn.position compareIn:[self boardPawnPointsCoordinates] withX:[self boardMinX] andY:[self boardMinY]];
        
        NSLog(@"%ld",(long)positionIndex);
        if (positionIndex!=-1 && ![boardPawnPoints[positionIndex] boolValue])
        {
            NSArray *possibleBoardPawnPoints=[self boardPawnPointsCoordinates];
            SKAction *hareketEttir=[SKAction moveTo:[possibleBoardPawnPoints[positionIndex] CGPointValue] duration:0.1];
            [selectedPawn runAction:hareketEttir completion:^{
                shouldLocationChange=NO;
                boardPawnPoints[pickupPoint]=@NO;
                boardPawnPoints[positionIndex]=@YES;
            }];
        }
        else
        {
            SKAction *hareketEttir=[SKAction moveTo:selectedPawnLastPosition duration:0.1];
            [selectedPawn runAction:hareketEttir completion:^{
                shouldLocationChange=NO;
            }];
        }
    }
    
    isPawnTouched=NO;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"selectedPawn.position = X:%f Y:%f",selectedPawn.position.x,selectedPawn.position.y);
    if(isPawnTouched)
    {
        [selectedPawn setZPosition:selectedPawnZPosition];
        [selectedPawn setScale:1.0];
        NSInteger positionIndex;
        positionIndex=[self findDropPoint:selectedPawn.position compareIn:[self boardPawnPointsCoordinates] withX:[self boardMinX] andY:[self boardMinY]];
        
        NSLog(@"%ld",(long)positionIndex);
        if (positionIndex!=-1 && ![boardPawnPoints[positionIndex] boolValue])
        {
            NSArray *possibleBoardPawnPoints=[self boardPawnPointsCoordinates];
            SKAction *hareketEttir=[SKAction moveTo:[possibleBoardPawnPoints[positionIndex] CGPointValue] duration:0.1];
            [selectedPawn runAction:hareketEttir completion:^{
                shouldLocationChange=NO;
                boardPawnPoints[pickupPoint]=@NO;
                boardPawnPoints[positionIndex]=@YES;
            }];
        }
        else
        {
            SKAction *hareketEttir=[SKAction moveTo:selectedPawnLastPosition duration:0.1];
            [selectedPawn runAction:hareketEttir completion:^{
                shouldLocationChange=NO;
            }];
        }
    }
    
    isPawnTouched=NO;
}

#pragma mark - Creating Game Assets

-(SKSpriteNode *)createBoardNode
{
    SKSpriteNode *board=[[SKSpriteNode alloc]initWithColor:[SKColor clearColor] size:CGSizeMake(self.boardMaxWidth, self.boardMaxHeight)];
    [board setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    return board;
}

-(NSMutableDictionary *)createStaticRays
{
    NSMutableDictionary *rays=[[NSMutableDictionary alloc]init];
    CGPoint rayPosition;
    
    //Horizontal Rays
    
    SKSpriteNode *rayH1=[[SKSpriteNode alloc]
                       initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                       color:[SKColor clearColor]
                       size:CGSizeMake(self.hRayWidth, self.hRayHeight)];
    rayPosition=[[[self boardPawnPointsCoordinates]objectAtIndex:23]CGPointValue];
    [rayH1 setPosition:rayPosition];
    
    SKSpriteNode *rayH2=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                         color:[SKColor clearColor]
                         size:CGSizeMake(self.hRayWidth, self.hRayHeight)];
    rayPosition=[[[self boardPawnPointsCoordinates]objectAtIndex:16]CGPointValue];
    [rayH2 setPosition:rayPosition];
    
    SKSpriteNode *rayH3=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                         color:[SKColor clearColor]
                         size:CGSizeMake(self.hRayWidth, self.hRayHeight)];
    rayPosition=[[[self boardPawnPointsCoordinates]objectAtIndex:9]CGPointValue];
    [rayH3 setPosition:rayPosition];
    
    //Verticle Rays
    
    SKSpriteNode *rayV1=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerV"]
                         color:[SKColor clearColor]
                         size:CGSizeMake(self.vRayWidth, self.vRayHeight)];
    rayPosition=[[[self boardPawnPointsCoordinates]objectAtIndex:15]CGPointValue];
    [rayV1 setPosition:rayPosition];
    
    SKSpriteNode *rayV2=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerV"]
                         color:[SKColor clearColor]
                         size:CGSizeMake(self.vRayWidth, self.vRayHeight)];
    rayPosition=[[[self boardPawnPointsCoordinates]objectAtIndex:16]CGPointValue];
    [rayV2 setPosition:rayPosition];
    
    SKSpriteNode *rayV3=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerV"]
                         color:[SKColor clearColor]
                         size:CGSizeMake(self.vRayWidth, self.vRayHeight)];
    rayPosition=[[[self boardPawnPointsCoordinates]objectAtIndex:17]CGPointValue];
    [rayV3 setPosition:rayPosition];
    
    [rays setObject:rayH1 forKey:@"h1"];
    [rays setObject:rayH2 forKey:@"h2"];
    [rays setObject:rayH3 forKey:@"h3"];
    [rays setObject:rayV1 forKey:@"v1"];
    [rays setObject:rayV2 forKey:@"v2"];
    [rays setObject:rayV3 forKey:@"v3"];
    
    return rays;
}

-(SKSpriteNode *)createPawn
{
    SKSpriteNode *pawn=[[SKSpriteNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"siyahPiyon"] color:[SKColor clearColor] size:CGSizeMake(self.pawnWidth, self.pawnHeight)];
    return pawn;
}

#pragma mark - Dimension and Position Calculations

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

-(CGFloat)boardMaxWidth
{
    return CGRectGetWidth(self.frame);
}

-(CGFloat)boardMaxHeight
{
    return CGRectGetWidth(self.frame);
}

-(CGFloat)boardMinX
{
    return (CGRectGetWidth(self.frame)/8);
}

-(CGFloat)boardMinY
{
    return (CGRectGetWidth(self.frame)/8);
}

-(CGFloat)pawnHeight
{
    return self.boardMaxHeight/10;
}

-(CGFloat)pawnWidth
{
    return self.boardMaxWidth/10;
}

-(NSArray *)boardPawnPointsCoordinates
{
    CGFloat minX=self.boardMinX;
    CGFloat minY=self.boardMinY;
    //origin=0,0
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

//returns boardPawnPoints[index]'s index or -1 if it fails
-(NSInteger)findDropPoint:(CGPoint)lastPositionWhenTouchEnded compareIn:(NSArray *)boardPawnPointsCoordinates withX:(CGFloat)minX andY:(CGFloat)minY
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

#pragma mark - Game Logic

-(NSArray *)possibleMovements
{
    NSArray *possibleMovementsArray=@[@[@1,@2,@3],
                                      @[@1,@4,@9],
                                      @[@2,@5,@10],
                                      @[@3,@7,@1],
                                      @[@3,@6,@11],
                                      @[@4,@5,@6],
                                      @[@4,@9,@16],
                                      @[@5,@10,@17],
                                      @[@6,@5,@4],
                                      @[@6,@11,@18],
                                      @[@7,@8,@9],
                                      @[@7,@14,@21],
                                      @[@8,@9,@10],
                                      @[@8,@15,@22],
                                      @[@9,@4,@1],
                                      @[@9,@8,@7],
                                      @[@9,@16,@23],
                                      @[@9,@10,@11],
                                      @[@10,@17,@24],
                                      @[@10,@5,@2],
                                      @[@10,@9,@8],
                                      @[@10,@11,@12],
                                      @[@11,@6,@3],
                                      @[@11,@10,@9],
                                      @[@11,@12,@13],
                                      @[@11,@18,@25],
                                      @[@12,@11,@10],
                                      @[@12,@19,@26],
                                      @[@13,@12,@11],
                                      @[@13,@20,@27],
                                      @[@14,@15,@16],
                                      @[@15,@16,@17],
                                      @[@16,@15,@14],
                                      @[@16,@9,@4],
                                      @[@16,@17,@18],
                                      @[@16,@23,@28],
                                      @[@17,@16,@15],
                                      @[@17,@10,@5],
                                      @[@17,@18,@19],
                                      @[@17,@24,@29],
                                      @[@18,@17,@16],
                                      @[@18,@11,@6],
                                      @[@18,@19,@20],
                                      @[@18,@25,@30],
                                      @[@19,@18,@17],
                                      @[@20,@19,@18],
                                      @[@21,@14,@7],
                                      @[@21,@22,@23],
                                      @[@22,@15,@8],
                                      @[@22,@23,@24],
                                      @[@23,@22,@21],
                                      @[@23,@16,@9],
                                      @[@23,@24,@25],
                                      @[@23,@28,@31],
                                      @[@24,@23,@22],
                                      @[@24,@17,@10],
                                      @[@24,@29,@32],
                                      @[@24,@25,@26],
                                      @[@25,@24,@23],
                                      @[@25,@18,@11],
                                      @[@25,@26,@27],
                                      @[@25,@30,@33],
                                      @[@26,@19,@12],
                                      @[@26,@25,@24],
                                      @[@27,@20,@13],
                                      @[@27,@26,@25],
                                      @[@28,@23,@16],
                                      @[@28,@29,@30],
                                      @[@29,@24,@17],
                                      @[@30,@29,@28],
                                      @[@30,@25,@18],
                                      @[@31,@28,@23],
                                      @[@31,@32,@33],
                                      @[@32,@29,@24],
                                      @[@33,@32,@31],
                                      @[@33,@30,@25]];
    return possibleMovementsArray;
}

-(BOOL)isThereAnyMovementsLeftIn:(NSArray *)pawnPoints withPossibleMovements:(NSArray *)possibleMovements
{
    for(NSInteger i=0;i<[possibleMovements count];i++)
    {
        NSArray *movementRule=possibleMovements[i];
        if(([[pawnPoints objectAtIndex:[[movementRule objectAtIndex:0] integerValue]] boolValue]) &&
           ([[pawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue]) &&
           !([[pawnPoints objectAtIndex:[[movementRule objectAtIndex:2] integerValue]] boolValue]))
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)isThisMovePossibleFrom:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint in:(NSArray *)possibleMovements coordinates:(NSMutableArray *)theBoardPawnPoints
{
    if([[theBoardPawnPoints objectAtIndex:theDropPoint] boolValue])
    {
        return NO;
    }
    
    for(NSInteger i=0;i<[possibleMovements count];i++)
    {
        NSArray *movementRule=[possibleMovements objectAtIndex:i];
        if(theSelectedPawn == [[movementRule objectAtIndex:0] integerValue] &&
           [theBoardPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] boolValue]] &&
           theDropPoint == [[movementRule objectAtIndex:2] integerValue])
        {
            return YES;
        }
    }
    
    return NO;
}

-(NSInteger)numberOfRemainingPawnsIn:(NSMutableArray *)theBoardPawnPoints
{
    NSUInteger remainingPawns=0;
    for (id isExists in theBoardPawnPoints)
    {
        if([isExists boolValue])
        {
            remainingPawns++;
        }
    }
    
    return remainingPawns;
}

#pragma mark - Update

-(void)update:(NSTimeInterval)currentTime
{
    if(shouldLocationChange&&isPawnTouched)
    {
        SKAction *hareketEttir=[SKAction moveTo:touchLocation duration:0.1];
        [selectedPawn runAction:hareketEttir completion:^{
            shouldLocationChange=NO;
        }];
    }
}

@end
