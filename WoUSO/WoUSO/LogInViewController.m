//
//  LogInViewController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 22/02/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "LogInViewController.h"
#import "Source/GTMOAuthAuthentication.h"
#import "Source/GTMOAuthSignIn.h"
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

- (GTMOAuthAuthentication *)myCustomAuth {
    NSString *myConsumerKey = @"abcd";    // pre-registered with service
    NSString *myConsumerSecret = @"efgh"; // pre-assigned by service
    
    GTMOAuthAuthentication *auth;
    auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1
                                                        consumerKey:myConsumerKey
                                                         privateKey:myConsumerSecret];
    
    // setting the service name lets us inspect the auth object later to know
    // what service it is for
    auth.serviceProvider = @"WoUSO 4 iOS";
    
    return auth;
}

- (void)signInToCustomService {
    
    NSURL *requestURL = [NSURL URLWithString:@"http://example.com/oauth/request_token"];
    NSURL *accessURL = [NSURL URLWithString:@"http://example.com/oauth/access_token"];
    NSURL *authorizeURL = [NSURL URLWithString:@"http://example.com/oauth/authorize"];
    NSString *scope = @"http://example.com/scope";
    
    GTMOAuthAuthentication *auth = [self myCustomAuth];
    
    // set the callback URL to which the site should redirect, and for which
    // the OAuth controller should look to determine when sign-in has
    // finished or been canceled
    //
    // This URL does not need to be for an actual web page
    [auth setCallback:@"http://www.example.com/OAuthCallback"];
    
    // Display the autentication view
    GTMOAuthViewControllerTouch *viewController;
    viewController = [[GTMOAuthViewControllerTouch alloc] initWithScope:scope
                                                                language:nil
                                                         requestTokenURL:requestURL
                                                       authorizeTokenURL:authorizeURL
                                                          accessTokenURL:accessURL
                                                          authentication:auth
                                                          appServiceName:@"WoUSO 4 iOS"
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    //[[self navigationController] pushViewController:viewController
                                   //        animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //withings additional params
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
