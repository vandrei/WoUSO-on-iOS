//
//  HomeViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UINavigationControllerDelegate>

-(IBAction)showBazaar;
-(IBAction)showChallenges;
-(IBAction)showMessages;
-(IBAction)showTop;
-(IBAction)showMenu;
-(IBAction)logOut;

@property (strong,nonatomic) IBOutlet UIView * menu ;
@property (strong,nonatomic) IBOutlet UIView * menuOverlay ;
@property (strong, nonatomic) IBOutlet UILabel * levelLabel;
@property (strong, nonatomic) IBOutlet UILabel * pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel * goldLabel;
@property (strong, nonatomic) IBOutlet UILabel * groupLabel;
@property (strong, nonatomic) IBOutlet UILabel * nameLabel;
@property (strong, nonatomic) IBOutlet UILabel * spellsLabel;
@property (strong, nonatomic) IBOutlet UIImageView * pictureImageView;

@end
