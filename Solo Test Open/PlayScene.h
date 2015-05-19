//
//  PlayScene.h
//  Solo Test Open
//
//  Created by efe ertugrul on 18/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PlayScene : SKScene
{
    BOOL isPawnTouched;
    BOOL isThisMovePossible;
    BOOL shouldLocationChange;
    CGPoint touchLocation;
    SKNode *selectedPawn;
    CGFloat selectedPawnZPosition;
    CGPoint selectedPawnLastPosition;
    NSMutableArray *boardPawnPoints;
    NSInteger pickupPoint;
}

-(void)createSceneContents;
-(CGFloat)boardMaxWidth;
-(CGFloat)boardMaxHeight;
-(SKSpriteNode *)createBoardNode;

@end
