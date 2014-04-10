//
//  TopViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "TopViewController.h"
#import "UserView.h"

@interface TopViewController ()

@end

@implementation TopViewController

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
-(void)back
{
    [self.navigationController popViewControllerAnimated:(YES)];
}

-(void)button1Presed
{
    
    self.buttonSelected1.hidden=false;
    self.buttonSelected2.hidden=true;
    self.buttonSelected3.hidden=true;
    [self.tableView reloadData];
}

-(void)button2Presed
{
    
    self.buttonSelected1.hidden=true;
    self.buttonSelected2.hidden=false;
    self.buttonSelected3.hidden=true;
    [self.tableView reloadData];
}

-(void)button3Presed
{

    self.buttonSelected1.hidden=true;
    self.buttonSelected2.hidden=true;
    self.buttonSelected3.hidden=false;
    [self.tableView reloadData];
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
    NSString *type = @"";
    if(self.buttonSelected1.hidden == false)
        type = @"TopSeriesCell";
    else if(self.buttonSelected2.hidden == false)
        type = @"TopSeriesCell";
    else
        type = @"TopUsersCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:type];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:type owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.buttonSelected3.hidden==false)
    {
        UserView * controller = [[UserView alloc ] initWithNibName:@"UserView" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
