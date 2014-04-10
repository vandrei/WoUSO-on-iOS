//
//  ComposeView.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "ComposeView.h"

@interface ComposeView ()

@end

@implementation ComposeView

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
    self.sendButton.layer.borderWidth = 0.0;
    self.sendButton.layer.cornerRadius = 10;
    self.cancelButton.layer.borderWidth = 0.0;
    self.cancelButton.layer.cornerRadius = 10;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)send
{
    [self cancel];
}


@end
