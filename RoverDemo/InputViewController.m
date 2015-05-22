//
//  FirstViewController.m
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import "InputViewController.h"
#import "Simulator.h"
#import "RoverCell.h"
#import "Rover.h"

@interface InputViewController ()

@end

@implementation InputViewController

Simulator* mySim;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Get our grubby mitts on the simulator!
    
    mySim=[Simulator getSimulation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAdd:(id)sender {
    [mySim addRover];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [mySim removeRover:(int)indexPath.row];
        [tableView reloadData];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RoverCell* myCell=[tableView dequeueReusableCellWithIdentifier:@"RoverCell"];
    Rover* myRover=[mySim getRover:(int)indexPath.row];
    myCell.txtEndingLoc.text=[myRover getMoveset];
    myCell.txtStartingLoc.text=[NSString stringWithFormat:@"%i,%i,%@",myRover.XCoord,myRover.YCoord,[myRover getFacing]];
    
    return myCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mySim numberOfRovers];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];	
    return true;
}

- (IBAction)btnUpdateSimulation:(id)sender {
}
- (IBAction)txtGridWidthChanged:(id)sender {
}

- (IBAction)txtHeightChanged:(id)sender {
}
@end
