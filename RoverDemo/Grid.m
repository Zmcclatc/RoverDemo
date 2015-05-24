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
    NSMutableArray* oldLocList;//Finally, we need to keep track of where rovers were. This handles the single case where rovers try to switch positions.
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
    oldLocList=[[NSMutableArray alloc]initWithCapacity:width*height];
    return self;
}
//Input an attempted move.
-(void)attemptMoveToX:(int)newX andY:(int)newY forRover:(Rover*)rover
{
    /*
     First, check if we're outside the bounds of the world. If we are,
     we want to return - but not before invalidating anything that tried to move to our old position, and updating the list of old locations.
    */
    if (newX<0 || newY<0 || newX>=width || newY>=height) {
        int oldX=[rover getCurrentX];
        int oldY=[rover getCurrentY];
        oldLocList[oldX*width+oldY]=rover;
        [self invalidate:oldX andY:oldY forRover:rover withOriginalRover:rover];
        return; //Don't move.
    }
    int locEntryPoint=newX*width+newY;
    /*
     Special case: The rover at our old position used to be in our new one. 
     We don't want to let rovers pass unseen in the night, so let's invalidate.
     */
    if (oldLocList[locEntryPoint]==roverLocList[[rover getCurrentX]*width+[rover getCurrentY]] && ![oldLocList[locEntryPoint] isEqual:@0])
    {
        [self invalidate:[rover getCurrentX] andY:[rover getCurrentY] forRover:oldLocList[locEntryPoint] withOriginalRover:rover];
    }
    /*
     Standard issue: We're attempting to move to a position already occupied by an impetuous virtual hunk of metal and silicon. Stop, and tell them to stop too.
     */
    if (![[roverLocList objectAtIndex:locEntryPoint] isEqual:@0])
    {
        [self invalidate:newX andY:newY forRover:roverLocList[locEntryPoint] withOriginalRover:rover];
        oldLocList[[rover getCurrentX]*width+[rover getCurrentY]]=rover;
        return;
    }
    
    /*
     If none of the above applied, we're all systems go for attempting to move.
     Of course, we need to understand when we do this that we may be booted back in the future.
     */
    oldLocList[[rover getCurrentX]*width+[rover getCurrentY]]=rover;
    roverLocList[locEntryPoint]=rover;
    [roverList addObject:rover];
}
//A recursive function to clear out impossible moves. If somebody moves into a rover down the road, anything trying to move in turn must stop.
-(void)invalidate:(int)X andY:(int)Y forRover:(Rover*)rover withOriginalRover:(Rover*)original
{
    int oldX=[rover getCurrentX];
    int oldY=[rover getCurrentY];
    int locEntryPoint=oldX*width+oldY;
    //Move prior occupants out of the way.
    if (roverLocList[locEntryPoint]==original || roverLocList[locEntryPoint]==rover) //We've entered a loop somehow. Break out and just say nobody moves.
    {
        return;
    }
    if (![[roverLocList objectAtIndex:locEntryPoint] isEqual:@0])
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
    for(int x=0;x<width*height;x++)
    {
        roverLocList[x]=@0;
        oldLocList[x]=@0;
    }
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
