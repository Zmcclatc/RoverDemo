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
    myCell.roverIndex=(int)indexPath.row;
    
    return myCell;
}
//Standard table setup function.
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
//When the grid width changes, we need to update all rovers to ensure they start inside. We also need to make certain the given input is actually within
- (IBAction)txtGridWidthChanged:(id)sender {
    int testWidth=[self.txtGridWidth.text intValue];
    if (testWidth<=0 || testWidth>20)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter a grid width between 0 and 20"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        testWidth=[mySim getGridWidth];
        self.txtGridWidth.text=[NSString stringWithFormat:@"%i",testWidth];
        [alert show];
        return;
    }
    [mySim updateGridWidth: testWidth andHeight:[mySim getGridHeight]];
}

- (IBAction)txtHeightChanged:(id)sender {
    int testHeight=[self.txtGridHeight.text intValue];
    if (testHeight<=0 || testHeight>20)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter a grid height between 0 and 20"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        testHeight=[mySim getGridHeight];
        self.txtGridHeight.text=[NSString stringWithFormat:@"%i",testHeight];
        [alert show];
        return;
    }
    [mySim updateGridWidth: [mySim getGridWidth] andHeight: testHeight];
}
@end
