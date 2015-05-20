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

//TheLogger() legend
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
    if(!self.contentCreated)
    {
        [self createSceneContents];
        [self setContentCreated:YES];
    }
}

-(void)createSceneContents
{
    gameAssets=[[GameAssets alloc]init];
    gameLogic=[[GameLogic alloc]init];
    geoCalculations=[[GeoCalc alloc]initWithSceneFrame:self.frame];
    
    self.backgroundColor=[SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;

    isPawnTouched=NO;
    isThisMovePossible=NO;
    shouldLocationChange=YES;
    
    selectedPawn=[[SKSpriteNode alloc]init];
    
    //To Access BOOL Values use : [boardPawnPoints[0] boolValue];
    boardPawnPoints=[gameLogic boardPawnPoints];
    
    board=[gameAssets createBoardNodeFromFrame:self.frame andSize:[geoCalculations boardSize]];
    [board setName:@"board"];
    
    rays=[gameAssets createStaticRaysWithHSize:[geoCalculations HSize] andVSize:[geoCalculations VSize] andBoardPawnPointsCoordinates:[geoCalculations boardPawnPointsCoordinates]];
    
    
    [board addChild:[rays objectForKey:@"h1"]];
    [board addChild:[rays objectForKey:@"h2"]];
    [board addChild:[rays objectForKey:@"h3"]];
    [board addChild:[rays objectForKey:@"v1"]];
    [board addChild:[rays objectForKey:@"v2"]];
    [board addChild:[rays objectForKey:@"v3"]];
    
    boardPawnPointsCoordinates=[geoCalculations boardPawnPointsCoordinates];
    
    for (NSInteger i=0;i<[boardPawnPointsCoordinates count];i++)
    {
        if(!([boardPawnPointsCoordinates[i] CGPointValue].x==0 && [boardPawnPointsCoordinates[i] CGPointValue].y==0))
        {
            //ToDo create nodes
            SKSpriteNode *pawn=[gameAssets createPawnWithSize:[geoCalculations pawnSize]];
            [pawn setName:@"pawn"];
            [pawn setPosition:[boardPawnPointsCoordinates[i] CGPointValue]];
            [board addChild:pawn];
        }
        
    }
    
    [self addChild:board];
}

#pragma mark - Touch Events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
        
        if([[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].name isEqualToString:@"pawn"])
        {
        
            selectedPawn=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation];
            selectedPawnZPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].zPosition;
            selectedPawnLastPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].position;
            pickupPoint=[geoCalculations findPickupPointOfSelectedPawn:selectedPawnLastPosition inCoordinates:boardPawnPointsCoordinates];
            [selectedPawn setZPosition:500];
            [selectedPawn setScale:3.0];
            isPawnTouched=YES;
            shouldLocationChange=YES;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
        shouldLocationChange=YES;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isPawnTouched)
    {
        [selectedPawn setZPosition:selectedPawnZPosition];
        [selectedPawn setScale:1.0];
    
        dropPoint=[geoCalculations findDropPointOfSelectedPawn:selectedPawn.position inCoordinates:boardPawnPointsCoordinates];

        if (dropPoint!=-1 && ![boardPawnPoints[dropPoint] boolValue])
        {
            SKAction *hareketEttir=[SKAction moveTo:[boardPawnPointsCoordinates[dropPoint] CGPointValue] duration:0.1];
            [selectedPawn runAction:hareketEttir completion:^{
                shouldLocationChange=NO;
                boardPawnPoints[pickupPoint]=@NO;
                boardPawnPoints[dropPoint]=@YES;
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
    if(isPawnTouched)
    {
        [selectedPawn setZPosition:selectedPawnZPosition];
        [selectedPawn setScale:1.0];
        
        dropPoint=[geoCalculations findDropPointOfSelectedPawn:selectedPawn.position inCoordinates:boardPawnPointsCoordinates];
        
        if (dropPoint!=-1 && ![boardPawnPoints[dropPoint] boolValue])
        {
            SKAction *hareketEttir=[SKAction moveTo:[boardPawnPointsCoordinates[dropPoint] CGPointValue] duration:0.1];
            [selectedPawn runAction:hareketEttir completion:^{
                shouldLocationChange=NO;
                boardPawnPoints[pickupPoint]=@NO;
                boardPawnPoints[dropPoint]=@YES;
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

#pragma mark - Scene Actions

-(void)removePawnAtPosition:(CGPoint)position
{
    [[[self childNodeWithName:@"board"]nodeAtPoint:position]removeFromParent];
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
