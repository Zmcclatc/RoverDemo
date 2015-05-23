//
//  Rover.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "Rover.h"

@implementation Rover
int currentMove;
int startXCoord;
int startYCoord;
NSString* currentDir;

-(id)initWithXCoord:(int)xcoord andYcoord:(int)ycoord andMoveSet:(NSString*)moveset andFacing:(NSString*)Facing
{
    self=[super init];
    [self updateXCoord:xcoord andYCoord:ycoord];
    self.moveString=moveset;
    self.FacingDir=Facing;
    return self;
}

-(void)updateXCoord:(int)xcoord andYCoord:(int)ycoord
{
    
    self.XCoord=xcoord;
    startXCoord=self.XCoord;
    self.YCoord=ycoord;
    startYCoord=self.YCoord;
}

//Getters so the simulator can check against the grid.
-(int)getNextX
{
    if ([[self getNextMove] isEqual:@"F"])
    {
        if ([currentDir isEqual:@"E"]) return self.XCoord+1;
        if ([currentDir isEqual:@"W"]) return self.XCoord-1;
    }
    return self.XCoord;
}
-(int)getNextY
{
    if ([[self getNextMove] isEqual:@"F"])
    {
        if ([currentDir isEqual:@"S"]) return self.YCoord-1;
        if ([currentDir isEqual:@"N"]) return self.YCoord+1;
    }
    return self.YCoord;
}
/*
 As we opted to keep instructions in string format, we have to interpret what they mean. This is done  by applying a string "Command" to a string "Orientation" (and to the position as well)
 */
-(NSString*)getNextDir
{
    if ([[self getNextMove] isEqual:@"F"]) return currentDir;
    if ([[self getNextMove] isEqual:@"L"])
    {
        if ([currentDir isEqual:@"N"]) return @"W";
        if ([currentDir isEqual:@"W"]) return @"S";
        if ([currentDir isEqual:@"S"]) return @"E";
        if ([currentDir isEqual:@"E"]) return @"N";
    }
    if ([currentDir isEqual:@"N"]) return @"E";
    if ([currentDir isEqual:@"W"]) return @"N";
    if ([currentDir isEqual:@"S"]) return @"W";
    if ([currentDir isEqual:@"E"]) return @"S";
    return currentDir;
}
-(NSString*)getNextMove
{
    NSRange nextChar=NSMakeRange(currentMove, currentMove+1);
    return [self.moveString substringWithRange:nextChar];
}
//Either commit or discard the next move.
-(void)move
{
    self.XCoord=[self getNextX];
    self.YCoord=[self getNextY];
    currentDir=[self getNextDir];
    currentMove++;
}
-(void)discardMove
{
    currentMove++;
}

-(NSString *)getFacing
{
    return self.FacingDir;
}
-(NSString *)getMoveset
{
    return self.moveString;
}
-(void)reset
{
    currentMove=0;
    self.XCoord=self.startXCoord;
    self.YCoord=self.startYCoord;
    currentDir=self.FacingDir;
}

@end
