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
@interface Grid : NSObject<GridProtocol>
    @property int width; //By default these are identical.
    @property int height;

-(id<GridProtocol>)init;

-(id<GridProtocol>)initWithWidth:(int)gridWidth andHeight:(int)gridHeight;
//Input an attempted move.
-(void)attemptMoveToX:(int)newX andY:(int)newY forRover:(Rover*)rover;
//Return whether or not the given rover's next move is valid. This is computed over time according to the grid's internal logic.
-(bool)checkValidMove:(Rover*)rover;
//Reset the internal data before the next move.
-(void)resetMoves;
//Kinda self-explanatory getters.
-(int)getWidth;
-(int)getHeight;

@end
