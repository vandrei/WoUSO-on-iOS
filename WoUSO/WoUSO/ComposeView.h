//
//  ComposeView.h
//  WoUSO
//
//  Created by Andrei Vasilescu on 29/03/14.
//  Copyright (c) 2014 Rosedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeView : UIViewController

@property (strong,nonatomic) IBOutlet UIButton *sendButton, *cancelButton ;

-(IBAction)cancel;
-(IBAction)send;
@end
