//
//  ComposeView.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiHelper.h"

@interface ComposeView : UIViewController <UITextViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>

@property (strong,nonatomic) IBOutlet UIButton *sendButton, *cancelButton ;
@property (strong, nonatomic) ApiHelper * apiHelper;
@property (strong, nonatomic) NSString * destinationId;
@property (strong, nonatomic) NSString * receiverName;
@property (strong, nonatomic) NSString * replyTo;
@property (strong, nonatomic) NSString * subject;
@property (strong, nonatomic) IBOutlet UITextField * toField;
@property (strong, nonatomic) IBOutlet UITextField * subjectField;
@property (strong, nonatomic) IBOutlet UITextView * messageField;

-(IBAction)cancel;
-(IBAction)send;
@end
