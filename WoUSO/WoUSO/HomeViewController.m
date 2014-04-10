//
//  HomeViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "HomeViewController.h"
#import "BazarViewController.h"
#import "TopViewController.h"
#import "MessageViewController.h"
#import "ChallengesViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showTop
{
    TopViewController * controller = [[TopViewController alloc] initWithNibName:@"TopViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)showBazaar
{
    BazarViewController * controller = [[BazarViewController alloc] initWithNibName:@"BazarViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)showChallenges
{
    ChallengesViewController * controller = [[ChallengesViewController alloc] initWithNibName:@"ChallengesViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)showMessages
{
    MessageViewController * controller = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)showMenu
{
    if(self.menu.hidden == true)
        self.menu.hidden = false ;
    else
        self.menu.hidden = true ;
}
@end
