//
//  Rover.h
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rover : NSObject


@property (strong) NSString* FacingDir;
@property (strong) NSString* moveString;

-(id)initWithXCoord:(int)xcoord andYcoord:(int)ycoord andMoveSet:(NSString*)moveset andFacing:(NSString*)Facing;

//Getters so the simulator can check against the grid.
-(int)getNextX;
-(int)getNextY;
-(int)getStartX;
-(int)getStartY;
-(int)getCurrentX;
-(int)getCurrentY;
//Either commit or discard the next move.
-(bool)move;
-(BOOL)discardMove;
//Convert our direction to a degree.
-(float)getAngle;

-(NSString*)getMoveset;
-(NSString*)getFacing;

-(void)updateXCoord:(int)xcoord andYCoord:(int)ycoord;

//Reset just returns us to the first move in our moveset.
-(void)reset;

@end
