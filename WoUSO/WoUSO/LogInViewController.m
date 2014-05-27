//
//  LogInViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 22/02/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "LogInViewController.h"
#import "TDOAuth.h"
#import "HomeViewController.h"
#define CALL_BACK_URL @"https://wouso.cs.pub.ro/next/api/oauth/request_token_ready"


@interface LogInViewController ()

@end

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    self.conditie = false;
    self.conditie2 = false;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startOAuthFlow];
}

- (void)startOAuthFlow
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSURLRequest *rq = [TDOAuth URLRequestForPath:@"/request_token/" GETParameters:dict scheme:@"https" host:@"wouso.cs.pub.ro/next/api/oauth" consumerKey:@"key" consumerSecret:@"secret" accessToken:@"" tokenSecret:nil];
    NSURL * url = [NSURL URLWithString:@"https://wouso.cs.pub.ro/"];
//    [rq ]
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:rq  returningResponse:&response error:&error];
    NSString *s = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray *split = [s componentsSeparatedByString:@"&"];
    for (NSString *str in split){
        NSArray *split2 = [str componentsSeparatedByString:@"="];
        [params setObject:split2[1] forKey:split2[0]];
    }
    self.token = params[@"oauth_token"];
    self.tokenSecret = params[@"oauth_token_secret"];
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:self.token forKey:@"oauth_token"];
    [dict2 setObject:@"key" forKey:@"oauth_consumer_key"];
    NSURLRequest *rq2 = [TDOAuth URLRequestForPath:@"/authorize/" GETParameters:dict2 scheme:@"https" host:@"wouso.cs.pub.ro/next/api/oauth" consumerKey:@"key" consumerSecret:@"secret" accessToken:self.token tokenSecret:self.tokenSecret];
    [self.webView loadRequest:rq2];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (self.conditie)
        [webView setHidden:TRUE];
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    if (self.conditie) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        NSURLRequest * rq = [TDOAuth URLRequestForPath:@"/api/info/nickname/" GETParameters:dict host:@"wouso.cs.pub.ro/next" consumerKey:@"key" consumerSecret:@"secret" accessToken:self.token tokenSecret:self.tokenSecret];
        NSError *requestError;
        NSURLResponse* response;
        NSData * d = [NSURLConnection sendSynchronousRequest:rq returningResponse:&response error:&requestError];

        if (requestError != nil)
        {
            [self startOAuthFlow];
            [self.webView setHidden:NO];
        }
        else {
            NSUserDefaults * userDefaults = [[NSUserDefaults alloc] init];
            [userDefaults setObject:self.token forKey:@"oauth_token"];
            [userDefaults setObject:self.tokenSecret forKey:@"oauth_token_secret"];
            [userDefaults synchronize];
            NSURLRequest * rq = [TDOAuth URLRequestForPath:@"info/nickname/" GETParameters:dict host:@"wouso.cs.pub.ro/next/api/" consumerKey:@"key" consumerSecret:@"secret" accessToken:self.token tokenSecret:self.tokenSecret];
            NSError *requestError;
            NSURLResponse* response;
            NSData * data = [NSURLConnection sendSynchronousRequest:rq returningResponse:&response error:&requestError];
            NSError * error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!json && error && [error.domain isEqualToString:NSCocoaErrorDomain] && (error.code == NSPropertyListReadCorruptError)) {
                // Encoding issue, try Latin-1
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
                if (jsonString) {
                    // Need to re-encode as UTF8 to parse, thanks Apple
                    json = [NSJSONSerialization JSONObjectWithData:
                            [jsonString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]
                                                           options:0 error:&error];
                }
            }
            if (self.conditie)
                [self.navigationController popToRootViewControllerAnimated:YES];
            self.conditie = true;
        }
    } else
        self.conditie = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
