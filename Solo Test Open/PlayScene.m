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
//#define TheLogger(s, ...) NSLog(@"<%@> -%@ Line:%d | %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], NSStringFromSelector(_cmd), __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__])
//positive ✅ TheLogger(@"✅ SUCCESS");
//negative ⛔️ TheLogger(@"⛔️ FAIL");
//routine info 🔵 TheLogger(@"🔵 CALLED");
//value info ⚪️ TheLogger(@"⚪️ output=%f",var);

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

    isPawnTouched=NO;
    isThisMovePossible=NO;
    shouldLocationChange=YES;
    startupActionsAnimating=YES;
    [self setUserInteractionEnabled:NO];
    
    selectedPawn=[[SKNode alloc]init];

    board=[[BoardNode alloc]initFromFrame:self.frame];
    pawns=[[NSMutableArray alloc]init];
    rays=[[NSMutableDictionary alloc]init];
    
    rays=[self createRays];
    
    [[rays objectForKey:@"h1"] setPosition:[[rays objectForKey:@"h1"]startupPosition]];
    [[rays objectForKey:@"h2"] setPosition:[[rays objectForKey:@"h2"]startupPosition]];
    [[rays objectForKey:@"h3"] setPosition:[[rays objectForKey:@"h3"]startupPosition]];
    
    [[rays objectForKey:@"v1"] setPosition:[[rays objectForKey:@"v1"]startupPosition]];
    [[rays objectForKey:@"v2"] setPosition:[[rays objectForKey:@"v2"]startupPosition]];
    [[rays objectForKey:@"v3"] setPosition:[[rays objectForKey:@"v3"]startupPosition]];
    
    [board addChild:[rays objectForKey:@"h1"]];
    [board addChild:[rays objectForKey:@"h2"]];
    [board addChild:[rays objectForKey:@"h3"]];
    [board addChild:[rays objectForKey:@"v1"]];
    [board addChild:[rays objectForKey:@"v2"]];
    [board addChild:[rays objectForKey:@"v3"]];
    
    for (NSInteger i=0;i<[board numberOfPawnPoints];i++)
    {
        if(!([board.pawnPointsCoordinates[i] CGPointValue].x==0 &&
             [board.pawnPointsCoordinates[i] CGPointValue].y==0))
        {
            PawnNode *pawn=[[PawnNode alloc]
                                initWithBoardSize:board.size
                                andName:@"pawn"];
            [pawns addObject:pawn];
            [board addChild:pawn];
        }
    }
    
    [self addChild:board];
    
    //reset button
    SKLabelNode *resetButton=[[SKLabelNode alloc]init];
    [resetButton setText:@"RESET"];
    [resetButton setColor:[SKColor whiteColor]];
    [resetButton setPosition:CGPointMake(CGRectGetMaxX([self frame])-resetButton.frame.size.width/2, CGRectGetMaxY([self frame])-resetButton.frame.size.height)];
    [resetButton setName:@"reset"];
    [self addChild:resetButton];
    
    scoreLabel=[[SKLabelNode alloc]init];
    [scoreLabel setText:@"Pawn Left:32"];
    [scoreLabel setPosition:CGPointMake(CGRectGetMinX([self frame])+scoreLabel.frame.size.width/2, CGRectGetMaxY([self frame])-scoreLabel.frame.size.height)];
    [self addChild:scoreLabel];
    
    alertLabel=[[SKLabelNode alloc]init];
    [alertLabel setText:@"Move one over another"];
    [alertLabel setColor:[SKColor redColor]];
    [alertLabel setPosition:CGPointMake(CGRectGetMidX([self frame]),CGRectGetMinY([self frame])+alertLabel.frame.size.height)];
    [self addChild:alertLabel];
    
    //pawn animations
    for(NSInteger i=0,isOrigin=0;i<[board.pawnPointsCoordinates count];i++)
    {
        if(!([board.pawnPointsCoordinates[i]CGPointValue].y==0 && [board.pawnPointsCoordinates[i]CGPointValue].x==0))
        {
            if(isOrigin==1)
            {
                [pawns[i-1] runAction:[SKAction moveTo:[board.pawnPointsCoordinates[i] CGPointValue] duration:0.7]];
            }
            else
            {
                [pawns[i] runAction:[SKAction moveTo:[board.pawnPointsCoordinates[i] CGPointValue] duration:0.7]];
            }
        }
        else
        {
            isOrigin=1;
        }
    }
    [[rays objectForKey:@"h1"] runAction:[SKAction moveTo:CGPointMake([[rays objectForKey:@"h1"]startupPosition].x+[self frame].size.width, [[rays objectForKey:@"h1"]startupPosition].y) duration:0.7]];
    [[rays objectForKey:@"h2"] runAction:[SKAction moveTo:CGPointMake([[rays objectForKey:@"h2"]startupPosition].x-[self frame].size.width, [[rays objectForKey:@"h2"]startupPosition].y) duration:0.7]];
    [[rays objectForKey:@"h3"] runAction:[SKAction moveTo:CGPointMake([[rays objectForKey:@"h3"]startupPosition].x+[self frame].size.width, [[rays objectForKey:@"h3"]startupPosition].y) duration:0.7]];
    
    [[rays objectForKey:@"v1"] runAction:[SKAction moveTo:CGPointMake([[rays objectForKey:@"v1"]startupPosition].x, [[rays objectForKey:@"v1"]startupPosition].y+[self frame].size.height) duration:0.7]];
    [[rays objectForKey:@"v2"] runAction:[SKAction moveTo:CGPointMake([[rays objectForKey:@"v2"]startupPosition].x, [[rays objectForKey:@"v2"]startupPosition].y-[self frame].size.height) duration:0.7]];
    [[rays objectForKey:@"v3"] runAction:[SKAction moveTo:CGPointMake([[rays objectForKey:@"v3"]startupPosition].x, [[rays objectForKey:@"v3"]startupPosition].y+[self frame].size.height) duration:0.7]];
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
    if(!isPawnTouched)
    {
        for (UITouch *touch in touches)
        {
            touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
            
            if([[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].name isEqualToString:@"pawn"])
            {
                selectedPawn=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation];
                selectedPawnZPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].zPosition;
                selectedPawnLastPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].position;

                pickupPoint=[board findPickupPointOfSelectedPawnWithSelectedPawnLastPosition:selectedPawnLastPosition];
                [selectedPawn setZPosition:500];
                [selectedPawn setScale:2.0];
                
                 isPawnTouched=YES;
                shouldLocationChange=YES;
            }
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
        
        dropPoint=[board findDropPointOfSelectedPawnWithLocation:selectedPawn.position andPawnSize:[(SKSpriteNode *)selectedPawn size]];
        if (dropPoint!=-1)
        {
            removePoint=[board findRemovePointOfPawn:pickupPoint to:dropPoint];
            if (dropPoint!=-1 && ![board.currentPawnPoints[dropPoint] boolValue] && removePoint!=-1)
            {
                SKAction *hareketEttir=[SKAction moveTo:[board.pawnPointsCoordinates[dropPoint] CGPointValue] duration:0.1];
                
                [selectedPawn runAction:hareketEttir completion:^{
                    shouldLocationChange=NO;
                    [self removePawnAtPosition:[board.pawnPointsCoordinates[removePoint] CGPointValue]];
                    board.currentPawnPoints[pickupPoint]=@NO;
                    board.currentPawnPoints[removePoint]=@NO;
                    board.currentPawnPoints[dropPoint]=@YES;
                    if(![board isThereAnyMovementsLeft])
                    {
                        [scoreLabel setText:[NSString stringWithFormat:@"Pawn Left:%d",[board numberOfRemainingPawnsOnBoard]]];
                        [alertLabel setText:@"No More Moves!"];
                    }
                    else
                    {
                        [scoreLabel setText:[NSString stringWithFormat:@"Pawn Left:%d",[board numberOfRemainingPawnsOnBoard]]];
                    }
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
        
        dropPoint=[board findDropPointOfSelectedPawnWithLocation:selectedPawn.position andPawnSize:[(SKSpriteNode *)selectedPawn size]];
        if (dropPoint!=-1)
        {
            removePoint=[board findRemovePointOfPawn:pickupPoint to:dropPoint];
            if (dropPoint!=-1 && ![board.currentPawnPoints[dropPoint] boolValue] && removePoint!=-1)
            {
                SKAction *hareketEttir=[SKAction moveTo:[board.pawnPointsCoordinates[dropPoint] CGPointValue] duration:0.1];
                
                [selectedPawn runAction:hareketEttir completion:^{
                    shouldLocationChange=NO;
                    [self removePawnAtPosition:[board.pawnPointsCoordinates[removePoint] CGPointValue]];
                    board.currentPawnPoints[pickupPoint]=@NO;
                    board.currentPawnPoints[removePoint]=@NO;
                    board.currentPawnPoints[dropPoint]=@YES;
                    if(![board isThereAnyMovementsLeft])
                    {
                        [scoreLabel setText:[NSString stringWithFormat:@"Pawn Left:%d",[board numberOfRemainingPawnsOnBoard]]];
                        [alertLabel setText:@"No More Moves!"];
                    }
                    else
                    {
                        [scoreLabel setText:[NSString stringWithFormat:@"Pawn Left:%d",[board numberOfRemainingPawnsOnBoard]]];
                    }
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

#pragma mark - Scene Methods

-(void)removePawnAtPosition:(CGPoint)position
{
    SKAction *shrinkPawn=[SKAction resizeToWidth:0 height:0 duration:0.2];
    SKAction *removePawn=[SKAction removeFromParent];
    [SKAction sequence:@[shrinkPawn,removePawn]];
    
    SKSpriteNode *nodeToRemove=(SKSpriteNode *)[[self childNodeWithName:@"board"]nodeAtPoint:position];
                                
     [nodeToRemove runAction:[SKAction sequence:@[shrinkPawn,removePawn]]];
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

-(NSMutableDictionary *)createRays
{
    NSMutableDictionary *raysDictionary=[[NSMutableDictionary alloc]init];
    
    HRayNode *h1Ray=[[HRayNode alloc]initWithBoardSize:board.size name:@"h1" andPosition:[board.pawnPointsCoordinates[23] CGPointValue]];
    HRayNode *h2Ray=[[HRayNode alloc]initWithBoardSize:board.size name:@"h2" andPosition:[board.pawnPointsCoordinates[16] CGPointValue]];
    HRayNode *h3Ray=[[HRayNode alloc]initWithBoardSize:board.size name:@"h3" andPosition:[board.pawnPointsCoordinates[9] CGPointValue]];
    
    VRayNode *v1Ray=[[VRayNode alloc]initWithBoardSize:board.size name:@"v1" andPosition:[board.pawnPointsCoordinates[15] CGPointValue]];
    VRayNode *v2Ray=[[VRayNode alloc]initWithBoardSize:board.size name:@"v2" andPosition:[board.pawnPointsCoordinates[16] CGPointValue]];
    VRayNode *v3Ray=[[VRayNode alloc]initWithBoardSize:board.size name:@"v3" andPosition:[board.pawnPointsCoordinates[17] CGPointValue]];
    
    [h1Ray setStartupPosition:CGPointMake(h1Ray.position.x-[self frame].size.width, h1Ray.position.y)];
    [h2Ray setStartupPosition:CGPointMake(h2Ray.position.x+[self frame].size.width, h2Ray.position.y)];
    [h3Ray setStartupPosition:CGPointMake(h3Ray.position.x-[self frame].size.width, h3Ray.position.y)];
    
    [v1Ray setStartupPosition:CGPointMake(v1Ray.position.x, v1Ray.position.y-[self frame].size.height)];
    [v2Ray setStartupPosition:CGPointMake(v2Ray.position.x, v2Ray.position.y+[self frame].size.height)];
    [v3Ray setStartupPosition:CGPointMake(v3Ray.position.x, v3Ray.position.y-[self frame].size.height)];
    
    [raysDictionary setValue:h1Ray forKey:h1Ray.name];
    [raysDictionary setValue:h2Ray forKey:h2Ray.name];
    [raysDictionary setValue:h3Ray forKey:h3Ray.name];
    
    [raysDictionary setValue:v1Ray forKey:v1Ray.name];
    [raysDictionary setValue:v2Ray forKey:v2Ray.name];
    [raysDictionary setValue:v3Ray forKey:v3Ray.name];

    return raysDictionary;
}

#pragma mark - Update

-(void)update:(NSTimeInterval)currentTime
{
    if(![[rays valueForKey:@"h1"]hasActions])
    {
        [self setUserInteractionEnabled:YES];
    }
    else
    {
        [self setUserInteractionEnabled:NO];
    }
    
    if(shouldLocationChange&&isPawnTouched)
    {
        SKAction *hareketEttir=[SKAction moveTo:touchLocation duration:0.05];
        
        [selectedPawn runAction:hareketEttir completion:^{
            shouldLocationChange=NO;
        }];
         
    }
}

@end
