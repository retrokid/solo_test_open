//
//  GameLogic.m
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

#import "GameLogic.h"
#define TheLogger(s, ...) NSLog(@"<%@> -%@ Line:%d | %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], NSStringFromSelector(_cmd), __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__])
@implementation GameLogic

-(NSArray *)possibleMovements
{
    
    NSArray *possibleMovementsArray=@[@[@0,@1,@2],//
                                      @[@0,@3,@8],//
                                      @[@1,@4,@9],//
                                      @[@2,@1,@0],//
                                      @[@2,@5,@10],//
                                      @[@3,@4,@5],//
                                      @[@3,@8,@15],
                                      @[@4,@9,@16],
                                      @[@5,@4,@3],
                                      @[@5,@10,@17],
                                      @[@6,@7,@8],
                                      @[@6,@13,@20],//
                                      @[@7,@8,@9],//
                                      @[@7,@14,@21],//
                                      @[@8,@3,@0],//
                                      @[@8,@7,@6],//
                                      @[@8,@15,@22],//
                                      @[@8,@9,@10],
                                      @[@9,@16,@23],
                                      @[@9,@4,@1],
                                      @[@9,@8,@7],
                                      @[@9,@10,@11],//
                                      @[@10,@5,@2],//
                                      @[@10,@9,@8],
                                      @[@10,@11,@12],
                                      @[@10,@17,@24],//
                                      @[@11,@10,@9],//
                                      @[@11,@18,@25],
                                      @[@12,@11,@10],
                                      @[@12,@19,@26],//
                                      @[@13,@14,@15],//
                                      @[@14,@15,@16],//
                                      @[@15,@14,@13],
                                      @[@15,@8,@3],
                                      @[@15,@16,@17],
                                      @[@15,@22,@27],
                                      @[@16,@15,@14],
                                      @[@16,@9,@4],//
                                      @[@16,@17,@18],
                                      @[@16,@23,@28],//
                                      @[@17,@16,@15],
                                      @[@17,@10,@5],
                                      @[@17,@18,@19],
                                      @[@17,@24,@29],
                                      @[@18,@17,@16],
                                      @[@19,@18,@17],
                                      @[@20,@13,@6],
                                      @[@20,@21,@22],
                                      @[@21,@14,@7],
                                      @[@21,@22,@23],
                                      @[@22,@21,@20],
                                      @[@22,@15,@8],
                                      @[@22,@23,@24],
                                      @[@22,@27,@30],
                                      @[@23,@22,@21],//
                                      @[@23,@16,@9],
                                      @[@23,@28,@31],
                                      @[@23,@24,@25],
                                      @[@24,@23,@22],
                                      @[@24,@17,@10],
                                      @[@24,@25,@26],
                                      @[@24,@29,@32],//
                                      @[@25,@18,@11],
                                      @[@25,@24,@23],
                                      @[@26,@19,@12],
                                      @[@26,@25,@24],
                                      @[@26,@21,@14],
                                      @[@27,@28,@29],
                                      @[@27,@22,@15],
                                      @[@28,@23,@16],
                                      @[@29,@28,@27],
                                      @[@29,@24,@17],
                                      @[@30,@27,@22],//
                                      @[@30,@31,@32],
                                      @[@31,@28,@23],
                                      @[@32,@31,@30],
                                      @[@32,@29,@24]];

    return possibleMovementsArray;
}

-(NSMutableArray *)boardPawnPoints
{
    NSMutableArray *boardPawnPoints=[[NSMutableArray alloc]init];
    for(NSInteger i=0;i<33;i++)
    {
        [boardPawnPoints addObject:@YES];
    }
    boardPawnPoints[16]=@NO;
    
    //To Access BOOL Values use : [boardPawnPoints[0] boolValue];
    return boardPawnPoints;
}

-(BOOL)isThereAnyMovementsLeftIn:(NSMutableArray *)theBoardPawnPoints compareWith:(NSArray *)thePossibleMovements
{
    for(NSInteger i=0;i<[thePossibleMovements count];i++)
    {
        NSArray *movementRule=thePossibleMovements[i];
        if(([[theBoardPawnPoints objectAtIndex:[[movementRule objectAtIndex:0] integerValue]] boolValue]) &&
           ([[theBoardPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue]) &&
           !([[theBoardPawnPoints objectAtIndex:[[movementRule objectAtIndex:2] integerValue]] boolValue]))
        {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)isThisMovePossibleFromPointOf:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint inThe:(NSArray *)possibleMovements coordinates:(NSMutableArray *)theBoardPawnPoints
{
    if([[theBoardPawnPoints objectAtIndex:theDropPoint] boolValue])
    {
        TheLogger(@"⛔️ FAIL");
        return NO;
    }
    for(NSInteger i=0;i<[possibleMovements count];i++)
    {
        NSArray *movementRule=[possibleMovements objectAtIndex:i];
        if(theSelectedPawn == [[movementRule objectAtIndex:0] integerValue] &&
           [[theBoardPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue] &&
           theDropPoint == [[movementRule objectAtIndex:2] integerValue])
        {
            TheLogger(@"✅ SUCCESS");
            return YES;
        }
    }
    TheLogger(@"⛔️ FAIL");
    return NO;
}

-(NSInteger)findRemovePointOfPawn:(NSInteger)theSelectedPawn to:(NSInteger)theDropPoint inThe:(NSArray *)possibleMovements coordinates:(NSMutableArray *)theBoardPawnPoints
{
    if([[theBoardPawnPoints objectAtIndex:theDropPoint] boolValue])
    {
        TheLogger(@"⛔️ FAIL");
        return -1;
    }
    for(NSInteger i=0;i<[possibleMovements count];i++)
    {
        NSArray *movementRule=[possibleMovements objectAtIndex:i];
        if(theSelectedPawn == [[movementRule objectAtIndex:0] integerValue] &&
           [[theBoardPawnPoints objectAtIndex:[[movementRule objectAtIndex:1] integerValue]] boolValue] &&
           theDropPoint == [[movementRule objectAtIndex:2] integerValue])
        {
            TheLogger(@"✅ SUCCESS");
            return [[movementRule objectAtIndex:1] integerValue];
        }
    }
    TheLogger(@"⛔️ FAIL");
    return -1;
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

@end
