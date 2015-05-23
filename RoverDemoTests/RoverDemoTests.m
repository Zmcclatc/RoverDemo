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
Rover* testRover;
RoverCell* testCell;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Create test objects for the sanitization bits.
    testRover=[[Rover alloc]initWithXCoord:4 andYcoord:4 andMoveSet:@"FFF" andFacing:@"S"];
    testCell=[[RoverCell alloc] init];
//    testCell.=testRover;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//Make sure all the regular expression engines are properly configured.
-(void)testInputSanitization {
    
    //We test this assertion by checking if the test successfully changed
    //any values in the rover. (Or if a popup appears, which shouldn't happen)
    testCell.txtStartingLoc.text=@"";
    [testCell txtStartLocChanged:testCell.txtStartingLoc];
    XCTAssertTrue([testRover.moveString isEqual:@""],@"Failure with blank text.");
    
    testCell.txtStartingLoc.text=@"3:3:S";
    [testCell txtStartLocChanged:testCell.txtStartingLoc];
    XCTAssertTrue([testRover getStartX] ==3,@"Failure with correct characters: X.");
    XCTAssertTrue([testRover getStartY] ==3,@"Failure with correct characters: Y.");
    XCTAssertTrue([[testRover getFacing] isEqual:@"S"],@"Failure with correct characters: Direction.");
    
}
-(void)testExtendedInput
{
    testCell.txtStartingLoc.text=@"32:31:South";
    [testCell txtStartLocChanged:testCell.txtStartingLoc];
    XCTAssertFalse([testRover getStartX] ==3,@"Failure with correct characters: X.");
    XCTAssertFalse([testRover getStartY] ==3,@"Failure with correct characters: Y.");
    XCTAssertTrue([[testRover getFacing] isEqual:@"S"],@"Failure with correct characters: Direction.");
    
    
    testCell.txtStartingLoc.text=@"A:3:S";
    [testCell txtStartLocChanged:testCell.txtStartingLoc];
    XCTAssertFalse([testRover.moveString isEqual:@"FAR"],@"Failure with bad location characters.");
}
@end
