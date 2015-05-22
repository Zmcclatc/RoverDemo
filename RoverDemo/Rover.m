//
//  Rover.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "Rover.h"

@implementation Rover

-(id)initWithXCoord:(int)xcoord andYcoord:(int)ycoord andMoveSet:(NSString*)moveset andFacing:(NSString*)Facing
{
    self=[super init];
    self.XCoord=xcoord;
    self.YCoord=ycoord;
    self.moveString=moveset;
    self.FacingDir=Facing;
    return self;
}

//Getters so the simulator can check against the grid.
-(int)getNextX
{
    return 0;
}
-(int)getNextY
{
    return 0;
}
//Either commit or discard the next move.
-(void)move
{
    
}
-(void)discardMove
{
    
}

@end
