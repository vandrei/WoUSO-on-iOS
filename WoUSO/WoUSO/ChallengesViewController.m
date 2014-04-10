//
//  ChallengesViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "ChallengesViewController.h"

@interface ChallengesViewController ()

@end

@implementation ChallengesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.challengeNumber = 0;
    if (self.challengeNumber == 0)
    {
        self.tableView.hidden=true;
        self.labelChallenges.hidden=false;
    }
    else
    {
        self.tableView.hidden=false;
        self.labelChallenges.hidden=true;
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:(YES)];
}
@end
