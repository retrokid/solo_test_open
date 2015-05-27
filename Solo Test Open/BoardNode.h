//
//  BoardNode.h
//  Solo Test Open
//
//  Created by efe ertugrul on 25/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BoardNode : SKSpriteNode
{
    NSArray *pawnPointsCoordinates;
    NSMutableArray *currentPawnPoints;
    NSArray *possibleMovements;
}

@property NSUInteger numberOfPawnPoints;

//init
-(id)initFromFrame:(CGRect)theFrame;

//getter setters
-(void)setPawnPointsCoordinates:(CGRect)theFrame;
-(NSArray *)pawnPointsCoordinates;
-(void)setCurrentPawnPoints;
-(NSMutableArray *)currentPawnPoints;
-(void)setPossibleMovements;
-(NSArray *)possibleMovements;

//game methods
-(NSInteger)numberOfRemainingPawnsOnBoard;
-(BOOL)isThereAnyMovementsLeft;
-(BOOL)isThisMovePossibleFromPointOf:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint;
-(NSInteger)findRemovePointOfPawn:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint;
-(NSInteger)findDropPointOfSelectedPawnWithLocation:(CGPoint)lastPositionWhenTouchEnded andPawnSize:(CGSize)thePawnSize;
-(NSInteger)findPickupPointOfSelectedPawnWithSelectedPawnLastPosition:(CGPoint)selectedPawnPosition;

@end
