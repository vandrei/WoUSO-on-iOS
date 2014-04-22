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
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) IBOutlet UILabel * noMsgLabel;
@property (strong, nonatomic) IBOutlet UIView *viewMessageOverlay;
@property (strong, nonatomic) IBOutlet UIView *viewMessage;
@property (strong, nonatomic) IBOutlet UITextView * messageText;
@property (strong, nonatomic) IBOutlet UIButton * closeButton;
@property (strong, nonatomic) IBOutlet UIButton * replyButton;
@property (nonatomic) NSInteger currentMessage;
@property (strong, nonatomic) NSArray * messages;

-(IBAction)sentPressed;
-(IBAction)closePressed;
-(IBAction)replyPressed;
-(IBAction)receivedPressed;
-(IBAction)composePressed;
-(IBAction)goBack;
@end
