//
//  Rover.h
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rover : NSObject

@property int XCoord;
@property int YCoord;
@property int FacingDir;
@property (strong) NSString* moveString;

-(id)initWithXCoord:(int)xcoord andYcoord:(int)ycoord andMoveSet:(NSString*)moveset andFacing:(NSString*)Facing;

//Getters so the simulator can check against the grid.
+(int)getNextX;
+(int)getNextY;
//Either commit or discard the next move.
+(void)move;
+(void)discardMove;

@end