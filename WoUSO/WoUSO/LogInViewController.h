//
//  LogInViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 22/02/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView * webView;
@property (strong, nonatomic) NSString * token;
@property (strong, nonatomic) NSString *tokenSecret;


@end
