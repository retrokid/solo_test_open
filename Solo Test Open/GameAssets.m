//
//  GameAssets.m
//  Solo Test Open
//
//  Created by efe ertugrul on 20/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

//nslog characters
//positive ✅
//negative ⛔️
//routine info 🔵
//live info ⚪️

#import "GameAssets.h"

@implementation GameAssets

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

@end
