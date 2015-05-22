//
//  SecondViewController.h
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimulationViewController : UIViewController
- (IBAction)btnTick:(id)sender;
- (IBAction)btnComplete:(id)sender;
- (IBAction)btnReset:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewDisplay;


@end

