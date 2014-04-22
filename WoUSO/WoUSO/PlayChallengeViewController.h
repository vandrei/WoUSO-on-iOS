//
//  PlayChallengeViewController.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 22/04/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiHelper.h"

@interface PlayChallengeViewController : UIViewController

@property (strong, nonatomic) NSString * challengeId;
@property (nonatomic) NSUInteger time;
@property (strong, nonatomic) ApiHelper * helper;
@property (strong, nonatomic) NSDictionary * challenge;

@end
