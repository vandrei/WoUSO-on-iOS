//
//  BazarViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "BazarViewController.h"

@interface BazarViewController ()

@end

@implementation BazarViewController

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
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:(YES)];
}

-(void)showBazaar
{
    [self.button1_selected setHidden:(false)];
    [self.button2_selected setHidden:(true)];
}
-(void)showSummary
{
    [self.button1_selected setHidden:(true)];
    [self.button2_selected setHidden:(false)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BazaarCell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BazaarCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
