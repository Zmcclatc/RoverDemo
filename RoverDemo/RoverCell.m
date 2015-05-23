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
    //Make sure (via regular expressions) that we have the right format of input. If not, throw an error. If so, send it to the sim.
    NSError *error = NULL;
    NSRegularExpressionOptions regexOptions = 0;
    //Prepare a regular expression, of form Digit:Digit:Single Letter.
    NSString *pattern = @"\\d:\\d:[NSEW]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:regexOptions error:&error];
    if (error)//Internal error-handling bits.
    {
        
        NSLog(@"Something broke in the regex in RoverCell! Fix it, dummy!");
        self.txtStartingLoc.text=[NSString stringWithFormat:@"%i:%i:%@",self.myRover.XCoord,self.myRover.YCoord,[self.myRover getFacing]];
        return;
    }
    //Check the data against the regex. We need to make sure it matches so we'll check that the string has
    NSRange rawInputRange=NSMakeRange(0, self.txtStartingLoc.text.length);
    NSRange firstMatch=[regex rangeOfFirstMatchInString:self.txtStartingLoc.text options: 0 range:rawInputRange];
    //Check if the match exists. We do this by comparing the location to a constant. If it doesn't exist, throw an error and reset the input.
    if (firstMatch.location==NSNotFound)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter a starting position string in the format X:Y:Direction (N/S/E/W)"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        
        self.txtStartingLoc.text=[NSString stringWithFormat:@"%i:%i:%@",self.myRover.XCoord,self.myRover.YCoord,[self.myRover getFacing]];
        [alert show];
    }
    else {
        //Otherwise -- UPDATE OUR ROVER WOOT!
        NSString* baseString=[self.txtStartingLoc.text substringWithRange:firstMatch];
        NSArray* inputComponents=[baseString componentsSeparatedByString:@":"];
        [self.myRover setXCoord:[inputComponents[0] intValue]];
        [self.myRover setYCoord:[inputComponents[1] intValue]];
        [self.myRover setFacingDir:inputComponents[2]];
    }
    
}

- (IBAction)txtEndLocChanged:(id)sender {
    //Make sure (via regular expressions) that we have the right format of input. If not, throw an error. If so, send it to the sim.
    NSError *error = NULL;
    NSRegularExpressionOptions regexOptions = 0;
    //Prepare a regular expression, in the form of a string of letters.
    NSString *pattern = @"[FLR]{0,}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:regexOptions error:&error];
    if (error)//Internal error-handling bits.
    {
        
        NSLog(@"Something broke in the regex in RoverCell! Fix it, dummy!");
        self.txtEndingLoc.text=self.myRover.moveString;
        return;
    }
    //Check the data against the regex. We need to make sure it matches so we'll check that the string has
    NSRange rawInputRange=NSMakeRange(0, self.txtStartingLoc.text.length);
    NSRange firstMatch=[regex rangeOfFirstMatchInString:self.txtStartingLoc.text options: 0 range:rawInputRange];
    //Check if the match exists. We do this by comparing the location to a constant. If it doesn't exist, throw an error and reset the input.
    if (firstMatch.location==NSNotFound)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter one or more moves represented as either 'L', 'F', or 'R'"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        
        self.txtEndingLoc.text=self.myRover.moveString;
        [alert show];
    }
    else {
        //Otherwise -- UPDATE OUR ROVER WOOT!
        NSString* baseString=[self.txtStartingLoc.text substringWithRange:firstMatch];
        [self.myRover setMoveString:baseString];
    }
}
@end
