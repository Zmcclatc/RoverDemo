//
//  Grid.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "Grid.h"

@implementation Grid
    NSMutableDictionary* roverList;//We need access to the positions of all rovers we've dealt with in order to handle collisions.
@synthesize width;
@synthesize height;
-(id<GridProtocol>)init
{
    self=[super init];
    self.width=6;
    self.height=6;
    return self;
}

-(id<GridProtocol>)initWithWidth:(int)gridWidth andHeight:(int)gridHeight
{
    self=[super init];
    width=gridWidth;
    height=gridHeight;
    return self;
}
//Input an attempted move.
-(void)attemptMoveToX:(int)newX andY:(int)newY forRover:(Rover*)rover
{
    
}
//Return
-(bool)checkValidMove:(Rover*)rover
{
    return true;
}

-(int)getHeight
{
    return height;
}
-(int)getWidth
{
    return width;
}

@end
