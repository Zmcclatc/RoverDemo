//
//  SecondViewController.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "SimulationViewController.h"
#import "Simulator.h"

@interface SimulationViewController ()

@end

@implementation SimulationViewController

Simulator* mySim;

- (void)viewDidLoad {
    [super viewDidLoad];
    mySim=[Simulator getSimulation];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTick:(id)sender {
    [mySim tick];
}

- (IBAction)btnComplete:(id)sender {
    [mySim compute];
}

- (IBAction)btnReset:(id)sender {
    [mySim resetPositions];
}
@end
