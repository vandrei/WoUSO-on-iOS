//
//  MessageViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "MessageViewController.h"
#import "ComposeView.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
    [self loadReceivedMessages];
    self.closeButton.layer.borderWidth = 0.0;
    self.closeButton.layer.cornerRadius = 10;
    self.replyButton.layer.borderWidth = 0.0;
    self.replyButton.layer.cornerRadius = 10;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadReceivedMessages
{
    ApiHelper * helper = [[ApiHelper alloc] init];
    self.messages = [helper getReceivedMessages];
    if (self.messages.count == 0)
    {
        [self.tableView setHidden:YES];
        [self.noMsgLabel setHidden:NO];
    }
    else
    {
        [self.tableView setHidden:NO];
        [self.noMsgLabel setHidden:YES];
        self.messages = [[self.messages reverseObjectEnumerator] allObjects];
        [self.tableView reloadData];
    }
}

- (void)loadSentMessages
{
    ApiHelper * helper = [[ApiHelper alloc] init];
    self.messages = [helper getSentMessages];
    if (self.messages.count == 0)
    {
        [self.tableView setHidden:YES];
        [self.noMsgLabel setHidden:NO];
    }
    else
    {
        [self.tableView setHidden:NO];
        [self.noMsgLabel setHidden:YES];
        self.messages = [[self.messages reverseObjectEnumerator] allObjects];
        [self.tableView reloadData];
    }
    
}

-(void)sentPressed
{
    self.sentOverlay.hidden=false;
    self.receiveOverlay.hidden=true;
    self.composeOverlay.hidden=true;
    [self loadSentMessages];
}

-(void)receivedPressed
{
    self.sentOverlay.hidden=true;
    self.receiveOverlay.hidden=false;
    self.composeOverlay.hidden=true;
    [self loadReceivedMessages];
}

-(void)composePressed
{
    
//    self.sentOverlay.hidden=true;
//    self.receiveOverlay.hidden=true;
 //   self.composeOverlay.hidden=false;
    ComposeView *controller = [[ComposeView alloc ] initWithNibName: @"ComposeView" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageListCell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MessageListCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    NSString * name;
    NSString * date = [[self.messages objectAtIndex:indexPath.row] objectForKey:@"date"];
    NSString * subject = [[self.messages objectAtIndex:indexPath.row] objectForKey:@"subject"];
    if (self.sentOverlay.hidden == true)
        name = [[self.messages objectAtIndex:indexPath.row] objectForKey:@"from"];
    else
        name = [[self.messages objectAtIndex:indexPath.row] objectForKey:@"to"];
    UILabel * nameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel * subjectLabel = (UILabel *)[cell viewWithTag:2];
    UILabel * dateLabel = (UILabel *)[cell viewWithTag:3];
    UILabel * line1 = (UILabel *)[cell viewWithTag:4];
    UILabel * line2 = (UILabel *)[cell viewWithTag:5];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    date = [date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate * d = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"dd.MM.YYYY";
    NSDate * today = [NSDate date];
    NSString * todayString = [dateFormatter stringFromDate:today];
    date = [dateFormatter stringFromDate:d];
    if ([date isEqualToString:todayString])
    {
        dateFormatter.dateFormat = @"HH:mm";
        date = [dateFormatter stringFromDate:d];
    }
    BOOL read = [[[self.messages objectAtIndex:indexPath.row] objectForKey:@"read"] boolValue];
    if (read == false)
    {
        nameLabel.textColor = [UIColor orangeColor];
        subjectLabel.textColor = [UIColor orangeColor];
        dateLabel.textColor = [UIColor orangeColor];
        line1.textColor = [UIColor orangeColor];
        line2.textColor = [UIColor orangeColor];
    }
    nameLabel.text = name;
    subjectLabel.text = subject;
    dateLabel.text = date;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentMessage = indexPath.row;
    NSString * message = [[self.messages objectAtIndex:indexPath.row] objectForKey:@"text"];
    if (message == nil)
    {
        message = @"Empty message";
        self.messageText.textColor = [UIColor redColor];
    }
    self.messageText.text = message;
    //[self.messageText sizeToFit];
    [self showMessage];
    BOOL read = [[[self.messages objectAtIndex:indexPath.row] objectForKey:@"read"] boolValue];
    NSString * messageId = [[[self.messages objectAtIndex:indexPath.row] objectForKey:@"id"] stringValue];
    if (read == false && self.receiveOverlay.isHidden == false)
    {
        ApiHelper * helper = [[ApiHelper alloc] init];
        [helper markReadMessage:messageId];
        [self loadReceivedMessages];
    }
}

-(void)showMessage
{
    [self.viewMessageOverlay setHidden:NO];
    [self.viewMessage setHidden:NO];
    [self.closeButton setHidden:NO];
    if (self.receiveOverlay.isHidden == false)
        [self.replyButton setHidden:NO];
}

-(void)hideMessage
{
    [self.viewMessageOverlay setHidden:YES];
    [self.viewMessage setHidden:YES];
    [self.closeButton setHidden:YES];
    [self.replyButton setHidden:YES];
}

-(void)closePressed
{
    [self hideMessage];
    [self.viewMessageOverlay setHidden:TRUE];
}

-(void)replyPressed
{
    ComposeView * compose = [[ComposeView alloc] initWithNibName:@"ComposeView" bundle:nil];
    compose.replyTo = [[[self.messages objectAtIndex:self.currentMessage] objectForKey:@"id"] stringValue];
    compose.receiverName = [[self.messages objectAtIndex:self.currentMessage] objectForKey:@"from"];
    compose.destinationId = [[[self.messages objectAtIndex:self.currentMessage] objectForKey:@"from_id"] stringValue];
    NSString * messageSubject = [[self.messages objectAtIndex:self.currentMessage] objectForKey:@"subject"];
    compose.subject = [NSString stringWithFormat:@"Re: %@", messageSubject];
    [self.navigationController pushViewController:compose animated:YES];
}

@end
