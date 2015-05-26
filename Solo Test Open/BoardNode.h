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
}

@property NSUInteger numberOfPawnPoints;

//init
- (id)initFromFrame:(CGRect)theFrame;

//getter setters
-(void)setPawnPointsCoordinates:(CGRect)theFrame;
-(NSArray *)pawnPointsCoordinates;


@end
