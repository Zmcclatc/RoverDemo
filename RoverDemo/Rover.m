//
//  Rover.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "Rover.h"

@implementation Rover {

    int XCoord;
    int YCoord;
    int startXCoord;
    int startYCoord;

    int currentMove;
    NSString* currentDir;
}
/*
 Initialize a rover with a given xcoord, ycoord, moveset, and facing direction.
 */
-(id)initWithXCoord:(int)xcoord andYcoord:(int)ycoord andMoveSet:(NSString*)moveset andFacing:(NSString*)Facing
{
    self=[super init];
    [self updateXCoord:xcoord andYCoord:ycoord];
    self.moveString=moveset;
    currentMove=0;
    self.FacingDir=Facing;
    currentDir=self.FacingDir;
    return self;
}
//Both update our xcoord/ycoord and our starting positions. I'm not entirely happy with how these are represented right now, but it'll do until we get into testing.
-(void)updateXCoord:(int)xcoord andYCoord:(int)ycoord
{
    
    XCoord=xcoord;
    startXCoord=XCoord;
    YCoord=ycoord;
    startYCoord=YCoord;
}

//Getters so the simulator can check against the grid. These are also how the rover figures out where it will be next turn.
-(int)getNextX
{
    if ([[self getNextMove] isEqual:@"F"])
    {
        if ([currentDir isEqual:@"E"]) return XCoord+1;
        if ([currentDir isEqual:@"W"]) return XCoord-1;
    }
    return XCoord;
}
-(int)getNextY
{
    if ([[self getNextMove] isEqual:@"F"])
    {
        if ([currentDir isEqual:@"N"]) return YCoord-1;
        if ([currentDir isEqual:@"S"]) return YCoord+1;
    }
    return YCoord;
}
-(int)getStartX
{
    return startXCoord;
}
-(int)getStartY
{
    return startYCoord;
}
-(int)getCurrentX
{
    return XCoord;
}
-(int)getCurrentY
{
    return YCoord;
}
/*
 As we opted to keep instructions in string format, we have to interpret what they mean. This is done  by applying a string "Command" to a string "Orientation" (and to the position as well) "L" and "R" are applied to compass directions here.
 */
-(NSString*)getNextDir
{
    if ([[self getNextMove] isEqual:@""]) return currentDir;
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
//Handle the parsing of the move string in a single location.
-(NSString*)getNextMove
{
    if (currentMove>=self.moveString.length || self.moveString==nil)
    {
        return @"";
    }
    NSRange nextChar=NSMakeRange(currentMove, 1);
    return [self.moveString substringWithRange:nextChar];
}
//Either commit or discard the next move. This applies changes to our rover's state.
-(bool)move
{
    XCoord=[self getNextX];
    YCoord=[self getNextY];
    currentDir=[self getNextDir];
    currentMove=currentMove+1;
    if ([[self getNextMove] isEqual: @""]) return false;
    return true;
}
//Just move on.
-(bool)discardMove
{
    currentMove=currentMove+1;
    if ([[self getNextMove] isEqual: @""]) return false;
    return true;
}
//Standard getters.

-(float)getAngle
{
    if ([currentDir isEqual:@"N"])return 0;
    if ([currentDir isEqual:@"E"])return M_PI*0.5;
    if ([currentDir isEqual:@"S"])return M_PI;
    return M_PI*1.5;
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
    XCoord=startXCoord;
    YCoord=startYCoord;
    currentDir=self.FacingDir;
}

@end
