//
//  LoginViewController.m
//  Optical
//
//  Created by Mr.Hwang on 10/7/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"

@interface LoginViewController ()
{
    NSInteger counter;
    NSTimer *timer;
}


@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signinlbl;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *wrongInfo;
@property (weak, nonatomic) IBOutlet UIView *loadingVw;
@property (weak, nonatomic) IBOutlet UILabel *waitlbl;
@property (weak, nonatomic) IBOutlet UILabel *synclbl;

@end

@implementation LoginViewController
@synthesize totalView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.signinlbl.layer.cornerRadius = 5.0;
    self.closeBtn.hidden = YES;
    self.wrongInfo.hidden = YES;
    
    self.loadingVw.hidden = YES;
    
    counter = 0;
    
    UIGestureRecognizer *singleTapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:singleTapRecognizer];
    
    pgv=[[ProgressGradientView alloc] initWithFrame:CGRectMake(self.synclbl.frame.origin.x, self.synclbl.frame.origin.y+45, 350, 15)];
    pgv.layer.cornerRadius = 6.0;
    
    [self.loadingVw addSubview:pgv];
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    self.loadingVw.hidden = YES;
    
    counter = 0; progress = 0.0;
    
    [pgv setProgress:progress];
    
    [self.signinlbl setBackgroundColor:[UIColor colorWithRed:37.0f / 255.0f green:170.0f / 255.0f blue:225.0f / 255.0f alpha:1.0f]];
    
    [timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationTimerFired:(NSTimer*)theTimer {
    int re=rand()%10;
    if (re==2) {
        progress+=0.09;
        [pgv setProgress:progress];
        
        counter++;
        
        if(counter > 15)
        {
            [timer invalidate];
            
            HomeViewController *sub = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            [self.navigationController pushViewController:sub animated:YES];
        }
    }
}

- (void)dismissKeyboard {
    
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    
    if(txt_flag)
    {
        NSTimeInterval animationDuration = 0.3;
        CGRect frame = totalView.frame;
        frame.origin.y += 170;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        totalView.frame = frame;
        [UIView commitAnimations];
        
        txt_flag = NO;
        
    }
}

- (IBAction)signinBtn:(id)sender {
 
    [self dismissKeyboard];
    
    [self.signinlbl setBackgroundColor:[UIColor colorWithRed:220.0f / 255.0f green:220.0f / 255.0f blue:220.0f / 255.0f alpha:1.0f]];
    //self.wrongInfo.hidden = NO;
    
    
    [UIView transitionWithView: self.loadingVw
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        self.loadingVw.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                        
                    }
     ];
    
    timer =   [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(animationTimerFired:) userInfo:nil repeats:YES];
}

- (IBAction)needhelpBtn:(id)sender {
}

- (IBAction)closeclick:(id)sender {
    
    self.username.text = @"";
    [self.username resignFirstResponder];
    self.closeBtn.hidden = YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if(!txt_flag)
    {
        
        NSTimeInterval animationDuration = 0.3;
        CGRect frame = totalView.frame;
        frame.origin.y -= 170;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        totalView.frame = frame;
        
        [UIView commitAnimations];
        txt_flag = YES;
        
    }
    return TRUE;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(txt_flag)
    {
        NSTimeInterval animationDuration = 0.3;
        CGRect frame = totalView.frame;
        frame.origin.y += 170;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        totalView.frame = frame;
        [UIView commitAnimations];
        
        txt_flag = NO;
        
    }
    
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField.tag == 100)
    {
        if([textField.text length]-1 == 0)
        {
            if([string isEqualToString:@""])
              self.closeBtn.hidden = YES;
        }
        else
        {
            
            self.closeBtn.hidden = NO;
            
        }
    }
    
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}
@end
