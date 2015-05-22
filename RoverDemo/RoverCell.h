//
//  RoverCell.h
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rover.h"

@interface RoverCell : UITableViewCell
@property (strong,nonatomic) Rover* myRover;
@property (weak, nonatomic) IBOutlet UITextField *txtStartingLoc;
@property (weak, nonatomic) IBOutlet UITextField *txtEndingLoc;
- (IBAction)txtStartLocChanged:(id)sender;
- (IBAction)txtEndLocChanged:(id)sender;

@end
