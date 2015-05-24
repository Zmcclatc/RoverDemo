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

@implementation InputViewController {

    Simulator* mySim;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Get our grubby mitts on the simulator!
    
    mySim=[Simulator getSimulation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Tell the sim we're taking this Opportunity to land an additional Spirit on Mars. Also update the table.
 */
- (IBAction)btnAdd:(id)sender {
    //Don't let the user add more rovers than can actually fit on the board.
    if ([mySim numberOfRovers]<([mySim getGridWidth]*[mySim getGridHeight]))
    {
        [mySim addRover];
        [self.tableView reloadData];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Too many rovers!"
                                                        message:@"Please increase the grid size before adding more rovers."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//Yeah - just assume we can edit anything we find.
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}
/*
 Handle row deletion and table updates. This is via the cool slide-out delete button that comes standard on iOS.
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [mySim removeRover:(int)indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView endUpdates];
}
/*
 Fill out and display our starting cells. They contain an individual rover's x, y, and starting direction.
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RoverCell* myCell=[tableView dequeueReusableCellWithIdentifier:@"RoverCell"];
    Rover* myRover=[mySim getRover:(int)indexPath.row];
    myCell.txtEndingLoc.text=[myRover getMoveset];
    myCell.txtStartingLoc.text=[NSString stringWithFormat:@"%i:%i:%@",[myRover getStartX],[myRover getStartY],[myRover getFacing]];
    myCell.roverIndex=(int)indexPath.row;
    
    return myCell;
}
//Standard table setup and visual dimensions functions.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mySim numberOfRovers];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

//Make the keyboard go away when needed. Woo!
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];	
    return true;
}
//When the grid width changes, we need to update all rovers to ensure they start inside. We also need to make certain the given input is actually within reasonable boundaries.
//For now, this function also updates grid height.
- (IBAction)txtGridWidthChanged:(id)sender {
    int testWidth=[self.txtGridWidth.text intValue];
    if (testWidth<=0 || testWidth>20)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter a grid width between 1 and 20"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        testWidth=[mySim getGridWidth];
        self.txtGridWidth.text=[NSString stringWithFormat:@"%i",testWidth];
        [alert show];
        return;
    }
    //Right now the grid is slaved to a square shape. But we have support for other dimensions. In the meantime, copy the width to the height box.
    [mySim updateGridWidth: testWidth andHeight:testWidth];
    self.txtGridHeight.text=[NSString stringWithFormat:@"%i",testWidth];
    self.txtGridWidth.text=[NSString stringWithFormat:@"%i",testWidth];
    //Kill off any extra rovers. This is a hard counter to our issues.
    for(int iter=testWidth*testWidth;iter<[mySim numberOfRovers];iter++)
    {
        [mySim removeRover:iter];
    }
    [self.tableView reloadData];
}

/*
 For now this is nonfunctional. It's here for future-proofing reasons - just in case we want to add rectangular grids in the future.
 */
- (IBAction)txtHeightChanged:(id)sender {
    int testHeight=[self.txtGridHeight.text intValue];
    if (testHeight<=0 || testHeight>20)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sanitization issue"
                                                        message:@"Please enter a grid height between 1 and 20"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        testHeight=[mySim getGridHeight];
        self.txtGridHeight.text=[NSString stringWithFormat:@"%i",testHeight];
        [alert show];
        return;
    }
    [mySim updateGridWidth: [mySim getGridWidth] andHeight: testHeight];
    self.txtGridHeight.text=[NSString stringWithFormat:@"%i",testHeight];
}
@end
