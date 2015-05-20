//
//  GameAssets.m
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
//TheLogger() legend
//positive ✅ TheLogger(@"✅ SUCCESS");
//negative ⛔️ TheLogger(@"⛔️ FAIL");
//routine info 🔵 TheLogger(@"🔵 CALLED");
//value info ⚪️ TheLogger(@"⚪️ output=%f",var);

#import "GameAssets.h"

#define TheLogger(s, ...) NSLog(@"<%@> -%@ Line:%d | %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], NSStringFromSelector(_cmd), __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__])

@implementation GameAssets


-(SKSpriteNode *)createBoardNodeFromFrame:(CGRect)theFrame andSize:(CGSize)theSize
{
    SKSpriteNode *board=[[SKSpriteNode alloc]initWithColor:[SKColor clearColor] size:theSize];
    [board setPosition:CGPointMake(CGRectGetMidX(theFrame), CGRectGetMidY(theFrame))];
    return board;
}


-(NSMutableDictionary *)createStaticRaysWithHSize:(CGSize)HSize andVSize:(CGSize)VSize andBoardPawnPointsCoordinates:(NSArray *)theBoardPawnPointsCoordinates
{
    NSMutableDictionary *rays=[[NSMutableDictionary alloc]init];
    CGPoint rayPosition;
    
    //Horizontal Rays
    SKSpriteNode *rayH1=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                         color:[SKColor clearColor]
                         size:HSize];
    rayPosition=[[theBoardPawnPointsCoordinates objectAtIndex:23]CGPointValue];
    [rayH1 setPosition:rayPosition];
    
    SKSpriteNode *rayH2=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                         color:[SKColor clearColor]
                         size:HSize];
    rayPosition=[[theBoardPawnPointsCoordinates objectAtIndex:16]CGPointValue];
    [rayH2 setPosition:rayPosition];
    
    SKSpriteNode *rayH3=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerH"]
                         color:[SKColor clearColor]
                         size:HSize];
    rayPosition=[[theBoardPawnPointsCoordinates objectAtIndex:9]CGPointValue];
    [rayH3 setPosition:rayPosition];
    
    //Verticle Rays
    SKSpriteNode *rayV1=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerV"]
                         color:[SKColor clearColor]
                         size:VSize];
    rayPosition=[[theBoardPawnPointsCoordinates objectAtIndex:15]CGPointValue];
    [rayV1 setPosition:rayPosition];
    
    SKSpriteNode *rayV2=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerV"]
                         color:[SKColor clearColor]
                         size:VSize];
    rayPosition=[[theBoardPawnPointsCoordinates objectAtIndex:16]CGPointValue];
    [rayV2 setPosition:rayPosition];
    
    SKSpriteNode *rayV3=[[SKSpriteNode alloc]
                         initWithTexture:[SKTexture textureWithImageNamed:@"siyahLazerV"]
                         color:[SKColor clearColor]
                         size:VSize];
    rayPosition=[[theBoardPawnPointsCoordinates objectAtIndex:17]CGPointValue];
    [rayV3 setPosition:rayPosition];
    
    [rays setObject:rayH1 forKey:@"h1"];
    [rays setObject:rayH2 forKey:@"h2"];
    [rays setObject:rayH3 forKey:@"h3"];
    [rays setObject:rayV1 forKey:@"v1"];
    [rays setObject:rayV2 forKey:@"v2"];
    [rays setObject:rayV3 forKey:@"v3"];
    
    return rays;
}

-(SKSpriteNode *)createPawnWithSize:(CGSize)pawnSize
{
    SKSpriteNode *pawn=[[SKSpriteNode alloc]initWithTexture:[SKTexture textureWithImageNamed:@"siyahPiyon"] color:[SKColor clearColor] size:pawnSize];
    return pawn;
}

@end
