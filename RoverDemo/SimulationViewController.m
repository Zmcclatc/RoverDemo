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

-(void)viewWillAppear:(BOOL)animated
{
    [mySim resetPositions];
    [self makeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTick:(id)sender {
    [mySim tick];
    [self makeView];
}

- (IBAction)btnComplete:(id)sender {
    [mySim compute];
    [self makeView];
}

-(void)makeView
{
    for(UIView* subview in self.viewDisplay.subviews)
    {
        [subview removeFromSuperview];
    }
    int viewMinSizeX=MAX([mySim getGridWidth]*16,300);
    int viewMinSizeY=MAX([mySim getGridHeight]*16,300);
    float tileSizeX=viewMinSizeX/[mySim getGridWidth];
    float tileSizeY=viewMinSizeY/[mySim getGridHeight];
    
    
    self.viewMapScroller.contentSize=CGSizeMake(viewMinSizeX, viewMinSizeY);
    for(int x=0;x<[mySim getGridWidth];x++)
    {
        for(int y=0;y<[mySim getGridHeight];y++)
        {
            UIImageView* newView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mars"]];
            [newView setFrame:CGRectMake(x*tileSizeX, y*tileSizeY, tileSizeX, tileSizeY)];
            [self.viewDisplay addSubview:newView];
        }
    }
    for(int iter=0;iter<[mySim numberOfRovers];iter++)
    {
        Rover* rover=[mySim getRover:iter];
        UIImageView* newView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rover_image_small"]];
        [newView setFrame:CGRectMake([rover getCurrentX]*tileSizeX, [rover getCurrentY]*tileSizeY, tileSizeX, tileSizeY)];
        [self.viewDisplay addSubview:newView];
        newView.transform=CGAffineTransformMakeRotation([rover getAngle]);
    }
}

- (IBAction)btnReset:(id)sender {
    [mySim resetPositions];
    [self makeView];
}
@end
