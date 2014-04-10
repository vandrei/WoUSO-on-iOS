//
//  MessageViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController

@property (strong,nonatomic) IBOutlet UIView *sentOverlay;
@property (strong,nonatomic) IBOutlet UIView *receiveOverlay;
@property (strong,nonatomic) IBOutlet UIView *composeOverlay;

-(IBAction)sentPressed;
-(IBAction)receivedPressed;
-(IBAction)composePressed;
-(IBAction)goBack;
@end
