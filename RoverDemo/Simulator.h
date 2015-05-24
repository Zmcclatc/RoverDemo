//
//  Simulator.h
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rover.h"

//Okay!
//Simulation knows grid and list of rovers.
//Rovers don't know the grid, but the simulator can check them against it.


//This protocol defines how the Simulator can interact with the grid.
//Updating moves and initializing a grid are all possible.
@protocol GridProtocol <NSObject>
@required
-(id)init;
//Input an attempted move.
-(void)attemptMoveToX:(int)newX andY:(int)newY forRover:(Rover*)rover;
//Return whether or not the given rover has a valid move.
-(bool)checkValidMove:(Rover*)rover;
-(void)resetMoves;
-(int)getWidth;
-(int)getHeight;


@optional
-(id)initWithWidth:(int)gridWidth andHeight:(int)gridHeight;
//Fill in the place the rover started.
-(void)startFromX:(int)newX andY:(int)newY forRover:(Rover*)rover;

@end

@interface Simulator : NSObject


+(id)getSimulation;


//Simulator ticks can be triggered individually if need be.
-(bool)tick;
//Alternately, the entire simulator can be run at once - basically this Ticks until all Rovers have returned 'can't move' or 'out of moves'.
-(void)compute;
//This is used to clear the board and run again, or before returning to the sim view.
-(void)resetPositions;
//For setup tableview purposes.
-(int)numberOfRovers;
//So we can get the details of said rover. Potentially later we can expand this to use a delegate and any number of types of object in the grid.
-(Rover*)getRover:(int)roverIndex;

//Commands for adding and deleting rovers. Used by the input screen.
-(Rover*)addRover;
-(Rover*)addRoverAtX:(int)XCoord andY:(int)YCoord withMoveSet:(NSString*)moveset andFacing:(NSString*)facing;
-(void)removeRover:(int)roverIndex;

//Since the grid is 'part of' the simulation, we're updating it with a passthrough.
-(void)updateGridWidth:(int)width andHeight:(int)height;
//Getter methods for controlling input and the visual side of the simulation.
-(int)getGridWidth;
-(int)getGridHeight;

-(void)setGrid:(id<GridProtocol>)newGrid;

@end
