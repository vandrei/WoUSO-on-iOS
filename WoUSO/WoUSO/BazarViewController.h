//
//  BazarViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BazarViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) IBOutlet UIView *button1_selected;
@property(strong, nonatomic) IBOutlet UIView *button2_selected;

-(IBAction)goBack;
-(IBAction)showBazaar;
-(IBAction)showSummary;
@end
