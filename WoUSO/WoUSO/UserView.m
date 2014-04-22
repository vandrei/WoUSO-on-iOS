//
//  UserView.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "UserView.h"
#import "ApiHelper.h"
#import "ComposeView.h"

@interface UserView ()

@end

@implementation UserView

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
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height /2;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.borderWidth = 0;
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void) loadData
{
    ApiHelper * helper = [[ApiHelper alloc] init];
    self.userInfo = [helper getUserInfo:self.userId];
    NSString * firstName = [self.userInfo objectForKey: @"first_name"];
    NSString * lastName = [self.userInfo objectForKey:@"last_name"];
    NSString * name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    NSString * race = [self.userInfo objectForKey:@"race"];
    NSString * level = [[self.userInfo objectForKey:@"level_no"] stringValue];
    NSString* points = [[self.userInfo objectForKey:@"points"] stringValue];
    NSString * imgUrl = [self.userInfo objectForKey:@"avatar"];
    UIImage * img = [helper getImageForURL:imgUrl];
    if ([race isEqualToString:@"CA"])
        self.raceImageView.image = [UIImage imageNamed:@"profiles_ca.png"];
    else if([race isEqualToString:@"CB"])
        self.raceImageView.image = [UIImage imageNamed:@"profiles_cb.png"];
    else
        self.raceImageView.image = [UIImage imageNamed:@"profiles_cc.png"];
    self.nameLabel.text = name;
    self.levelLabel.text = level;
    self.groupLabel.text = points;
    self.avatarImageView.image = img;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendMessage
{
    ComposeView * composeView = [[ComposeView alloc] initWithNibName:@"ComposeView" bundle:nil];
    composeView.destinationId = self.userId;
    composeView.receiverName = self.nameLabel.text;
    [self.navigationController pushViewController:composeView animated:YES];
}

-(void)challenge
{
    ApiHelper * helper = [[ApiHelper alloc] init];
    NSDictionary * result = [helper launchChallengeAgainst:self.userId];
    BOOL status = [[result objectForKey:@"success"] boolValue];
    NSString * mesaj;
    if (!status)
    {
        mesaj = [result objectForKey:@"error"];
        if ([mesaj isEqualToString:@"Player cannot launch"])
        {
            mesaj = @"You can not launch any challenges";
        }
    }
    else
        mesaj = [NSString stringWithFormat:@"You have successfully challenged %@", self.nameLabel.text];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Challenge" message: mesaj
                                                   delegate: nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
