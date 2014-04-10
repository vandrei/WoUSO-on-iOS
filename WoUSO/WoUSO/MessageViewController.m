//
//  MessageViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "MessageViewController.h"
#import "ComposeView.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sentPressed
{
    
    self.sentOverlay.hidden=false;
    self.receiveOverlay.hidden=true;
    self.composeOverlay.hidden=true;
}

-(void)receivedPressed
{
    
    self.sentOverlay.hidden=true;
    self.receiveOverlay.hidden=false;
    self.composeOverlay.hidden=true;
}

-(void)composePressed
{
    
//    self.sentOverlay.hidden=true;
//    self.receiveOverlay.hidden=true;
 //   self.composeOverlay.hidden=false;
    ComposeView *controller = [[ComposeView alloc ] initWithNibName: @"ComposeView" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
