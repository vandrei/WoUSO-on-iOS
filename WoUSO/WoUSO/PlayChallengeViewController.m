//
//  PlayChallengeViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 22/04/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "PlayChallengeViewController.h"

@interface PlayChallengeViewController ()

@end

@implementation PlayChallengeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.helper = [[ApiHelper alloc] init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadChallenge];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadChallenge
{
    self.challenge = [self.helper getChallengeContent:self.challengeId];
    self.time = [self.challenge objectForKey:@"seconds"];
//    self.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
