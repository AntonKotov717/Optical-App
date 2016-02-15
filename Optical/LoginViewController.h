//
//  LoginViewController.h
//  Optical
//
//  Created by Mr.Hwang on 10/7/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ProgressGradientView.h"

@interface LoginViewController : UIViewController
{
    ProgressGradientView *pgv;
    CGFloat progress;
    
    BOOL txt_flag;
    
}
@property (weak, nonatomic) IBOutlet UIView *totalView;

@end
