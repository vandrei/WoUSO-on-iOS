//
//  TopViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiHelper.h"

@interface TopViewController : UIViewController

-(IBAction)back;
-(IBAction)button1Presed;
-(IBAction)button2Presed;
-(IBAction)button3Presed;

@property (strong,nonatomic) IBOutlet UIView *buttonSelected1;
@property (strong,nonatomic) IBOutlet UIView *buttonSelected2;
@property (strong,nonatomic) IBOutlet UIView *buttonSelected3;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) NSArray * tableContent;
@property (strong, nonatomic) ApiHelper * helper;

@end
