//
//  LogInViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 22/02/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

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
    //withings additional params
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:CALL_BACK_URL forKey:@"oauth_callback"];
    
    //init request
    NSURLRequest *rq = [TDOAuth URLRequestForPath:@"/request_token" GETParameters:dict scheme:@"https" host:@"oauth.withings.com/account" consumerKey:WITHINGS_OAUTH_KEY consumerSecret:WITHINGS_OAUTH_SECRET accessToken:nil tokenSecret:nil];
    
    //fire request
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:rq  returningResponse:&response error:&error];
    NSString *s = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    //parse result
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *split = [s componentsSeparatedByString:@"&"];
    for (NSString *str in split){
        NSArray *split2 = [str componentsSeparatedByString:@"="];
        [params setObject:split2[1] forKey:split2[0]];
    }
    
    NSString * token = params[@"oauth_token"];
    NSString * tokenSecret = params[@"oauth_token_secret"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
