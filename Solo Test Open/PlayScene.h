//
//  PlayScene.h
//  Solo Test Open
//
//  Created by efe ertugrul on 18/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "PawnNode.h"
#import "BoardNode.h"
#import "VRayNode.h"
#import "HRayNode.h"

@interface PlayScene : SKScene
{
    BOOL isPawnTouched;
    BOOL isThisMovePossible;
    BOOL shouldLocationChange;
    BOOL startupActionsAnimating;
    
    CGPoint touchLocation;
    
    SKNode *selectedPawn;
    CGFloat selectedPawnZPosition;
    CGPoint selectedPawnLastPosition;
    
    NSInteger pickupPoint;
    NSInteger dropPoint;
    NSInteger removePoint;

    BoardNode *board;
    NSMutableDictionary *rays;
    NSMutableArray *pawns;
    
    SKLabelNode *alertLabel;
    SKLabelNode *scoreLabel;
}

-(void)createSceneContents;
-(void)removePawnAtPosition:(CGPoint)position;

@end
