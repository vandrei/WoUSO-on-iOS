//
//  HomeViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 01/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

-(IBAction)showBazaar;
-(IBAction)showChallenges;
-(IBAction)showMessages;
-(IBAction)showTop;
-(IBAction)showMenu;

@property (strong,nonatomic) IBOutlet UIView * menu ;

@end
