//
//  RoverDemoTests.m
//  RoverDemoTests
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RoverCell.h"
#import "InputViewController.h"
#import "Rover.h"

@interface RoverDemoTests : XCTestCase

@end

@implementation RoverDemoTests
Simulator* testSim;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Create test objects for the sanitization bits.
    testSim=[Simulator getSimulation];
//    testCell.=testRover;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//There was a situation mid-development where a certain combination of rovers would lead to a collision situation. I've ... addressed ... this.
/*
 Specifically, if a pair of rovers tried to move into each other's locations they could pass each other in the night.
 */
-(void)testBasicCollisionsNoError {
    
    [testSim updateGridWidth:6 andHeight:6];
    [testSim addRoverAtX:0 andY:0 withMoveSet:@"F" andFacing:@"S"];
    [testSim addRoverAtX:0 andY:1 withMoveSet:@"F" andFacing:@"E"];
    [testSim addRoverAtX:1 andY:1 withMoveSet:@"F" andFacing:@"W"];
    [testSim compute];
    XCTAssertTrue([[testSim getRover:0] getCurrentY]==0,@"Failure: Interdicted robot 1 moved!");
    XCTAssertTrue([[testSim getRover:1] getCurrentX]==0,@"Failure: Interdicted robot 2 moved!");
    XCTAssertTrue([[testSim getRover:2] getCurrentX]==1,@"Failure: Interdicted robot 3 moved!");
    
    
}
@end
