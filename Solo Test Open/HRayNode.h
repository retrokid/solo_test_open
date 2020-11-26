//
//  HRayNode.h
//  Solo Test Open
//
//  Created by efe ertugrul on 26/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HRayNode : SKSpriteNode

@property CGPoint startupPosition;

//init
- (id)initWithBoardSize:(CGSize)boardSize name:(NSString *)theName andPosition:(CGPoint)thePosition;


@end
