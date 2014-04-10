//
//  ChallengesViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengesViewController : UIViewController

@property (nonatomic) int challengeNumber;
@property (strong,nonatomic) IBOutlet UILabel *labelChallenges;
@property (strong,nonatomic) IBOutlet UITableView *tableView;

-(IBAction) back ;


@end
