//
//  MRHomeController.m
//  WorldOfUSO
//
//  Created by Andrei Vasilescu on 9/26/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import "MRHomeController.h"

#import "MRApiHelper.h"

#import "MRImagesBL.h"

@interface MRHomeController () {
    IBOutlet UILabel *levelLabel;
    IBOutlet UILabel *pointsLabel;
    IBOutlet UILabel *goldLabel;
    IBOutlet UILabel *groupLabel;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *pictureImageView;
    
    IBOutlet UIView *menu;
    IBOutlet UIView *menuOverlay;
}

@end

@implementation MRHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults * userDefaults = [[NSUserDefaults alloc] init];
    NSString * oauth_token = [userDefaults objectForKey:@"oauth_token"];
    
    if (oauth_token == nil)
    {
        [self performSegueWithIdentifier:@"segueToLogin" sender:self];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

-(void) loadData
{
    MRApiHelper * helper = [MRApiHelper new];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [helper getUserInfoWithSuccess:^(id response) {
        NSDictionary *userInfo = (NSDictionary *)response;
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
        levelLabel.text = level;
        pointsLabel.text = points;
        goldLabel.text = gold;
        if (![group isKindOfClass:[NSNull class]])
            groupLabel.text = [group objectForKey:@"title"];
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        
        [[MRImagesBL new] requestImageForURL:avatarURL withSuccess:^(UIImage *img) {
            pictureImageView.image = img;
            pictureImageView.layer.cornerRadius = pictureImageView.frame.size.height /2;
            pictureImageView.layer.masksToBounds = YES;
            pictureImageView.layer.borderWidth = 0;
        } andFailure:^(NSError *err) {
            //Does nothing
        }];
    } andFailure:^(NSError *err) {
        [[[UIAlertView alloc] initWithTitle:@"Eroare" message:@"Nu s-a putut face legatura cu serverul!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

-(void)logOut
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"oauth_token"];
    [userDefaults synchronize];
    [menu setHidden:true];
    [menuOverlay setHidden:true];
    
    [self performSegueWithIdentifier:@"segueToLogin" sender:self];
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
