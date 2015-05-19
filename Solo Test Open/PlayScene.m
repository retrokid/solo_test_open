//
//  PlayScene.m
//  Solo Test Open
//
//  Created by efe ertugrul on 18/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

//commit
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
    for (UITouch *touch in touches)
    {
        touchLocation = [touch locationInNode:[self childNodeWithName:@"board"]];
        
        if([[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].name isEqualToString:@"pawn"])
        {
        
            selectedPawn=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation];
            selectedPawnZPosition=[[self childNodeWithName:@"board"]nodeAtPoint:touchLocation].zPosition;
            [selectedPawn setZPosition:500];
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
    isPawnTouched=NO;
    [selectedPawn setZPosition:selectedPawnZPosition];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    isPawnTouched=NO;
    [selectedPawn setZPosition:selectedPawnZPosition];
}

#pragma mark - Creating Game Assets

-(SKSpriteNode *)createBoardNode
{
    SKSpriteNode *board=[[SKSpriteNode alloc]initWithColor:[SKColor blueColor] size:CGSizeMake(self.boardMaxWidth, self.boardMaxHeight)];
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

-(NSInteger)findDropPoint:(CGPoint)lastPositionWhenTouchEnded compareIn:(NSArray *)boardPawnPointsCoordinates withX:(CGFloat)minX andY:(CGFloat)minY
{
    for(NSInteger i=0;i<[boardPawnPointsCoordinates count];i++)
    {
        CGPoint possiblePoint=[[boardPawnPointsCoordinates objectAtIndex:i]CGPointValue];
        //if((possiblePoint.x-minX > lastPositionWhenTouchEnded.x) && (possiblePoint.x + minX < lastPositionWhenTouchEnded.x) && (possiblePoint.y-minY > lastPositionWhenTouchEnded.y) && ()
    }
    return 0;
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
