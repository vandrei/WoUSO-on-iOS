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
    self.apiHelper = [[ApiHelper alloc] init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.challengeNumber = 0;
    [self loadChallenges];
}



- (void)loadChallenges
{
    NSArray * challenges = [self.apiHelper getAllChallenges];
    if (challenges.count == 0)
    {
        self.tableView.hidden=true;
        self.labelChallenges.hidden=false;
    }
    else
    {
        self.tableView.hidden=false;
        self.labelChallenges.hidden=true;
        self.receivedChallenges = [[NSMutableArray alloc] init];
        self.sentChallenges = [[NSMutableArray alloc] init];
        for (int i = 0; i < challenges.count; i++)
        {
            NSDictionary * currentChallenge = [challenges objectAtIndex:i];
            NSString * fromName = [currentChallenge objectForKey:@"user_from"];
            NSUserDefaults * userDef = [[NSUserDefaults alloc] init];
            NSString *first_name = [userDef objectForKey:@"first_name"];
            NSString * last_name = [userDef objectForKey:@"last_name"];
            NSString * name = [NSString stringWithFormat:@"%@ %@", first_name, last_name];
            if ([name isEqualToString:fromName])
                [self.sentChallenges addObject:currentChallenge];
            else
                [self.receivedChallenges addObject:currentChallenge];
        }
    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.sentChallenges.count == 0) {
            return 1;
        }
        else {
            return self.sentChallenges.count;
        }
    }
    if (self.receivedChallenges.count == 0)
        return 1;
    else
        return self.receivedChallenges.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellType;
    if (indexPath.section == 0)
        cellType = @"MyChallengeCell";
    else
        cellType = @"ChallengeList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellType owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    UILabel * oponentNameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel * dateLabel = (UILabel *)[cell viewWithTag:2];
    UIButton * acceptButton = (UIButton *)[cell viewWithTag:3];
    UIButton * cancelButton = (UIButton *)[cell viewWithTag:4];
    acceptButton.layer.borderWidth = 0.0;
    acceptButton.layer.cornerRadius = 10;
    cancelButton.layer.borderWidth = 0.0;
    cancelButton.layer.cornerRadius = 10;
    NSString * oponentName;
    NSString * date;
    NSString * state;
    if (indexPath.section == 0)
    {
        if (self.sentChallenges.count == 0)
        {
            [acceptButton setHidden:true];
            [cancelButton setHidden:true];
            oponentName = @"No challenges!";
        }
        else
        {
            acceptButton.tag = 10000 + indexPath.row;
            cancelButton.tag = 10000 + indexPath.row;
            oponentName = [[self.sentChallenges objectAtIndex:indexPath.row] objectForKey:@"user_to"];
            date = [[self.sentChallenges objectAtIndex:indexPath.row] objectForKey:@"date"];
            state = [[self.sentChallenges objectAtIndex:indexPath.row] objectForKey:@"status"];
            if ([state isEqualToString:@"L"])
                [acceptButton setHidden:TRUE];
        }
    }
    else
    {
        if (self.receivedChallenges.count == 0)
        {
            [acceptButton setHidden:true];
            [cancelButton setHidden:true];
            oponentName = @"No challenges!";
        }
        else
        {
            acceptButton.tag = 20000 + indexPath.row;
            cancelButton.tag = 20000 + indexPath.row;
            oponentName = [[self.receivedChallenges objectAtIndex:indexPath.row] objectForKey:@"user_from"];
            date = [[self.receivedChallenges objectAtIndex:indexPath.row] objectForKey:@"date"];
        }
    }
    date = [date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate * d = [df dateFromString:date];
    df.dateFormat = @"dd.MM.YYYY";
    date = [df stringFromDate:d];
    NSDate * today = [NSDate date];
    NSString * todayString = [df stringFromDate:today];
    if ([todayString isEqualToString:date])
    {
        df.dateFormat = @"HH:mm";
        date = [df stringFromDate:d];
    }
    oponentNameLabel.text = oponentName;
    dateLabel.text = date;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ChallengesListHeader" owner:self options:nil];
    UIView* header = [topLevelObjects objectAtIndex:0];
    UILabel * headerText = (UILabel *)[header viewWithTag:1];
    if (section == 0)
        headerText.text = @"Challenges you launched";
    else
        headerText.text = @"Challenges others launched";
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)acceptChallenge:(id)sender
{
    NSUInteger index = ((UIButton *)sender).tag;
    index -= 20000;
    NSDictionary * currentChallenge = [self.receivedChallenges objectAtIndex:index];
    NSString * challengeId = [[currentChallenge objectForKey:@"id"] stringValue];
    NSDictionary * response = [self.apiHelper acceptChallengeWithId:challengeId];
    NSString * msg;
    BOOL result = [[response objectForKey:@"success"] boolValue];
    if (!result)
        msg = [response objectForKey:@"error"];
    else
    {
        msg = @"Challenge accepted!";
        [self loadChallenges];
        [self.tableView reloadData];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Challenges" message: msg
                                                   delegate: nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)refuseChallenge:(id)sender
{
    NSUInteger index = ((UIButton *)sender).tag;
    index -= 20000;
    NSString * challengeId = [[[self.receivedChallenges objectAtIndex:index] objectForKey:@"id"] stringValue];
    NSDictionary * response = [self.apiHelper refuseChallengeWithId:challengeId];
    NSString * msg;
    BOOL result = [[response objectForKey:@"success"] boolValue];
    if (!result)
        msg = [response objectForKey:@"error"];
    else
    {
        msg = @"Challenge refused!";
        [self loadChallenges];
        [self.tableView reloadData];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Challenges" message: msg
                                                   delegate: nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)cancelChallenge:(id)sender
{
    NSUInteger index = ((UIButton *)sender).tag;
    index -=10000;
    NSString * challengeId = [[[self.sentChallenges objectAtIndex:index] objectForKey:@"id"] stringValue];
    NSDictionary * response = [self.apiHelper cancelChallengeWithId:challengeId];
    NSString * msg;
    BOOL result = [[response objectForKey:@"success"] boolValue];
    if (!result)
        msg = [response objectForKey:@"error"];
    else
    {
        msg = @"Challenge canceled!";
        [self loadChallenges];
        [self.tableView reloadData];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Challenges" message: msg
                                                   delegate: nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)playChallenge:(id)sender
{
    NSUInteger index = ((UIButton *)sender).tag;
    NSString * challenge;
    if (index / 10000 == 1)
        challenge = [[[self.sentChallenges objectAtIndex:(index - 10000)] objectForKey:@"id"] stringValue];
    else
        challenge = [[[self.receivedChallenges objectAtIndex:(index - 20000)] objectForKey:@"id"] stringValue];
    index -=10000;
    PlayChallengeViewController * play = [[PlayChallengeViewController alloc] initWithNibName:@"PlayChallengeViewController" bundle:nil];
    play.challengeId = challenge;
    [self.navigationController pushViewController:play animated:YES];
}

@end
