//
//  Grid.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "Grid_Sequential.h"
/*
 This is the simpler implementation of the grid -
 */
@implementation Grid_Sequential
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
-(void)startFromX:(int)newX andY:(int)newY forRover:(Rover *)rover
{
    roverLocList[newX*width+newY]=rover;
}

//Input an attempted move.
-(void)attemptMoveToX:(int)newX andY:(int)newY forRover:(Rover*)rover
{
    /*
     First, check if we're outside the bounds of the world. If we are,
     we want to return.
     */
    if (newX<0 || newY<0 || newX>=width || newY>=height) {
        return; //Don't move.
    }
    int locEntryPoint=newX*width+newY;
    /*
     If the location we're moving to is occupied, return.
     */
    if (![roverLocList[locEntryPoint] isEqual:@0])
    {
        return;
    }
    
    /*
     If none of the above applied, we're all systems go for attempting to move.
     Clear out our old spot and put ourselves in the new one.
     */
    roverLocList[[rover getCurrentX]*width+[rover getCurrentY]]=@0;
    roverLocList[locEntryPoint]=rover;
    [roverList addObject:rover];
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
    for(int x=0;x<width*height;x++)
    {
        roverLocList[x]=@0;
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
