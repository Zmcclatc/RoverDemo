//
//  Grid.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "Grid.h"
/*
 This is the more complex implementation of the grid - where all rovers are expected to move simultaneously. It's the more interesting puzzle, systemically speaking.
 */
@implementation Grid
{
    NSMutableSet* roverList;//We need access to the validities of all rovers we've dealt with in order to handle collisions.
    NSMutableArray* roverLocList;//We also need a secondary array to keep track of interdicted positions. This is easier and much more efficient than checking all rovers each time.
}
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
    roverList=[[NSMutableSet alloc]init];
    roverLocList=[[NSMutableArray alloc]initWithCapacity:width*height];
    return self;
}
//Input an attempted move.
-(void)attemptMoveToX:(int)newX andY:(int)newY forRover:(Rover*)rover
{
    //Don't let us move outside the bounds of the world.
    if (newX<0 || newY<0 || newX>=width || newY>=height) {
        int oldX=[rover getCurrentX];
        int oldY=[rover getCurrentY];
        [self invalidate:oldX andY:oldY forRover:rover withOriginalRover:rover];
        return; //Don't move.
    }
    int locEntryPoint=newX*width+newY;
    if (roverLocList[locEntryPoint]!=nil) //invalid entry point! We're trying to move to the same spot someone else is in!
    {
        [self invalidate:newX andY:newY forRover:roverLocList[locEntryPoint] withOriginalRover:rover];
    }
    else {
        roverLocList[locEntryPoint]=rover;
        [roverList addObject:rover];
    }
}
//A recursive function to clear out impossible moves. If somebody moves into a rover down the road, anything trying to move in turn must stop.
-(void)invalidate:(int)X andY:(int)Y forRover:(Rover*)rover withOriginalRover:(Rover*)original
{
    int oldX=[rover getCurrentX];
    int oldY=[rover getCurrentY];
    int locEntryPoint=oldX*width+oldY;
    //Move prior occupants out of the way.
    if (roverLocList[locEntryPoint]==original) //We've entered a loop somehow. Break out and just say nobody moves.
    {
        return;
    }
    if (roverLocList[locEntryPoint]!=nil)
    {
        [self invalidate:oldX andY:oldY forRover:roverLocList[locEntryPoint] withOriginalRover: original];
    }
    roverLocList[locEntryPoint]=rover;
    [roverList removeObject:rover];
}
//Return whether or not there's a valid move available 
-(bool)checkValidMove:(Rover*)rover
{
    if ([roverList member:rover]==rover) return true;
    return false;
}
//Clear out all our internal stuff - the list and array both.
-(void)resetMoves
{
    
    roverList=[[NSMutableSet alloc]init];
    roverLocList=[[NSMutableArray alloc]initWithCapacity:width*height];
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
