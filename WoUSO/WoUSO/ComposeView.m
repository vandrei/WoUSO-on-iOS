//
//  ComposeView.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "ComposeView.h"

@interface ComposeView ()

@end

@implementation ComposeView

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
    self.sendButton.layer.borderWidth = 0.0;
    self.sendButton.layer.cornerRadius = 10;
    self.cancelButton.layer.borderWidth = 0.0;
    self.cancelButton.layer.cornerRadius = 10;
    if (self.receiverName != nil)
    {
        self.toField.text = self.receiverName;
        [self.toField setEnabled:NO];
    }
    if (self.subject != nil)
    {
        self.subjectField.text = self.subject;
        [self.subjectField setEnabled:NO];
    }
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.message isEqualToString:@"Mesaj trimis!"])
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)send
{
    NSString * message = self.messageField.text;
    NSString * receiver = self.toField.text;
    NSString * subject = self.subjectField.text;
    BOOL sentOK = false;
    if (message != nil && receiver != nil && self.replyTo == nil)
        sentOK = [self.apiHelper sendMessage:message toReceiver:self.destinationId withSubject:subject];
    else if (message != nil && receiver != nil && self.replyTo != nil)
        sentOK = [self.apiHelper sendMessage:message toReceiver:self.destinationId withSubject:subject asReplyTo:self.replyTo];
    NSString * responseMessage;
    if (sentOK)
        responseMessage = @"Mesaj trimis!";
    else
        responseMessage = @"Mesajul nu a putut fi trimis!";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Mesagerie" message: responseMessage
                                                   delegate: self
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}


@end
