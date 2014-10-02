//
//  MRBaseController.m
//  WoUSO
//
//  Created by Andrei Vasilescu on 9/26/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import "MRBaseController.h"

@interface MRBaseController ()

@end

@implementation MRBaseController

- (void)showProgress {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgress {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
