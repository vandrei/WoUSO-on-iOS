//
//  LogInViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 22/02/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "LogInViewController.h"
#import "TDOAuth.h"
#import "GTMOAuthAuthentication.h"
#import "GTMOAuthViewControllerTouch.h"


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
    [self step1];
    //[self signInToCustomService];
    
}
/*
- (GTMOAuthAuthentication *)myCustomAuth {
    NSString *myConsumerKey = @"key";    // pre-registered with service
    NSString *myConsumerSecret = @"secret"; // pre-assigned by service
    
    GTMOAuthAuthentication *auth;
    auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1
                                                        consumerKey:myConsumerKey
                                                         privateKey:myConsumerSecret];
    
    auth.serviceProvider = @"Wouso";
    return auth;
}

- (void)viewController:(GTMOAuthViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuthAuthentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        // Authentication failed
    } else {
        // Authentication succeeded
    }
}

- (void)signInToCustomService {
    
    NSURL *requestURL = [NSURL URLWithString:@"https://wouso.cs.pub.ro/2013/api/oauth/request_token"];
    NSURL *accessURL = [NSURL URLWithString:@"https://wouso.cs.pub.ro/2013/api/oauth/access_token"];
    NSURL *authorizeURL = [NSURL URLWithString:@"https://wouso.cs.pub.ro/2013/api/oauth/authorize"];
    NSString *scope = @"https://wouso.cs.pub.ro/2013/api";
    
    GTMOAuthAuthentication *auth = [self myCustomAuth];
    
    // set the callback URL to which the site should redirect, and for which
    // the OAuth controller should look to determine when sign-in has
    // finished or been canceled
    //
    // This URL does not need to be for an actual web page
    [auth setCallback:@"https://wouso.cs.pub.ro/2013/api/oauth/request_token_ready/"];
    
    // Display the autentication view
    GTMOAuthViewControllerTouch *viewController;
    viewController = [[GTMOAuthViewControllerTouch alloc] initWithScope:scope
                                                                language:nil
                                                         requestTokenURL:requestURL
                                                       authorizeTokenURL:authorizeURL
                                                          accessTokenURL:accessURL
                                                          authentication:auth
                                                          appServiceName:@"Wouso"
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [[self navigationController] pushViewController:viewController
                                           animated:YES];
}
*/


- (void)step1
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"https://wouso.cs.pub.ro/2013/api/oauth/request_token_ready" forKey:@"oauth_callback"];
    [dict setObject:@"key" forKey:@"oauth_consumer_key"];
    NSDate * date = [NSDate date];
    NSTimeInterval timestamp = date.timeIntervalSince1970;
    [dict setObject:[NSString stringWithFormat:@"%d", (int)timestamp] forKey:@"oauth_timestamp"];
    [dict setObject:@"12cdajkndk2u1yedkj3" forKey:@"oauth_nonce"];
    
    //init request
    NSURLRequest *rq = [TDOAuth URLRequestForPath:@"/api/oauth/request_token" GETParameters:dict scheme:@"https" host:@"wouso.cs.pub.ro/2013"
                                      consumerKey:@"key" consumerSecret:@"secret" accessToken:nil tokenSecret:nil];
    
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
    
    self.token = params[@"oauth_token"];
    self.tokenSecret = params[@"oauth_token_secret"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict setObject:@"https://wouso.cs.pub.ro/2013/api/oauth/request_token_ready/" forKey:@"oauth_callback"];
    
    //init request
    NSURLRequest *rq2 = [TDOAuth URLRequestForPath:@"/api/oauth/authorize/" GETParameters:dict2 scheme:@"https" host:@"wouso.cs.pub.ro/2013"
                                       consumerKey:@"key" consumerSecret:@"secret" accessToken:self.token tokenSecret:self.tokenSecret];
    
    [self.webView loadRequest:rq2];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    
    NSString *userId = [self isAuthorizeCallBack];
    if (userId) {
        
        //step 3 - get access token
        [self getAccessTokenForUserId:userId];
    }
    
    //ugly patchup to fix an invalid token bug
    if ([self.webView.request.URL.absoluteString isEqualToString:@"https://wouso.cs.pub.ro/2013/api/oauth/authorize/"])
        [self startOAuthFlow];
}



- (NSString *)isAuthorizeCallBack
{
    NSString *fullUrlString = self.webView.request.URL.absoluteString;
    
    if (!fullUrlString)
        return nil;
    
    NSArray *arr = [fullUrlString componentsSeparatedByString:@"?"];
    if (!arr || arr.count!=2)
        return nil;
    
    if (![arr[0] isEqualToString:@"https://wouso.cs.pub.ro/2013/api/oauth/request_token_ready/"])
        return nil;
    
    NSString *resultString = arr[1];
    NSArray *arr2 = [resultString componentsSeparatedByString:@"&"];
    if (!arr2 || arr2.count!=3)
        return nil;
    
    NSString *userCred = arr2[0];
    NSArray *arr3 = [userCred componentsSeparatedByString:@"="];
    if (!arr3 || arr3.count!=2)
        return nil;
    
    if (![arr3[0] isEqualToString:@"userid"])
        return nil;
    
    return arr3[1];
}

- (void)startOAuthFlow
{
    [self step1];
}

- (void)getAccessTokenForUserId:(NSString *)userId
{
    //step 3 - get access token
    
    //withings additional params
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"https://wouso.cs.pub.ro/2013/api/oauth/request_token_ready/" forKey:@"oauth_callback"];
    [dict setObject:userId forKey:@"userid"];
    
    //init request
    NSURLRequest *rq = [TDOAuth URLRequestForPath:@"/api/oauth/access_token/" GETParameters:dict scheme:@"https" host:@"wouso.cs.pub.ro/2013"
                                      consumerKey:@"key" consumerSecret:@"secret" accessToken:self.token tokenSecret:self.tokenSecret];
    
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
    
    //[self finishedAuthourizationProcessWithUserId:userId AccessToken:params[@"oauth_token"] AccessTokenSecret:params[@"oauth_token_secret"]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
