//
//  MRLoginController.m
//  WorldOfUSO
//
//  Created by Andrei Vasilescu on 9/26/14.
//  Copyright (c) 2014 mReady. All rights reserved.
//

#import "MRLoginController.h"

#import "TDOAuth.h"

#import "MRApiBase.h"

#define CALL_BACK_URL @"https://wouso.cs.pub.ro/next/api/oauth/request_token_ready"

@interface MRLoginController () {
    IBOutlet UIWebView *loginWebView;
    NSString * token;
    NSString *tokenSecret;
    BOOL didLoadWebviewOnce;
}
@end

@implementation MRLoginController

- (void)viewDidLoad {
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
    token = params[@"oauth_token"];
    tokenSecret = params[@"oauth_token_secret"];
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:token forKey:@"oauth_token"];
    [dict2 setObject:@"key" forKey:@"oauth_consumer_key"];
    NSURLRequest *rq2 = [TDOAuth URLRequestForPath:@"/authorize/" GETParameters:dict2 scheme:@"https" host:@"wouso.cs.pub.ro/next/api/oauth" consumerKey:@"key" consumerSecret:@"secret" accessToken:token tokenSecret:tokenSecret];
    [loginWebView loadRequest:rq2];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (didLoadWebviewOnce)
        [webView setHidden:TRUE];
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    if (didLoadWebviewOnce) {
        [super showProgress];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        NSURLRequest * rq = [TDOAuth URLRequestForPath:@"/api/info/nickname/" GETParameters:dict host:@"wouso.cs.pub.ro/next" consumerKey:@"key" consumerSecret:@"secret" accessToken:token tokenSecret:tokenSecret];
        
        [NSURLConnection sendAsynchronousRequest:rq queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *requestError) {
            if (requestError != nil)
            {
                [super hideProgress];
                [self startOAuthFlow];
                [loginWebView setHidden:NO];
            }
            else {
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:token forKey:@"oauth_token"];
                [userDefaults setObject:tokenSecret forKey:@"oauth_token_secret"];
                [userDefaults synchronize];
                
                NSURLRequest * rq = [TDOAuth URLRequestForPath:@"info/nickname/" GETParameters:dict host:@"wouso.cs.pub.ro/next/api/" consumerKey:@"key" consumerSecret:@"secret" accessToken:token tokenSecret:tokenSecret];
                
                [NSURLConnection sendAsynchronousRequest:rq queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    [super hideProgress];
                    
                    NSError *error;
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
                    
                    if (didLoadWebviewOnce) {
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        didLoadWebviewOnce = true;
                    }
                }];
            }
        }];
    } else
        didLoadWebviewOnce = true;
}


@end
