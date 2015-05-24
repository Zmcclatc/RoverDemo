//
//  PreferenceViewController.m
//  RoverDemo
//
//  Created by Zoe M on 5/24/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "PreferenceViewController.h"
#import "Grid.h"
#import "Grid_Sequential.h"
#import "Simulator.h"

@interface PreferenceViewController ()

@end

@implementation PreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//This is the simplest of systems - just swap in a different grid.
//On the other hand, it does demonstrate knowledge of the decorator pattern ^_^
- (IBAction)collisionModeChanged:(id)sender {
    if (((UISegmentedControl*)sender).selectedSegmentIndex==0)
    {
        [[Simulator getSimulation] setGrid:[[Grid alloc]init]];
    }
    else    [[Simulator getSimulation] setGrid:[[Grid_Sequential alloc]init]];
}
@end
