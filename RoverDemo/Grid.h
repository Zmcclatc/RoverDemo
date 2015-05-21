//
//  Grid.h
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rover.h"
#import "Simulator.h"

//The grid class holds a collection of Rovers - it has a custom initializer
//and a default (with a default size of 4x4).
//I've decided to allow for grids of nonuniform dimensions for
//futureproofing. I've decided to run collision checks through the grid class for a potential future addition of multiple possible collision handlers - this is why the Grid interface implements the simulator's GridDelegate.
@interface Grid : NSObject
    @property int width; //By default these are identical.
    @property int height;
    @property (nonatomic, retain) NSMutableArray* roverList;//We need access to the positions of all rovers to handle collisions.
-(Grid*)init;

-(Grid*)initWithWidth:(int)gridWidth andHeight:(int)gridHeight;

-(bool)attemptAddRover:(Rover*)newRover;

-(void)finalizeMoves;

-(bool)attemptMoveToXCoord:(int)newXCoord andYCoord:(int)newYCoord;

@end
