//
//  RoverCell.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "RoverCell.h"

@implementation RoverCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)txtStartLocChanged:(id)sender {
    Simulator* mySim=[Simulator getSimulation];
    Rover* myRover=[mySim getRover:self.roverIndex];
    //Make sure (via regular expressions) that we have the right format of input. If not, throw an error. If so, send it to the sim.
    NSError *error = NULL;
    NSRegularExpressionOptions regexOptions = 0;
    //Prepare a regular expression, of form Digit:Digit:Single Letter.
    NSString *pattern = @"\\d:\\d:[NSEW]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:regexOptions error:&error];
    if (error)//Internal error-handling bits.
    {
        
        NSLog(@"Something broke in the regex in RoverCell! Fix it, dummy!");
        self.txtStartingLoc.text=[NSString stringWithFormat:@"%i:%i:%@",[myRover getStartX],[myRover getStartY],[myRover getFacing]];
        return;
    }
    //Check the data against the regex. We need to make sure it matches so we'll check that the string has
    NSRange rawInputRange=NSMakeRange(0, self.txtStartingLoc.text.length);
    NSRange firstMatch=[regex rangeOfFirstMatchInString:self.txtStartingLoc.text options: 0 range:rawInputRange];
    //Check if the match exists. We do this by comparing the location to a constant. If it doesn't exist, throw an error and reset the input.
    if (firstMatch.location==NSNotFound && firstMatch.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter a starting position string in the format X:Y:Direction (N/S/E/W)"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        
        self.txtStartingLoc.text=[NSString stringWithFormat:@"%i:%i:%@",[myRover getStartX],[myRover getStartY],[myRover getFacing]];
        [alert show];
    }
    else {
        NSString* baseString=[self.txtStartingLoc.text substringWithRange:firstMatch];
        NSArray* inputComponents=[baseString componentsSeparatedByString:@":"];
        //Before actually updating, we need to check if there's a collision in the sim, whether with another rover or the bounds of the grid.
        bool hasCollision=[inputComponents[0] intValue]>[mySim getGridWidth]?true:false;
        hasCollision=[inputComponents[1] intValue]>[mySim getGridHeight]?true:hasCollision;
        //Run through each of the other (non-us) rovers and make sure they don't already occupy our chosen landing zone.
        for(int iter=0;!hasCollision && iter<[mySim numberOfRovers];iter++)
        {
            if (iter!=self.roverIndex)
            {
                Rover* otherRover=[mySim getRover:iter];
                if ([otherRover getStartX]==[inputComponents[0] intValue] && [otherRover getStartY]==[inputComponents[1] intValue])
                    hasCollision=true;
            }
            if (hasCollision) break;
            
        }
        if (hasCollision) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rover location collision/out of bounds error"
                                                            message:@"Please enter a location for this rover that does not put it in conflict with another rover, or beyond the grid boundaries."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            
            self.txtStartingLoc.text=[NSString stringWithFormat:@"%i:%i:%@",[myRover getStartX],[myRover getStartY],[myRover getFacing]];
            [alert show];
        }
        else {
        //Otherwise -- UPDATE OUR ROVER WOOT!
        
        
            [myRover updateXCoord:[inputComponents[0] intValue] andYCoord:[inputComponents[1] intValue]];
            [myRover setFacingDir:inputComponents[2]];
        }
        self.txtStartingLoc.text=[NSString stringWithFormat:@"%i:%i:%@",[myRover getStartX],[myRover getStartY],[myRover getFacing]];
    }
    
}

- (IBAction)txtEndLocChanged:(id)sender {
    Rover* myRover=[[Simulator getSimulation] getRover:self.roverIndex];
    //Make sure (via regular expressions) that we have the right format of input. If not, throw an error. If so, send it to the sim.
    NSError *error = NULL;
    NSRegularExpressionOptions regexOptions = 0;
    //Prepare a regular expression, in the form of a string of letters.
    NSString *pattern = @"[FLR]{0,}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:regexOptions error:&error];
    if (error)//Internal error-handling bits.
    {
        
        NSLog(@"Something broke in the regex in RoverCell! Fix it, dummy!");
        self.txtEndingLoc.text=myRover.moveString;
        return;
    }
    //Check the data against the regex. We need to make sure it matches so we'll check that the string has
    NSRange rawInputRange=NSMakeRange(0, self.txtEndingLoc.text.length);
    NSRange firstMatch=[regex rangeOfFirstMatchInString:self.txtEndingLoc.text options: 0 range:rawInputRange];
    //Check if the match exists. We do this by comparing the location to a constant. If it doesn't exist, throw an error and reset the input.
    if (firstMatch.length==0 && rawInputRange.length!=0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter zero or more moves represented as either 'L', 'F', or 'R'"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        
        self.txtEndingLoc.text=myRover.moveString;
        [alert show];
    }
    else {
        //Otherwise -- UPDATE OUR ROVER WOOT!
        NSString* baseString=[self.txtEndingLoc.text substringWithRange:firstMatch];
        [myRover setMoveString:baseString];
        self.txtEndingLoc.text=myRover.moveString;
    }
}
@end
