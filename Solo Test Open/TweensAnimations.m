//
//  TweensAnimations.m
//  Solo Test Open
//
//  Created by efe ertugrul on 22/05/15.
//  Copyright (c) 2015 efe ertugrul. All rights reserved.
//

#import "TweensAnimations.h"

@implementation TweensAnimations

-(void)vRayAnimation:(SKSpriteNode *)aVRay
{
    [aVRay setPosition:CGPointMake(aVRay.position.x, aVRay.position.y-(aVRay.position.y*3))];
}

@end
