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
    self.helper = [[ApiHelper alloc] init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getTopSeries];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getTopSeries
{
    self.tableContent = [self.helper getTopRaces];
    
}

-(void)getTopGroups
{
    self.tableContent = [self.helper getTopGroups];
}

-(void)getTopUsers
{
    self.tableContent = [self.helper getTopPlayers];
}

-(void)button1Presed
{
    self.buttonSelected1.hidden=false;
    self.buttonSelected2.hidden=true;
    self.buttonSelected3.hidden=true;
    [self getTopSeries];
    [self.tableView reloadData];
}

-(void)button2Presed
{
    self.buttonSelected1.hidden=true;
    self.buttonSelected2.hidden=false;
    self.buttonSelected3.hidden=true;
    [self getTopGroups];
    [self.tableView reloadData];
}

-(void)button3Presed
{
    self.buttonSelected1.hidden=true;
    self.buttonSelected2.hidden=true;
    self.buttonSelected3.hidden=false;
    [self getTopUsers];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableContent.count;
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
    if (self.buttonSelected1.hidden == false)
    {
        NSDictionary * currentRace = [self.tableContent objectAtIndex:indexPath.row];
        NSString * title = [currentRace objectForKey:@"title"];
        NSString * points = [[currentRace objectForKey:@"points"] stringValue];
        UILabel * placeLabel = (UILabel *)[cell viewWithTag:1];
        UILabel * titleLabel = (UILabel *)[cell viewWithTag:2];
        UILabel * pointsLabel = (UILabel *)[cell viewWithTag:3];
        placeLabel.text = [NSString stringWithFormat:@"%ld.", (long)(indexPath.row + 1)];
        titleLabel.text = title;
        pointsLabel.text = points;
    }
    else if(self.buttonSelected2.hidden == false)
    {
        NSDictionary * currentGroup = [self.tableContent objectAtIndex:indexPath.row];
        NSString * title = [currentGroup objectForKey:@"title"];
        NSString * points = [[currentGroup objectForKey:@"points"] stringValue];
        UILabel * placeLabel = (UILabel *)[cell viewWithTag:1];
        UILabel * titleLabel = (UILabel *)[cell viewWithTag:2];
        UILabel * pointsLabel = (UILabel *)[cell viewWithTag:3];
        placeLabel.text = [NSString stringWithFormat:@"%ld.", (long)(indexPath.row + 1)];
        titleLabel.text = title;
        pointsLabel.text = points;
    }
    else
    {
        NSDictionary * currentUsers = [self.tableContent objectAtIndex:indexPath.row];
        NSString * display_name = [currentUsers objectForKey:@"display_name"];
        NSString * points = [[currentUsers objectForKey:@"points"] stringValue];
        NSString * level = [[currentUsers objectForKey:@"level"] stringValue];
        UILabel * placeLabel = (UILabel *)[cell viewWithTag:1];
        UILabel * nameLabel = (UILabel *)[cell viewWithTag:2];
        UILabel * pointsLabel = (UILabel *)[cell viewWithTag:4];
        UILabel * levelLabel = (UILabel *)[cell viewWithTag:3];
        placeLabel.text = [NSString stringWithFormat:@"%ld.", (long)(indexPath.row + 1)];
        nameLabel.text = display_name ;
        pointsLabel.text = points;
        levelLabel.text = level;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.buttonSelected3.hidden==false)
    {
        UserView * userDetail = [[UserView alloc ] initWithNibName:@"UserView" bundle:nil];
        userDetail.userId = [[[self.tableContent objectAtIndex:indexPath.row] objectForKey:@"id"] stringValue];
        [self.navigationController pushViewController:userDetail animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
