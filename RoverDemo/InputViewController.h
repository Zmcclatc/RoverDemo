//
//  FirstViewController.h
//  RoverDemo
//
//  Created by Zoe M on 5/21/15.
//  Copyright (c) 2015 Zoe M. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)btnAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtGridHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtGridWidth;
- (IBAction)txtGridWidthChanged:(id)sender;
- (IBAction)txtHeightChanged:(id)sender;


@end

