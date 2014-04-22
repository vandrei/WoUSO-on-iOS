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
#import "LogInViewController.h"
#import "ApiHelper.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.navigationController.delegate = self;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults * userDefaults = [[NSUserDefaults alloc] init];
    NSString * oauth_token = [userDefaults objectForKey:@"oauth_token"];
//    NSString * oauth_token = nil;
    if (oauth_token == nil)
    {
        LogInViewController * controller = [[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:NO];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void) loadData
{
    ApiHelper * helper = [[ApiHelper alloc] init];
    NSUserDefaults * defaults = [[NSUserDefaults alloc] init];
    NSDictionary * userInfo = [helper getUserInfo];
    NSString * avatarURL = [userInfo objectForKey:@"avatar"];
    NSString * firstName = [userInfo objectForKey:@"first_name"];
    //NSString * userId = [userInfo objectForKey:@"id"];
    //[defaults setObject:userId forKey:@"userId"];
    [defaults setObject:firstName forKey:@"first_name"];
    [defaults synchronize];
    NSString * lastName = [userInfo objectForKey:@"last_name"];
    [defaults setObject:lastName forKey:@"last_name"];
    NSString * level = [[userInfo objectForKey:@"level_no"] stringValue];
    NSString * points = [[userInfo objectForKey:@"points"] stringValue];
    NSString * gold = [[userInfo objectForKey:@"gold"] stringValue];
    NSDictionary * group = [userInfo objectForKey:@"group"];
    self.levelLabel.text = level;
    self.pointsLabel.text = points;
    self.goldLabel.text = gold;
    if (group != [NSNull null])
        self.groupLabel.text = [group objectForKey:@"title"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    UIImage * avatar = [helper getImageForURL:avatarURL];
    self.pictureImageView.image = avatar;
    self.pictureImageView.layer.cornerRadius = self.pictureImageView.frame.size.height /2;
    self.pictureImageView.layer.masksToBounds = YES;
    self.pictureImageView.layer.borderWidth = 0;
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logOut
{
    NSUserDefaults * userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults removeObjectForKey:@"oauth_token"];
    [userDefaults synchronize];
    LogInViewController * controller = [[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil];
    [self.menu setHidden:true];
    [self.menuOverlay setHidden:true];
    [self.navigationController pushViewController:controller animated:YES];
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
    {
        self.menu.hidden = false ;
        self.menuOverlay.hidden = false;
    }
    else
    {
        self.menu.hidden = true ;
        self.menuOverlay.hidden = true;
    }
}
@end
