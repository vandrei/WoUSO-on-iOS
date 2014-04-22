//
//  UserView.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserView : UIViewController

@property (strong, nonatomic) NSString * userId;
@property (strong,nonatomic) IBOutlet UILabel * nameLabel;
@property (strong,nonatomic) IBOutlet UILabel * levelLabel;
@property (strong,nonatomic) IBOutlet UILabel * seriesLabel;
@property (strong,nonatomic) IBOutlet UILabel * groupLabel;
@property (strong, nonatomic) IBOutlet UIImageView *  avatarImageView;
@property (strong, nonatomic) IBOutlet UIImageView * raceImageView;
@property (strong, nonatomic) NSDictionary * userInfo;


-(IBAction)goBack;
-(IBAction)sendMessage;
-(IBAction)challenge;
@end
