//
//  HomeViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "HomeViewController.h"
#import "BazarViewController.h"

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

-(void)showBazaar
{
    BazarViewController * controller = [[BazarViewController alloc] initWithNibName:@"BazarViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
