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
@protocol GridProtocol
@required
-(id)init;
//Input an attempted move.
-(void)attemptMoveToX:(int)newX andY:(int)newY forRover:(Rover*)rover;
//Return
-(bool)checkValidMove:(Rover*)rover;


@optional
-(id)initWithWidth:(int)gridWidth andHeight:(int)gridHeight;

@end

@interface Simulator : NSObject

@property (weak,nonatomic) id <GridProtocol> myGrid;
@property (strong,nonatomic) NSArray* myRovers;

//Simulator ticks can be triggered individually if need be.
+(void)tick;
//Alternately, the entire simulator can be run at once - basically this Ticks until all Rovers have returned 'can't move' or 'out of moves'.
+(void)compute;

+(void)resetPositions;

+(int)numberOfRovers;

+(int)getRover:(int)roverIndex;

+(void)updateGridWidth:(int)width andHeight:(int)height;

+(int)getGridWidth;

+(int)getGridHeight;

@end
