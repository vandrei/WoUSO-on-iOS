//
//  BazarViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiHelper.h"

@interface BazarViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) IBOutlet UIView *button1_selected;
@property(strong, nonatomic) IBOutlet UIView *button2_selected;
@property(strong, nonatomic) NSArray * tableContent;
@property(strong, nonatomic) NSArray * spellsCast;
@property (strong, nonatomic) NSArray * spellsOnMe;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property(strong, nonatomic) ApiHelper * helper;

-(IBAction)goBack;
-(IBAction)showBazaar;
-(IBAction)showSummary;

@end
