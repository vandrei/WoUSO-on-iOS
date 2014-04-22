//
//  ChallengesViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiHelper.h"
#import "PlayChallengeViewController.h"

@interface ChallengesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) int challengeNumber;
@property (strong,nonatomic) IBOutlet UILabel *labelChallenges;
@property (strong,nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * sentChallenges;
@property (strong, nonatomic) NSMutableArray * receivedChallenges;
@property (strong, nonatomic) ApiHelper * apiHelper;

-(IBAction) back ;
-(IBAction)cancelChallenge:(id)sender;
-(IBAction)refuseChallenge:(id)sender;
-(IBAction)acceptChallenge:(id)sender;
-(IBAction)playChallenge:(id)sender;


@end
