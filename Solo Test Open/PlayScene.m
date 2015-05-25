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

//TheLogger() marks
//positive ✅ TheLogger(@"✅ SUCCESS");
//negative ⛔️ TheLogger(@"⛔️ FAIL");
//routine info 🔵 TheLogger(@"🔵 CALLED");
//value info ⚪️ TheLogger(@"⚪️ output=%f",var);

#import "PlayScene.h"
#define TheLogger(s, ...) NSLog(@"<%@> -%@ Line:%d | %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], NSStringFromSelector(_cmd), __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__])
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
    TheLogger(@"🔵 CALLED");
    if(!self.contentCreated)
    {
        [self createSceneContents];
        [self setContentCreated:YES];
    }
}

-(void)createSceneContents
{
    TheLogger(@"🔵 CALLED");
    pawns=[[NSMutableArray alloc]init];
    gameAssets=[[GameAssets alloc]init];
    gameLogic=[[GameLogic alloc]init];
    geoCalculations=[[GeoCalc alloc]initWithSceneFrame:self.frame];
    
    possibleMovements=[gameLogic possibleMovements];
    
    self.backgroundColor=[SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;

    isPawnTouched=NO;
    isThisMovePossible=NO;
    shouldLocationChange=YES;
    
    selectedPawn=[[SKSpriteNode alloc]init];
    boardPawnPoints=[gameLogic boardPawnPoints];

    board=[gameAssets createBoardNodeFromFrame:self.frame andSize:geoCalculations.boardSize];
    [board setName:@"board"];
    
    rays=[gameAssets createStaticRaysWithHSize:geoCalculations.HSize andVSize:geoCalculations.VSize andBoardPawnPointsCoordinates:geoCalculations.boardPawnPointsCoordinates];
    
    CGFloat startupH1XPosition;
    CGFloat startupH1YPosition;
    CGFloat startupH2XPosition;
    CGFloat startupH2YPosition;
    CGFloat startupH3XPosition;
    CGFloat startupH3YPosition;
    
    CGFloat startupV1XPosition;
    CGFloat startupV1YPosition;
    CGFloat startupV2XPosition;
    CGFloat startupV2YPosition;
    CGFloat startupV3XPosition;
    CGFloat startupV3YPosition;
    
    startupH1XPosition=[[rays objectForKey:@"h1"]position].x-[self frame].size.width;
    startupH1YPosition=[[rays objectForKey:@"h1"]position].y;
    [[rays objectForKey:@"h1"] setPosition:CGPointMake(startupH1XPosition, startupH1YPosition)];
    
    startupH2XPosition=[[rays objectForKey:@"h2"]position].x+[self frame].size.width;
    startupH2YPosition=[[rays objectForKey:@"h2"]position].y;
    [[rays objectForKey:@"h2"] setPosition:CGPointMake(startupH2XPosition, startupH2YPosition)];
    
    startupH3XPosition=[[rays objectForKey:@"h3"]position].x-[self frame].size.width;
    startupH3YPosition=[[rays objectForKey:@"h3"]position].y;
    [[rays objectForKey:@"h3"] setPosition:CGPointMake(startupH3XPosition, startupH3YPosition)];
    
    startupV1XPosition=[[rays objectForKey:@"v1"]position].x;
    startupV1YPosition=[[rays objectForKey:@"v1"]position].y-[self frame].size.height;
    [[rays objectForKey:@"v1"] setPosition:CGPointMake(startupV1XPosition, startupV1YPosition)];
    
    startupV2XPosition=[[rays objectForKey:@"v2"]position].x;
    startupV2YPosition=[[rays objectForKey:@"v2"]position].y+[self frame].size.height;
    [[rays objectForKey:@"v2"] setPosition:CGPointMake(startupV2XPosition, startupV2YPosition)];
    
    startupV3XPosition=[[rays objectForKey:@"v3"]position].x;
    startupV3YPosition=[[rays objectForKey:@"v3"]position].y-[self frame].size.height;
    [[rays objectForKey:@"v3"] setPosition:CGPointMake(startupV3XPosition, startupV3YPosition)];
    
    [board addChild:[rays objectForKey:@"h1"]];
    [board addChild:[rays objectForKey:@"h2"]];
    [board addChild:[rays objectForKey:@"h3"]];
    [board addChild:[rays objectForKey:@"v1"]];
    [board addChild:[rays objectForKey:@"v2"]];
    [board addChild:[rays objectForKey:@"v3"]];
    
    boardPawnPointsCoordinates=[geoCalculations boardPawnPointsCoordinates];
    
    CGPoint pawnStartupPosition=CGPointMake(0-[geoCalculations boardMaxWidth], 0);
    
    for (NSInteger i=0;i<[boardPawnPointsCoordinates count];i++)
    {
        if(!([boardPawnPointsCoordinates[i] CGPointValue].x==0 && [boardPawnPointsCoordinates[i] CGPointValue].y==0))
        {
            SKSpriteNode *pawn=[gameAssets createPawnWithSize:[geoCalculations pawnSize]];
            [pawn setName:@"pawn"];
            //[pawn setPosition:[boardPawnPointsCoordinates[i] CGPointValue]];
            [pawn setPosition:pawnStartupPosition];
            [pawns addObject:pawn];
            [board addChild:pawn];
        }
        
    }
    
    [self addChild:board];
    
    SKLabelNode *resetButton=[[SKLabelNode alloc]init];
    [resetButton setText:@"RESET"];
    [resetButton setColor:[SKColor whiteColor]];
    [resetButton setPosition:CGPointMake(CGRectGetMaxX([self frame])-resetButton.frame.size.width, CGRectGetMaxY([self frame])-resetButton.frame.size.height*2)];
    [resetButton setName:@"reset"];
    [self addChild:resetButton];
    
    for(NSInteger i=0,isOrigin=0;i<[boardPawnPointsCoordinates count];i++)
    {
        if(!([boardPawnPointsCoordinates[i]CGPointValue].y==0 && [boardPawnPointsCoordinates[i]CGPointValue].x==0))
        {
            if(isOrigin==1)
            {
                [pawns[i-1] runAction:[SKAction moveTo:[boardPawnPointsCoordinates[i] CGPointValue] duration:0.7]];
            }
            else
            {
                [pawns[i] runAction:[SKAction moveTo:[boardPawnPointsCoordinates[i] CGPointValue] duration:0.7]];
            }
        }
        else
        {
            isOrigin=1;
        }
    }
    [[rays objectForKey:@"h1"] runAction:[SKAction moveTo:CGPointMake(startupH1XPosition+[self frame].size.width, startupH1YPosition) duration:0.7]];
    [[rays objectForKey:@"h2"] runAction:[SKAction moveTo:CGPointMake(startupH2XPosition-[self frame].size.width, startupH2YPosition) duration:0.7]];
    [[rays objectForKey:@"h3"] runAction:[SKAction moveTo:CGPointMake(startupH3XPosition+[self frame].size.width, startupH3YPosition) duration:0.7]];
    
    [[rays objectForKey:@"v1"] runAction:[SKAction moveTo:CGPointMake(startupV1XPosition, startupV1YPosition+[self frame].size.height) duration:0.7]];
    [[rays objectForKey:@"v2"] runAction:[SKAction moveTo:CGPointMake(startupV2XPosition, startupV2YPosition-[self frame].size.height) duration:0.7]];
    [[rays objectForKey:@"v3"] runAction:[SKAction moveTo:CGPointMake(startupV3XPosition, startupV3YPosition+[self frame].size.height) duration:0.7]];
}

#pragma mark - Touch Events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        if([[self nodeAtPoint:[touch locationInNode:self]].name isEqualToString:@"reset"])
        {
            [self resetScene];
            
        }
        
    }
    TheLogger(@"🔵 CALLED");
    if(!isPawnTouched)
    {
        TheLogger(@"no pawn touched yet ✅ SUCCESS");
        for (UITouch *touch in touches)
        {
            touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
            
            if([[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].name isEqualToString:@"pawn"])
            {
                TheLogger(@"pawn touch ✅ SUCCESS");
                selectedPawn=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation];
                selectedPawnZPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].zPosition;
                selectedPawnLastPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].position;
                pickupPoint=[geoCalculations findPickupPointOfSelectedPawn:selectedPawnLastPosition inCoordinates:boardPawnPointsCoordinates];
                [selectedPawn setZPosition:500];
                [selectedPawn setScale:2.0];
                isPawnTouched=YES;
                shouldLocationChange=YES;
            }
            else
            {
                TheLogger(@"pawn touch ⛔️ FAIL");
            }
        }
    }
    else
    {
        TheLogger(@"a pawn is already touched ⛔️ FAIL");
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    TheLogger(@"🔵 CALLED");
    for (UITouch *touch in touches)
    {
        touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
        shouldLocationChange=YES;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    TheLogger(@"🔵 CALLED");
    if(isPawnTouched)
    {
        [selectedPawn setZPosition:selectedPawnZPosition];
        [selectedPawn setScale:1.0];
        
        dropPoint=[geoCalculations findDropPointOfSelectedPawn:selectedPawn.position inCoordinates:boardPawnPointsCoordinates];
        if (dropPoint!=-1)
        {
            TheLogger(@"pawn point is empty ✅ SUCCESS");
            removePoint=[gameLogic findRemovePointOfPawn:pickupPoint to:dropPoint inThe:possibleMovements coordinates:boardPawnPoints];
            
            if (dropPoint!=-1 && ![boardPawnPoints[dropPoint] boolValue] && removePoint!=-1)
            {
                TheLogger(@"move is possible ✅ SUCCESS");
                SKAction *hareketEttir=[SKAction moveTo:[boardPawnPointsCoordinates[dropPoint] CGPointValue] duration:0.1];
                [selectedPawn runAction:hareketEttir completion:^{
                    shouldLocationChange=NO;
                    [self removePawnAtPosition:[boardPawnPointsCoordinates[removePoint] CGPointValue]];
                    boardPawnPoints[pickupPoint]=@NO;
                    boardPawnPoints[removePoint]=@NO;
                    boardPawnPoints[dropPoint]=@YES;
                    if(![gameLogic isThereAnyMovementsLeftIn:boardPawnPoints compareWith:possibleMovements])
                    {
                        TheLogger(@"no more moves ⛔️ SUCCESS");
                        [gameLogic numberOfRemainingPawnsIn:boardPawnPoints];
                    }
                    else
                    {
                        TheLogger(@"there are more moves ✅ SUCCESS");
                        [gameLogic numberOfRemainingPawnsIn:boardPawnPoints];
                    }
                }];
            }
            else
            {
                TheLogger(@"pawn will return it's original position ⛔️ SUCCESS");
                SKAction *hareketEttir=[SKAction moveTo:selectedPawnLastPosition duration:0.1];
                [selectedPawn runAction:hareketEttir completion:^{
                    shouldLocationChange=NO;
                }];
            }
            
        }
        else
        {
            TheLogger(@"pawn will return it's original position ⛔️ SUCCESS");
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
    TheLogger(@"🔵 CALLED");
    if(isPawnTouched)
    {
        [selectedPawn setZPosition:selectedPawnZPosition];
        [selectedPawn setScale:1.0];
        
        dropPoint=[geoCalculations findDropPointOfSelectedPawn:selectedPawn.position inCoordinates:boardPawnPointsCoordinates];
        if (dropPoint!=-1)
        {
            TheLogger(@"pawn point is empty ✅ SUCCESS");
            removePoint=[gameLogic findRemovePointOfPawn:pickupPoint to:dropPoint inThe:possibleMovements coordinates:boardPawnPoints];
            
            if (dropPoint!=-1 && ![boardPawnPoints[dropPoint] boolValue] && removePoint!=-1)
            {
                TheLogger(@"move is possible ✅ SUCCESS");
                SKAction *hareketEttir=[SKAction moveTo:[boardPawnPointsCoordinates[dropPoint] CGPointValue] duration:0.1];
                [selectedPawn runAction:hareketEttir completion:^{
                    shouldLocationChange=NO;
                    [self removePawnAtPosition:[boardPawnPointsCoordinates[removePoint] CGPointValue]];
                    boardPawnPoints[pickupPoint]=@NO;
                    boardPawnPoints[removePoint]=@NO;
                    boardPawnPoints[dropPoint]=@YES;
                    if(![gameLogic isThereAnyMovementsLeftIn:boardPawnPoints compareWith:possibleMovements])
                    {
                        TheLogger(@"no more moves ✅ SUCCESS");
                        [gameLogic numberOfRemainingPawnsIn:boardPawnPoints];
                    }
                    else
                    {
                        TheLogger(@"there are more moves ✅ SUCCESS");
                        [gameLogic numberOfRemainingPawnsIn:boardPawnPoints];
                    }
                }];
            }
            else
            {
                TheLogger(@"pawn will return it's original position ✅ SUCCESS");
                SKAction *hareketEttir=[SKAction moveTo:selectedPawnLastPosition duration:0.1];
                [selectedPawn runAction:hareketEttir completion:^{
                    shouldLocationChange=NO;
                }];
            }
            
        }
        else
        {
            TheLogger(@"pawn will return it's original position ✅ SUCCESS");
            SKAction *hareketEttir=[SKAction moveTo:selectedPawnLastPosition duration:0.1];
            [selectedPawn runAction:hareketEttir completion:^{
                shouldLocationChange=NO;
            }];
        }
    }
    isPawnTouched=NO;
}

#pragma mark - SKActions

-(SKAction *)vRayStartup:(SKSpriteNode *)aVRay
{
    
    return [SKAction moveToY:aVRay.position.y duration:2];
}


#pragma mark - Scene Actions

-(void)removePawnAtPosition:(CGPoint)position
{
    TheLogger(@"🔵 CALLED");
    TheLogger(@"a pawn will remove ✅ SUCCESS");
    SKAction *shrinkPawn=[SKAction resizeToWidth:0 height:0 duration:0.5];
    SKAction *removePawn=[SKAction removeFromParent];
    [SKAction sequence:@[shrinkPawn,removePawn]];
    
    SKSpriteNode *nodeToRemove=(SKSpriteNode *)[[self childNodeWithName:@"board"]nodeAtPoint:position];
                                
     [nodeToRemove runAction:[SKAction sequence:@[shrinkPawn,removePawn]]];
    //[[[self childNodeWithName:@"board"]nodeAtPoint:position]removeFromParent];
}

-(void)resetScene
{
    if([self contentCreated])
    {
        [self removeAllActions];
        [self removeAllChildren];
        [self createSceneContents];
    }
    
}

#pragma mark - Update

-(void)update:(NSTimeInterval)currentTime
{
    if(shouldLocationChange&&isPawnTouched)
    {
        TheLogger(@"pawn is on the move ✅ SUCCESS");
        SKAction *hareketEttir=[SKAction moveTo:touchLocation duration:0.05];
        [selectedPawn runAction:hareketEttir completion:^{
            shouldLocationChange=NO;
        }];
    }
}

@end
