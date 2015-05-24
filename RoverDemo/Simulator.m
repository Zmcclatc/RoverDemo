//
//  Simulator.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "Simulator.h"
#import "Grid.h"

@implementation Simulator {

    id <GridProtocol> myGrid;
    NSMutableArray* myRovers;
}

//Bog-standard singleton code. We only ever need one simulator, as we've designed it to be resilient and mutable.
+(id)getSimulation
{
    
    static Simulator *simulatorSingleton=nil;
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        simulatorSingleton=[[self alloc]init];
    });
    return simulatorSingleton;
}

-(id)init
{
    if (self=[super init])
    {
        myGrid=[[Grid alloc]init];
        
        myRovers=[[NSMutableArray alloc]initWithCapacity:4];
        
    }
    return self;
}

//Simulator ticks can be triggered individually if need be. Returns whether or not any moves remain.
-(bool)tick
{
    bool movesLeft=false;
    [myGrid resetMoves];//Call before every tick.
    for(Rover* rover in myRovers)
    {
        //Attempt to place a rover on the board at its next location.
        [myGrid attemptMoveToX:[rover getNextX] andY:[rover getNextY] forRover:rover];
    }
    //Now run through all the rovers and move the ones who can move.
    for(Rover* rover in myRovers)
    {
        //If this returns true, the rover in question can move.
        if ([myGrid checkValidMove:rover])
        {
            //Simple and easy one-line check to 'and' together all the outcomes to the rovers' moves.
            movesLeft=[rover move]?true:movesLeft;
        }
        else {
            //Simple and easy one-line check to 'and' together all the outcomes to the rovers' moves.
            movesLeft=[rover discardMove]?true:movesLeft;
        }
    }
    return movesLeft;
}
//Alternately, the entire simulator can be run at once - basically this Ticks until all Rovers have returned 'can't move' or 'out of moves'.
-(void)compute
{
    //Move until you can't move no more. This one's almost trivial - the condition is also the loop.
    while ([self tick]);
}
//This is used to clear the board and run again, or before returning to the sim view.
-(void)resetPositions
{
    for(Rover* rover in myRovers)
    {
        [rover reset];
    }
    [myGrid resetMoves];
}
//For setup tableview purposes.
-(int)numberOfRovers
{
    return (int)myRovers.count;
}
/*
 So we can get the details of said rover. Potentially later we can expand this to use a delegate and any number of types of object in the grid.
 Parameter: roverIndex - the index into the list of rovers. Use numberOfRovers and enumerate.
 
 */
-(Rover*)getRover:(int)roverIndex
{
    if (roverIndex>=myRovers.count)
    {
        NSLog(@"Invalid rover index. Something went wrong while coding, bucko!");
    }
    return myRovers[roverIndex];
}
/*
 Since the grid is 'part of' the simulation, we're updating it with a passthrough.
 Parameters: width - the new width of the grid.
            height - the new height of the grid.
 
 */
-(void)updateGridWidth:(int)width andHeight:(int)height
{
    if ([myGrid respondsToSelector:@selector(initWithWidth:andHeight:)])
    {
        myGrid= [[Grid alloc]initWithWidth:width andHeight:height];
    }
}
//Getter methods for controlling input and the visual side of the simulation.
-(int)getGridWidth
{
    return [myGrid getWidth];
}
-(int)getGridHeight
{
    return [myGrid getHeight];
}
/*
 Two options to add rovers - either with a known set of coordinates or with a default setting (eg via the addRover button). This option is more useful for testing.
    Parameters: XCoord - the x location of the new rover.
                YCoord - the y location of the new rover.
                moveset - a series of moves for the rover to follow, in F/L/R format.
                facing - the direction the rover starts out in. N/S/E/W.
 */
-(Rover*)addRoverAtX:(int)XCoord andY:(int)YCoord withMoveSet:(NSString*)moveset andFacing:(NSString*)facing
{
    Rover* newRover=[[Rover alloc]initWithXCoord:XCoord andYcoord:YCoord andMoveSet:moveset andFacing:facing];
    [myRovers addObject:newRover];
    return newRover;
}
/*
 Add a rover with a default orientation and incremented location.
 */
-(Rover*)addRover
{
    int gridSpaces=[myGrid getHeight]*[myGrid getWidth];
    NSMutableArray* roverInterdictionArray=[[NSMutableArray alloc] initWithCapacity:gridSpaces];
    //We're doing a more intelligent rover interdiction test now. We go through and fill out an array with
    //rover locations, then find the first unfilled location in the array to place our rover.
    int loc;
    for(loc=0;loc<gridSpaces;loc++)
    {
        roverInterdictionArray[loc]=@0;
    }
    for(Rover* rover in myRovers)
    {
        roverInterdictionArray[[rover getStartY]*[myGrid getWidth]+[rover getStartX]]=@1;
    }
    for(loc=0;loc<gridSpaces;loc++)
    {
        if ([roverInterdictionArray[loc] isEqual:@0]) break;
    }
    //Do a basic attempt not to overlap. Take the incremented rover count as an index into the grid itself.
    int newXCoord=loc % [myGrid getWidth];
    int newYCoord=(loc / [myGrid getWidth]) % [myGrid getHeight];
    Rover* newRover=[[Rover alloc]initWithXCoord:newXCoord andYcoord:newYCoord andMoveSet:@"" andFacing:@"N"];
    [myRovers addObject:newRover];
    return newRover;
}
/*
 Remove the rover at the given index, if applicable. Otherwise throw a funny warning.
    Parameters: roverIndex - the array index to remove a rover from. 
 */
-(void)removeRover:(int)roverIndex
{
    if (roverIndex>=myRovers.count || roverIndex<0)
    {
        NSLog(@"The impossible has occurred! We tried to remove (roll over) a nonexistent (red) rover!");
        return;
    }
    [myRovers removeObjectAtIndex:roverIndex];
}

@end
