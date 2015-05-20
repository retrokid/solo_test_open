//
//  GameLogic.m
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

#import "GameLogic.h"

@implementation GameLogic

#pragma mark - Game Logic

-(NSArray *)possibleMovements
{
    NSArray *possibleMovementsArray=@[@[@1,@2,@3],
                                      @[@1,@4,@9],
                                      @[@2,@5,@10],
                                      @[@3,@7,@1],
                                      @[@3,@6,@11],
                                      @[@4,@5,@6],
                                      @[@4,@9,@16],
                                      @[@5,@10,@17],
                                      @[@6,@5,@4],
                                      @[@6,@11,@18],
                                      @[@7,@8,@9],
                                      @[@7,@14,@21],
                                      @[@8,@9,@10],
                                      @[@8,@15,@22],
                                      @[@9,@4,@1],
                                      @[@9,@8,@7],
                                      @[@9,@16,@23],
                                      @[@9,@10,@11],
                                      @[@10,@17,@24],
                                      @[@10,@5,@2],
                                      @[@10,@9,@8],
                                      @[@10,@11,@12],
                                      @[@11,@6,@3],
                                      @[@11,@10,@9],
                                      @[@11,@12,@13],
                                      @[@11,@18,@25],
                                      @[@12,@11,@10],
                                      @[@12,@19,@26],
                                      @[@13,@12,@11],
                                      @[@13,@20,@27],
                                      @[@14,@15,@16],
                                      @[@15,@16,@17],
                                      @[@16,@15,@14],
                                      @[@16,@9,@4],
                                      @[@16,@17,@18],
                                      @[@16,@23,@28],
                                      @[@17,@16,@15],
                                      @[@17,@10,@5],
                                      @[@17,@18,@19],
                                      @[@17,@24,@29],
                                      @[@18,@17,@16],
                                      @[@18,@11,@6],
                                      @[@18,@19,@20],
                                      @[@18,@25,@30],
                                      @[@19,@18,@17],
                                      @[@20,@19,@18],
                                      @[@21,@14,@7],
                                      @[@21,@22,@23],
                                      @[@22,@15,@8],
                                      @[@22,@23,@24],
                                      @[@23,@22,@21],
                                      @[@23,@16,@9],
                                      @[@23,@24,@25],
                                      @[@23,@28,@31],
                                      @[@24,@23,@22],
                                      @[@24,@17,@10],
                                      @[@24,@29,@32],
                                      @[@24,@25,@26],
                                      @[@25,@24,@23],
                                      @[@25,@18,@11],
                                      @[@25,@26,@27],
                                      @[@25,@30,@33],
                                      @[@26,@19,@12],
                                      @[@26,@25,@24],
                                      @[@27,@20,@13],
                                      @[@27,@26,@25],
                                      @[@28,@23,@16],
                                      @[@28,@29,@30],
                                      @[@29,@24,@17],
                                      @[@30,@29,@28],
                                      @[@30,@25,@18],
                                      @[@31,@28,@23],
                                      @[@31,@32,@33],
                                      @[@32,@29,@24],
                                      @[@33,@32,@31],
                                      @[@33,@30,@25]];
    return possibleMovementsArray;
}

-(BOOL)isThereAnyMovementsLeftIn:(NSArray *)pawnPoints withPossibleMovements:(NSArray *)possibleMovements
{
    for(NSInteger i=0;i<[possibleMovements count];i++)
    {
        NSArray *movementRule=possibleMovements[i];
        if(([[pawnPoints objectAtIndex:[[movementRule objectAtIndex:0] integerValue]] boolValue]) &&
           ([[pawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue]) &&
           !([[pawnPoints objectAtIndex:[[movementRule objectAtIndex:2] integerValue]] boolValue]))
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)isThisMovePossibleFrom:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint in:(NSArray *)possibleMovements coordinates:(NSMutableArray *)theBoardPawnPoints
{
    if([[theBoardPawnPoints objectAtIndex:theDropPoint] boolValue])
    {
        return NO;
    }
    
    for(NSInteger i=0;i<[possibleMovements count];i++)
    {
        NSArray *movementRule=[possibleMovements objectAtIndex:i];
        if(theSelectedPawn == [[movementRule objectAtIndex:0] integerValue] &&
           [theBoardPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] boolValue]] &&
           theDropPoint == [[movementRule objectAtIndex:2] integerValue])
        {
            return YES;
        }
    }
    
    return NO;
}

-(NSInteger)numberOfRemainingPawnsIn:(NSMutableArray *)theBoardPawnPoints
{
    NSUInteger remainingPawns=0;
    for (id isExists in theBoardPawnPoints)
    {
        if([isExists boolValue])
        {
            remainingPawns++;
        }
    }
    
    return remainingPawns;
}
/*
 this stays in the PlayScene
 
-(void)removePawnAtPosition:(CGPoint)position
{
    [[[self childNodeWithName:@"board"]nodeAtPoint:position]removeFromParent];
}
*/

@end
