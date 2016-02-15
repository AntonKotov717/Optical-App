//
//  HomeViewController.m
//  Optical
//
//  Created by Mr.Hwang on 10/12/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import "HomeViewController.h"
#import "SmoothLineView.h"
#import <UIKit/UIKit.h>

///////// From Anatoli
int xPos, yPos;

typedef NS_ENUM(NSInteger, MMSpinViewDirection) {
    MMSpinViewDirectionForward,
    MMSpinViewDirectionBackward,
    MMSpinViewDirectionUp,
    MMSpinViewDirectionDown,
    MMSpinViewDirectionMax = 999
};
/////////

@interface HomeViewController ()
{
    NSInteger counter;
    NSTimer *timer;
    UIPanGestureRecognizer *panGesture;
    UIPinchGestureRecognizer *pinchGestureReconnizer;
    
    NSInteger smallpenColor_Index;
    NSInteger smallpenThick_Index;
}

//Drawing
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat selectedWidth;
@property (weak, nonatomic) IBOutlet SmoothLineView *drawerView;
@property (weak, nonatomic) IBOutlet SmoothLineView *drawerFaqsView;

@property (nonatomic, strong) UIColor *selectedSmallColor;
@property (nonatomic, assign) CGFloat selectedSmallWidth;

///////// From Anatoli
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *dataSource_label;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, assign) CGPoint   touchPoint;
@property (nonatomic, assign) NSInteger xtouchIndex;
@property (nonatomic, assign) NSInteger ytouchIndex;
@property (nonatomic, assign) double panDistance;
@property (nonatomic, assign) MMSpinViewDirection direction;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger preIndex;

@property (nonatomic, assign) bool is_gesture_start;
/////////

@end

@implementation HomeViewController

@synthesize patientlbl, eyelbl,FAQslbl, aboutuslbl, summarylbl, followuplbl, lineVw;
@synthesize totalscrollVw,patientVw,eyeVw,FAQsVw,aboutusVw,summary,followupVw;
@synthesize FAQscrollVw, FAQs_pageVw, aboutscrollVw;
@synthesize smalleyeBtnlbl, smallpenBtnlbl, smallpenColorBtnlbl, smallpenThickBtnlbl, trademarkImgVw;

@synthesize summary_totalVw, summary_continuelbl,myopialbl, patient_continueBtnlbl;
@synthesize follow_totalVw, follow_completelbl,subVw1,subVw2, lastVw, candilbl, sendmaillbl;
@synthesize countxt, patfirstName, patlastName, patient_totalVw;
@synthesize recommentlbl1, recommentlbl2, emailtxt, addreftxt, pricetxt1, pricetxt2;
@synthesize eyepageBtnlbl, eyepageCameralbl,eyepageDownarrowlbl,eyepagehintBtnlbl,eyepagePenBtnlbl, eyepageTitleBtnlbl,eyepagetotalVw, eyepageImageVw,eyepageCloseBtnlbl,eyePenColorBtnlbl,eyepenThickBtnlbl;
@synthesize summary_datelbl, follow_datelbl;
@synthesize menu_logout, menuImgTimer, menuScheduTimer, menuView, usernamelbl, menuhiddenView;
@synthesize select_closeBtnlbl, select_Titlelbl, select_totalVw, follow_eyes1lbl, follow_eyes2lbl,follow_refeBtnlbl,follow_selTableVw, Calendar_Titlelbl, select_CalendarVw, preopBtnlbl, surgeryBtnlbl;
@synthesize waitlbl, uploadinglbl, loadingView;

@synthesize drawerView;
@synthesize drawerFaqsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    ///////// Anatoli
    
    [self init_dataSource_gestureRecognizer];
    drawerView.hidden = YES;
    
    self.selectedColor = [UIColor colorWithRed:41.0f / 255.0f green:121.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f]; // bluecolor
    self.selectedWidth = 5.0f;
    [self.drawerView setLineColor:self.selectedColor];
    [self.drawerView setLineWidth:self.selectedWidth];
    
    
    self.selectedSmallColor = [UIColor colorWithRed:41.0f / 255.0f green:121.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f]; // bluecolor
    self.selectedSmallWidth = 5.0f;
    
    drawerFaqsView.hidden = YES;
    [self.drawerFaqsView setLineColor:self.selectedSmallColor];
    [self.drawerFaqsView setLineWidth:self.selectedSmallWidth];
    
    /////////
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:250.0f / 255.0f green:250.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f]];
    
    pagenumber = 0; lastpagenumber = 0;
    
    totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height-140);
    
    UIGestureRecognizer *singleTapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:singleTapRecognizer];
    
    [self home_page_Init];
    [self patient_page_Init];
    [self eye_page_Init];
    [self FAQs_About_page_Init];
    [self summary_page_Init];
    [self follow_page_Init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    menuView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissKeyboard {
    
    [patfirstName resignFirstResponder];
    [patlastName resignFirstResponder];
    
    [emailtxt resignFirstResponder];
    [addreftxt resignFirstResponder];
    [pricetxt1 resignFirstResponder];
    [pricetxt2 resignFirstResponder];
    
    if(txt_flag)
    {
        NSTimeInterval animationDuration = 0.3;
        CGRect frame = patient_totalVw.frame;
        CGRect frame1 = follow_totalVw.frame;
        frame.origin.y += 100;
        if(!recomment1_flag&&!recomment2_flag&&!recomment3_flag&&!recomment4_flag)
            frame1.origin.y += 50;
        else
            frame1.origin.y += 190;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        patient_totalVw.frame = frame;
        follow_totalVw.frame = frame1;
        [UIView commitAnimations];
        
        txt_flag = NO;
    }
}

////////////////////////////////////////////  Home page  ////////////////////////////////////////////

-(void) home_page_Init
{
    menuhiddenView.hidden = YES;
    
    patientlbl.enabled = NO;
   // eyelbl.enabled = NO; FAQslbl.enabled = NO; aboutuslbl.enabled = NO; summarylbl.enabled = NO; followuplbl.enabled = NO;
    
    eyelbl.hidden = YES;FAQslbl.hidden = YES;aboutuslbl.hidden = YES;summarylbl.hidden = YES;followuplbl.hidden = YES;
    
    UIGestureRecognizer *singleTapRecognizer1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuhiddenfunc)];
    [menuhiddenView addGestureRecognizer:singleTapRecognizer1];
}

-(void)menuhiddenfunc
{
  
     menuhiddenView.hidden = YES;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         
                         menuView.frame = CGRectMake(-231, 0, menuView.frame.size.width, menuView.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         
                         NSLog(@"Close !!!!!");
                     }];
    
}

- (IBAction)menuBtn_click:(id)sender {
    
    menuView.hidden = NO;
    
    menuhiddenView.hidden = NO;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         
                         menuView.frame = CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         
                         NSLog(@"Open !!!!!");
                     }];
}


- (IBAction)menu_logoutBtn_click:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/////////////////////////////////////////////////////  Patient page  ////////////////////////////////////////////

-(void) patient_page_Init
{
    [totalscrollVw setScrollEnabled:NO];
    
    trademarkImgVw.hidden = YES;  smallpenBtnlbl.hidden = YES;  smalleyeBtnlbl.hidden = YES; patient_flag = YES;
    
    smallpenColorBtnlbl.hidden = YES;
    [smallpenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"smallPen_bluecolor.png"] forState:UIControlStateNormal];
    smallpenColor_Index = 0;
    
    smallpenThickBtnlbl.hidden = YES;
    smallpenThickBtnlbl.backgroundColor = [UIColor colorWithRed:41.0f / 255.0f green:121.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f];
    smallpenThick_Index = 0;
    
    patient_continueBtnlbl.layer.cornerRadius = 5.0;
    
    patient_continueBtnlbl.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sel_Doctor:) name:@"SelectDoctor" object:nil];
    
    UIGestureRecognizer *singleTapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCounselorVw)];
    [countxt addGestureRecognizer:singleTapRecognizer];
    
    
    counselorVw = [[[NSBundle mainBundle] loadNibNamed:@"SelectCounsel"
                                                owner:self
                                              options:nil] objectAtIndex:0];
    
    counselorVw.frame = CGRectMake(0, 0,  counselorVw.frame.size.width, counselorVw.frame.size.height);
    [counselorVw.counColseBtnlbl addTarget:self action:@selector(closecounselor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:counselorVw];
    
        
    counselorVw.hidden = YES;

}

-(void)sel_Doctor:(NSNotification *)userinfo
{
    countxt.text = userinfo.userInfo[@"doctorName"];
    
    NSLog(@"datainfo = %@", userinfo.userInfo);
    
    [self closecounselor];
}

-(void)showCounselorVw
{
    [UIView transitionWithView: counselorVw
                      duration: 0.2
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        counselorVw.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                        
                        
                    }
     ];
}

-(void)closecounselor
{
    [UIView transitionWithView: counselorVw
                      duration: 0.2
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        counselorVw.hidden = YES;
                    }
                    completion:^(BOOL finished) {
                        
                        
                    }
     ];
}

- (IBAction)patient_continue_click:(id)sender {
    
    if(![countxt.text isEqualToString:@""]&&![patfirstName.text isEqualToString:@""]&&![patlastName.text isEqualToString:@""])
    {
    
    
        patientlbl.enabled = YES;
        
        //eyelbl.enabled = YES; FAQslbl.enabled = YES; aboutuslbl.enabled = YES; summarylbl.enabled = YES;followuplbl.enabled = YES;
        
        eyelbl.hidden = NO;FAQslbl.hidden = NO;aboutuslbl.hidden = NO;summarylbl.hidden = NO;followuplbl.hidden = NO;
    
        [patfirstName resignFirstResponder];
        [patlastName resignFirstResponder];
        
        if(txt_flag)
        {
            NSTimeInterval animationDuration = 0.3;
            CGRect frame = patient_totalVw.frame;
            CGRect frame1 = follow_totalVw.frame;
            frame.origin.y += 100;
            if(!recomment1_flag&&!recomment2_flag&&!recomment3_flag&&!recomment4_flag)
                frame1.origin.y += 50;
            else
                frame1.origin.y += 190;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            patient_totalVw.frame = frame;
            follow_totalVw.frame = frame1;
            [UIView commitAnimations];
            
            
        }
    
        patient_flag = NO; eyeVw.hidden = NO; txt_flag = NO;
        totalscrollVw.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        eyeVw.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height);
        
        [totalscrollVw setScrollEnabled:NO];
        
        trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = YES; FAQs_pageVw.hidden = YES;
        
        [patientlbl setTitleColor:[UIColor colorWithRed:200.0f / 255.0f green:200.0f / 255.0f blue:200.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        UIButton* btnC;
        btnC = (UIButton*)[self.view viewWithTag:11];
        [btnC setTitleColor:[UIColor colorWithRed:15.0f / 255.0f green:89.0f / 255.0f blue:153.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [totalscrollVw setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
                             [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Open !!!!!");
                         }];
        
    }
    else
    {
        return;
        
    }
    
    
}



/////////////////////////////////////////////////////  Eye page  ////////////////////////////////////////////

-(void) eye_page_Init
{
 
    eyepagetotalVw.hidden = YES; eyePenColorBtnlbl.hidden = YES; eyepenThickBtnlbl.hidden = YES;
    eyepenColor_Index = 0; eyepenthick_Index = 0;
    
    eyepenThickBtnlbl.layer.cornerRadius = 5;
    
    UITapGestureRecognizer* singleTapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eyepageimgVwclick)];
    
    singleTapRecognizer1.delegate = self;
    singleTapRecognizer1.numberOfTapsRequired = 1;
    singleTapRecognizer1.numberOfTouchesRequired = 1;
    
    [eyepageImageVw addGestureRecognizer:singleTapRecognizer1];
    
    
}

-(void)eyepageimgVwclick
{
   
    eyepagetotalVw.hidden = NO;
    //////// Anatoli
     _is_gesture_start = true;
    ////////
    
}

- (IBAction)eyepageBtn_click:(id)sender {
    
    if(!eyepagebtn_flag)
    {
        [eyepageBtnlbl setBackgroundImage:[UIImage imageNamed:@"sel_eyepageBtn.png"] forState:UIControlStateNormal];
        
        //////// Anatoli    outside
        // 36*yPos+xPos;
        _currentIndex = 36 * 8 + 0;
        ////////
        
        
        eyepageImageVw.image =[UIImage imageNamed:@"sample_eye2"];
        
        eyepagehintBtnlbl.hidden = YES; eyepageCameralbl.hidden = YES;
    }
    else
    {
        [eyepageBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyepageBtn.png"] forState:UIControlStateNormal];
        
        //////// Anatoli    inside
        // 36*yPos+xPos;
        _currentIndex = 36 * 8 + 18;
        ////////
        
        if(eyehint_flag)
           eyepageImageVw.image =[UIImage imageNamed:@"sample_eye1"];
        else
          eyepageImageVw.image =[UIImage imageNamed:@"sample_eye"];
        
        eyepagehintBtnlbl.hidden = NO; eyepageCameralbl.hidden = NO;
    }
    
    eyepagebtn_flag = !eyepagebtn_flag;
}

- (IBAction)eyepagePenBtn_click:(id)sender {
    
    
    
    if(!eyepagePencil_flag)
    {
        [eyepagePenBtnlbl setBackgroundImage:[UIImage imageNamed:@"sel_eyepagePecBtn.png"] forState:UIControlStateNormal];
        
          eyePenColorBtnlbl.hidden = NO; eyepenThickBtnlbl.hidden = NO;
        
        eyepageTitleBtnlbl.enabled = NO; eyepageDownarrowlbl.enabled = NO;
        [eyepageTitleBtnlbl setTitleColor:[UIColor colorWithRed:140.0f / 255.0f green:140.0f / 255.0f blue:140.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        if(eyepagebtn_flag)
        {
            eyepageCloseBtnlbl.hidden = YES; eyepageBtnlbl.hidden = YES;
        }
        else
        {
            eyepageCloseBtnlbl.hidden = YES;  eyepagehintBtnlbl.hidden = YES; eyepageCameralbl.hidden = YES;eyepageBtnlbl.hidden = YES;
        }
        /// Anatoli (show)
        panGesture.enabled = NO;
        [self.drawerView setLineColor:self.selectedColor];
        [self.drawerView setLineWidth:self.selectedWidth];
        drawerView.hidden = NO;
        ///

    }
    else
    {
        
        [eyepagePenBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyepagePecBtn.png"] forState:UIControlStateNormal];
        
               
        eyepageTitleBtnlbl.enabled = YES; eyepageDownarrowlbl.enabled = YES; eyePenColorBtnlbl.hidden = YES; eyepenThickBtnlbl.hidden = YES;
        
        [eyepageTitleBtnlbl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if(eyepagebtn_flag)
        {
            eyepageCloseBtnlbl.hidden = NO; eyepageBtnlbl.hidden = NO;
        }
        else
        {
            eyepageCloseBtnlbl.hidden = NO;  eyepagehintBtnlbl.hidden = NO; eyepageCameralbl.hidden = NO;eyepageBtnlbl.hidden = NO;
        }
        //Anatoli (hidden)
        panGesture.enabled = YES;
        [drawerView clear];
        drawerView.hidden = YES;
    }
    
    eyepagePencil_flag = !eyepagePencil_flag;
}

- (IBAction)eyepagehint_click:(id)sender {
    
    //////// Anatoli    inside
    // 36*yPos+xPos;
    _currentIndex = 36 * 0 + 18;
    ////////
    
    if(!eyehint_flag)
    {
        [eyepagehintBtnlbl setBackgroundImage:[UIImage imageNamed:@"sel_eyehintBtn.png"] forState:UIControlStateNormal];
        eyepageImageVw.image =[UIImage imageNamed:@"sample_eye1"];
    }
    else
    {
        [eyepagehintBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyehintBtn.png"] forState:UIControlStateNormal];
        eyepageImageVw.image =[UIImage imageNamed:@"sample_eye"];
    }
    
    eyehint_flag = !eyehint_flag;
}

- (IBAction)eyepageCamera_click:(id)sender {
}

- (IBAction)eyepageTitleBtn_click:(id)sender {
}

- (IBAction)eyepageDownarrowBtn_click:(id)sender {
}

- (IBAction)eyePenColorBtn_click:(id)sender {
    
    if(eyepenColor_Index == 0)
    {
        [eyePenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyePen_redcolor.png"] forState:UIControlStateNormal];
        
        eyepenThickBtnlbl.backgroundColor = [UIColor colorWithRed:245.0f / 255.0f green:84.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        self.selectedColor = [UIColor colorWithRed:245.0f / 255.0f green:84.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        [self.drawerView setLineColor:self.selectedColor];
        eyepenColor_Index = 1;
    }
    else if(eyepenColor_Index == 1)
    {
        [eyePenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyePen_greencolor.png"] forState:UIControlStateNormal];
        eyepenThickBtnlbl.backgroundColor = [UIColor colorWithRed:110.0f / 255.0f green:200.0f / 255.0f blue:14.0f / 255.0f alpha:1.0f];
        self.selectedColor = [UIColor colorWithRed:110.0f / 255.0f green:200.0f / 255.0f blue:14.0f / 255.0f alpha:1.0f];
        [self.drawerView setLineColor:self.selectedColor];
        eyepenColor_Index = 2;
    }
    else if(eyepenColor_Index == 2)
    {
        [eyePenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyePen_blackcolor.png"] forState:UIControlStateNormal];
        eyepenThickBtnlbl.backgroundColor = [UIColor blackColor];
        self.selectedColor = [UIColor blackColor];
        [self.drawerView setLineColor:self.selectedColor];
        eyepenColor_Index = 3;
    }
    else if(eyepenColor_Index == 3)
    {
        [eyePenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyePen_orangecolor.png"] forState:UIControlStateNormal];
        eyepenThickBtnlbl.backgroundColor = [UIColor colorWithRed:245.0f / 255.0f green:238.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        self.selectedColor = [UIColor colorWithRed:245.0f / 255.0f green:238.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        [self.drawerView setLineColor:self.selectedColor];
        eyepenColor_Index = 4;
    }
    else if(eyepenColor_Index == 4)
    {
        [eyePenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyePen_bluecolor.png"] forState:UIControlStateNormal];
        eyepenThickBtnlbl.backgroundColor = [UIColor colorWithRed:41.0f / 255.0f green:121.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f];
        self.selectedColor = [UIColor colorWithRed:41.0f / 255.0f green:121.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f];
        [self.drawerView setLineColor:self.selectedColor];
        eyepenColor_Index = 0;
    }
}

- (IBAction)eyepenThickBtn_click:(id)sender {
    
    if(eyepenthick_Index == 0)
    {
        eyepenThickBtnlbl.frame = CGRectMake(eyepenThickBtnlbl.frame.origin.x, eyepenThickBtnlbl.frame.origin.y, eyepenThickBtnlbl.frame.size.width, eyepenThickBtnlbl.frame.size.height+4.5);
        self.selectedWidth = 10.0f;
        [self.drawerView setLineWidth:self.selectedWidth];
        
              
        eyepenthick_Index = 1;
    }
    else if(eyepenthick_Index == 1)
    {
        eyepenThickBtnlbl.frame = CGRectMake(eyepenThickBtnlbl.frame.origin.x, eyepenThickBtnlbl.frame.origin.y, eyepenThickBtnlbl.frame.size.width, eyepenThickBtnlbl.frame.size.height+6);
        self.selectedWidth = 15.0f;
        [self.drawerView setLineWidth:self.selectedWidth];
        eyepenthick_Index = 2;
    }
    else if(eyepenthick_Index == 2)
    {
        eyepenThickBtnlbl.frame = CGRectMake(eyepenThickBtnlbl.frame.origin.x, eyepenThickBtnlbl.frame.origin.y, eyepenThickBtnlbl.frame.size.width, 6);
        self.selectedWidth = 5.0f;
        [self.drawerView setLineWidth:self.selectedWidth];
        eyepenthick_Index = 0;
    }
    
    eyepenThickBtnlbl.center = CGPointMake(eyepenThickBtnlbl.center.x, 516);
}

- (IBAction)eyeclose:(id)sender {
    
     eyeVw.hidden = YES;
     eyepagetotalVw.hidden = YES; eyehint_flag = NO; eyepagebtn_flag = NO;eyepagePencil_flag = NO;
    
    eyepagehintBtnlbl.hidden = NO; eyepageCameralbl.hidden = NO; eyepageBtnlbl.hidden = NO; eyepageCloseBtnlbl.hidden = NO;
    
    eyepageTitleBtnlbl.enabled = YES; eyepageDownarrowlbl.enabled = YES;
    [eyepageTitleBtnlbl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    eyepageImageVw.image =[UIImage imageNamed:@"sample_eye"];
    [eyepagehintBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyehintBtn.png"] forState:UIControlStateNormal];
    [eyepageBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyepageBtn.png"] forState:UIControlStateNormal];
    
    
    
    totalscrollVw.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-140);
    
    totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height-140);
    
    //self.view.backgroundColor = [UIColor blackColor];
    
    [totalscrollVw setScrollEnabled:YES];
    
    FAQs_pageVw.currentPage = 0; lastpagenumber = 12;
    FAQs_pageVw.numberOfPages = 9;
    
    [FAQscrollVw setContentOffset:CGPointMake(0, 0) animated:NO];
    
    trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = NO; smalleyeBtnlbl.hidden = NO; FAQs_pageVw.hidden = NO;
    
    [eyelbl setTitleColor:[UIColor colorWithRed:200.0f / 255.0f green:200.0f / 255.0f blue:200.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    UIButton* btnC;
    btnC = (UIButton*)[self.view viewWithTag:12];
    [btnC setTitleColor:[UIColor colorWithRed:15.0f / 255.0f green:89.0f / 255.0f blue:153.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [totalscrollVw setContentOffset:CGPointMake(self.view.frame.size.width*2, 0) animated:YES];
    
    lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
    [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
    
    
    
  /*  [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
                         [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Open !!!!!");
                     }];*/
}


/////////////////////////////////////////////////////  FAQs page  ////////////////////////////////////////////

-(void) FAQs_About_page_Init
{
    FAQs_pageVw.hidden = YES;
    
    
    FAQscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*9, self.view.frame.size.height-140);
    aboutscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*7, self.view.frame.size.height-140);
}

/////////////////////////////////////////////////////  Summary page  ////////////////////////////////////////////

-(void) summary_page_Init
{
    myopia_flag = NO; presby_flag = NO;astigm_flag= NO; cataract_flag= NO;hypero_flag= NO;kerato_flag= NO;lasik_deless_flag = NO; lasik_ded_flag = NO; recomment1_flag= NO; recomment2_flag= NO; prk_flag= NO; icl_flag= NO; recomment3_flag= NO; recomment4_flag= NO; recomment5_flag= NO; recomment6_flag= NO;recomment7_flag= NO; recomment8_flag= NO;
    trad_flag = NO; larse_flag = NO; rle_flag = NO; glaucoma_flag = NO;
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setDateFormat:@"MMMM dd, yyyy"];
    
    NSString *dateString = [inFormat stringFromDate:now];
    
    summary_datelbl.text = dateString;
    follow_datelbl.text = dateString;
    
    summary_totalVw.layer.cornerRadius = 5.0;
    [summary_totalVw.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [summary_totalVw.layer setShadowOpacity:0.5f];
    [summary_totalVw.layer setShadowRadius:1.0];
    [summary_totalVw.layer setShadowOffset:CGSizeMake(1, 2)];
    
    summary_continuelbl.layer.cornerRadius = 5.0;
}

- (IBAction)myopiaBtn_click:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    UIButton *btnC;
    
    for(int tag = 100; tag < 136; tag++)
    {
        if(tag == btn.tag)
        {
            
            if(tag == 100 || tag == 101)
            {
                btnC = (UIButton*)[self.view viewWithTag:100];
                
                if(!myopia_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                myopia_flag = !myopia_flag;
            }
            else if(tag == 102 || tag == 103)
            {
                btnC = (UIButton*)[self.view viewWithTag:102];
                
                if(!presby_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                presby_flag = !presby_flag;
            }
            else if(tag == 104 || tag == 105)
            {
                btnC = (UIButton*)[self.view viewWithTag:104];
                
                if(!astigm_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                astigm_flag = !astigm_flag;
            }
            else if(tag == 106 || tag == 107)
            {
                btnC = (UIButton*)[self.view viewWithTag:106];
                
                if(!cataract_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                cataract_flag = !cataract_flag;
            }
            else if(tag == 108 || tag == 109)
            {
                btnC = (UIButton*)[self.view viewWithTag:108];
                
                if(!hypero_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                hypero_flag = !hypero_flag;
            }
            else if(tag == 110 || tag == 111)
            {
                btnC = (UIButton*)[self.view viewWithTag:110];
                
                if(!kerato_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                kerato_flag = !kerato_flag;
            }
            else if(tag == 112 || tag == 113)
            {
                btnC = (UIButton*)[self.view viewWithTag:112];
                
                if(!lasik_deless_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                lasik_deless_flag = !lasik_deless_flag;
            }
            else if(tag == 114 || tag == 115)
            {
                btnC = (UIButton*)[self.view viewWithTag:114];
                
                if(!lasik_ded_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                lasik_ded_flag = !lasik_ded_flag;
            }
            else if(tag == 116)
            {
                btnC = (UIButton*)[self.view viewWithTag:116];
                
                if(!recomment1_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment1_flag = !recomment1_flag;
                
                if(recomment2_flag)
                {
                    if (recomment3_flag||recomment4_flag)
                    {
                       UIButton* temp = (UIButton*)[self.view viewWithTag:117];
                       [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        
                        recomment2_flag = !recomment2_flag;
                    }
                   
                }
                else if (recomment3_flag)
                {
                    if (recomment4_flag)
                    {
                        UIButton* temp = (UIButton*)[self.view viewWithTag:122];
                        [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        recomment3_flag = !recomment3_flag;
                    }
                }
                
            }
            else if(tag == 117)
            {
                btnC = (UIButton*)[self.view viewWithTag:117];
                
                if(!recomment2_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment2_flag = !recomment2_flag;
                
                if(recomment1_flag)
                {
                    if (recomment3_flag||recomment4_flag)
                    {
                        UIButton* temp = (UIButton*)[self.view viewWithTag:116];
                        [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        
                        recomment1_flag = !recomment1_flag;
                    }
                    
                }
                else if (recomment3_flag)
                {
                    if (recomment4_flag)
                    {
                        UIButton* temp = (UIButton*)[self.view viewWithTag:122];
                        [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        recomment3_flag = !recomment3_flag;
                    }
                }
            }
            else if(tag == 118 || tag == 119)
            {
                btnC = (UIButton*)[self.view viewWithTag:118];
                
                if(!prk_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                prk_flag = !prk_flag;
            }
            else if(tag == 120 || tag == 121)
            {
                btnC = (UIButton*)[self.view viewWithTag:120];
                
                if(!icl_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                icl_flag = !icl_flag;
            }
            else if(tag == 122)
            {
                btnC = (UIButton*)[self.view viewWithTag:122];
                
                if(!recomment3_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment3_flag = !recomment3_flag;
                
                if(recomment1_flag)
                {
                    if (recomment2_flag||recomment4_flag)
                    {
                        UIButton* temp = (UIButton*)[self.view viewWithTag:116];
                        [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        
                        recomment1_flag = !recomment1_flag;
                    }
                    
                }
                else if (recomment2_flag)
                {
                    if (recomment4_flag)
                    {
                        UIButton* temp = (UIButton*)[self.view viewWithTag:117];
                        [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        recomment2_flag = !recomment2_flag;
                    }
                }
            }
            else if(tag == 123)
            {
                btnC = (UIButton*)[self.view viewWithTag:123];
                
                if(!recomment4_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment4_flag = !recomment4_flag;
                
                if(recomment1_flag)
                {
                    if (recomment2_flag||recomment3_flag)
                    {
                        UIButton* temp = (UIButton*)[self.view viewWithTag:116];
                        [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        
                        recomment1_flag = !recomment1_flag;
                    }
                    
                }
                else if (recomment2_flag)
                {
                    if (recomment3_flag)
                    {
                        UIButton* temp = (UIButton*)[self.view viewWithTag:117];
                        [temp setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                        recomment2_flag = !recomment2_flag;
                    }
                }
            }
            else if(tag == 124 || tag == 125)
            {
                btnC = (UIButton*)[self.view viewWithTag:124];
                
                if(!trad_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                trad_flag = !trad_flag;
            }
            else if(tag == 126 || tag == 127)
            {
                btnC = (UIButton*)[self.view viewWithTag:126];
                
                if(!larse_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                larse_flag = !larse_flag;
            }
            else if(tag == 128 || tag == 129)
            {
                btnC = (UIButton*)[self.view viewWithTag:128];
                
                if(!glaucoma_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                glaucoma_flag = !glaucoma_flag;
            }
            else if(tag == 130 || tag == 131)
            {
                btnC = (UIButton*)[self.view viewWithTag:130];
                
                if(!rle_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                rle_flag = !rle_flag;
            }
            else if(tag == 132)
            {
                btnC = (UIButton*)[self.view viewWithTag:132];
                
                if(!recomment5_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment5_flag = !recomment5_flag;
            }
            else if(tag == 133)
            {
                btnC = (UIButton*)[self.view viewWithTag:133];
                
                if(!recomment6_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment6_flag = !recomment6_flag;
            }
            else if(tag == 134)
            {
                btnC = (UIButton*)[self.view viewWithTag:134];
                
                if(!recomment7_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment7_flag = !recomment7_flag;
            }
            else if(tag == 135)
            {
                btnC = (UIButton*)[self.view viewWithTag:135];
                
                if(!recomment8_flag)
                    [btnC setBackgroundImage:[UIImage imageNamed:@"checkbtn.png"] forState:UIControlStateNormal];
                else
                    [btnC setBackgroundImage:[UIImage imageNamed:@"uncheckbtn.png"] forState:UIControlStateNormal];
                
                recomment8_flag = !recomment8_flag;
            }
            
            
        }
    }
    
  
}

- (IBAction)sum_contine_click:(id)sender {
    
    
    if(!recomment1_flag&&!recomment2_flag&&!recomment3_flag&&!recomment4_flag)
    {
        subVw1.hidden = YES;
        
        subVw2.frame = CGRectMake(0, lastVw.frame.origin.y+7, subVw2.frame.size.width, subVw2.frame.size.height);
        
        //subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 160);
        
        //subVw2.frame = CGRectMake(0, subVw1.frame.origin.y+subVw1.frame.size.height+7, subVw2.frame.size.width, subVw2.frame.size.height);
    }
    else
    {
        subVw1.hidden = NO;
        
        if(recomment1_flag&&!recomment2_flag&&!recomment3_flag&&!recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 110);
            
            recommentlbl1.text = @"LASIK Bladeless";
            
        }
        else if(!recomment1_flag&&recomment2_flag&&!recomment3_flag&&!recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 110);
            
            recommentlbl1.text = @"LASIK Bladed";
            
        }
        else if(!recomment1_flag&&!recomment2_flag&&recomment3_flag&&!recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 110);
            recommentlbl1.text = @"PRK";
            
        }
        else if(!recomment1_flag&&!recomment2_flag&&!recomment3_flag&&recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 110);
            recommentlbl1.text = @"ICL";
            
        }
        else if(recomment1_flag&&recomment2_flag&&!recomment3_flag&&!recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 160);
            recommentlbl1.text = @"LASIK Bladeless";
            recommentlbl2.text = @"LASIK Bladed";
            
        }
        else if(recomment1_flag&&!recomment2_flag&&recomment3_flag&&!recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 160);
            
            recommentlbl1.text = @"LASIK Bladeless";
            recommentlbl2.text = @"PRK";
            
        }
        else if(recomment1_flag&&!recomment2_flag&&!recomment3_flag&&recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 160);
            
            recommentlbl1.text = @"LASIK Bladeless";
            recommentlbl2.text = @"ICL";
            
        }
        else if(!recomment1_flag&&recomment2_flag&&recomment3_flag&&!recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 160);
            
            recommentlbl1.text = @"LASIK Bladed";
            recommentlbl2.text = @"PRK";
            
        }
        else if(!recomment1_flag&&recomment2_flag&&!recomment3_flag&&recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 160);
            recommentlbl1.text = @"LASIK Bladed";
            recommentlbl2.text = @"ICL";
            
        }
        else if(!recomment1_flag&&!recomment2_flag&&recomment3_flag&&recomment4_flag)
        {
            subVw1.frame = CGRectMake(0, lastVw.frame.origin.y+15, subVw1.frame.size.width, 160);
            
            recommentlbl1.text = @"PRK";
            recommentlbl2.text = @"ICL";
            
        }
        
        subVw2.frame = CGRectMake(0, subVw1.frame.origin.y+subVw1.frame.size.height+7, subVw2.frame.size.width, subVw2.frame.size.height);
    }
        
    
    
    
    [summarylbl setTitleColor:[UIColor colorWithRed:200.0f / 255.0f green:200.0f / 255.0f blue:200.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    UIButton* btnC;
    btnC = (UIButton*)[self.view viewWithTag:15];
    [btnC setTitleColor:[UIColor colorWithRed:15.0f / 255.0f green:89.0f / 255.0f blue:153.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [totalscrollVw setContentOffset:CGPointMake(5*self.view.frame.size.width, 0) animated:YES];
    
    lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
    [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
    
   /* [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
                         [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Open !!!!!");
                     }];*/
}


/////////////////////////////////////////////////////  Follow Up page  ////////////////////////////////////////////

-(void) follow_page_Init
{
    candidate_flag = NO; sendmail_flag = NO;
    
    subVw1.hidden = YES; select_totalVw.hidden = YES; select_CalendarVw.hidden = YES;
    
    subVw2.frame = CGRectMake(0, lastVw.frame.origin.y+7, subVw2.frame.size.width, subVw2.frame.size.height);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setfollow_Date:) name:@"setDate" object:nil];
    
    calendarVw = [[[NSBundle mainBundle] loadNibNamed:@"CalendarView"
                                   owner:self
                                 options:nil] objectAtIndex:0];
    
    
  
    //calendarVw.frame = CGRectMake(0, 0,  calendarVw.frame.size.width, calendarVw.frame.size.height);
    [calendarVw.calendar_closeBtnlbl addTarget:self action:@selector(closecalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:calendarVw];
    calendarVw.hidden = YES;
    
    
    [follow_selTableVw setSeparatorColor:[UIColor colorWithRed:70.0f/255 green:70.0f/255 blue:70.0f/255 alpha:1.0]];
    
    
    follow_totalVw.layer.cornerRadius = 5.0;
    [follow_totalVw.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [follow_totalVw.layer setShadowOpacity:0.5f];
    [follow_totalVw.layer setShadowRadius:1.0];
    [follow_totalVw.layer setShadowOffset:CGSizeMake(1, 2)];
    
    follow_completelbl.layer.cornerRadius = 5.0;
    
    loadingView.hidden = YES;

}

- (IBAction)follow_complete_click:(id)sender {
    
    /////////////////////////////////////////////     Uploading View Init     //////////////////////////////////////
    
    
    counter = 0; progress = 0.0;
    
    pgv=[[ProgressGradientView alloc] initWithFrame:CGRectMake(uploadinglbl.frame.origin.x, uploadinglbl.frame.origin.y+45, 350, 15)];
    pgv.layer.cornerRadius = 6.0;
    
    [loadingView addSubview:pgv];
    
    [UIView transitionWithView: loadingView
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        loadingView.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                        
                    }
     ];
    
    timer =   [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(animationTimerFired:) userInfo:nil repeats:YES];
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
            
            [UIView transitionWithView: loadingView
                              duration: 0.3
                               options: UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                // My flip specific code
                               loadingView.hidden = YES;
                            }
                            completion:^(BOOL finished) {
                                
                                [pgv removeFromSuperview];
                                pgv = nil;
                            }
             ];
            
        }
    }
}

- (IBAction)candidateBtn_click:(id)sender {
    
    if(!candidate_flag)
        [candilbl setBackgroundImage:[UIImage imageNamed:@"yes_btn.png"] forState:UIControlStateNormal];
    else
        [candilbl setBackgroundImage:[UIImage imageNamed:@"no_btn.png"] forState:UIControlStateNormal];
    
    candidate_flag = !candidate_flag;
}

- (IBAction)sendmailBtn_click:(id)sender {
    
    if(!sendmail_flag)
        [sendmaillbl setBackgroundImage:[UIImage imageNamed:@"yes_btn.png"] forState:UIControlStateNormal];
    else
        [sendmaillbl setBackgroundImage:[UIImage imageNamed:@"no_btn.png"] forState:UIControlStateNormal];
    
    sendmail_flag = !sendmail_flag;
}

- (IBAction)select_closeBtn_click:(id)sender {
    
    [UIView transitionWithView: select_totalVw
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        select_totalVw.hidden = YES;
                    }
                    completion:^(BOOL finished) {
                     
                        
                    }
     ];
}

- (IBAction)follow_eyesBtn_click:(id)sender {
   
    UIButton *btn = (UIButton*)sender;
    
    if(btn.tag ==50 || btn.tag == 51)
    {
        select_Titlelbl.text = @"Eye Selection";
        
        shareselectInfo = [[NSArray alloc]initWithObjects:@"Both",  @"Left", @"Right", nil];
        
        if(btn.tag == 50) sel_tag = 50;
        else sel_tag = 51;
    }
    else
    {
        sel_tag = 52;
        
        select_Titlelbl.text = @"Select Referral Source";
        
        shareselectInfo = [[NSArray alloc]initWithObjects:@"Patient Refferral",  @"Optometrist Co-Manage", @"Yelp",@"Website", nil];
        
    }
    
    
    follow_selTableVw.frame = CGRectMake(follow_selTableVw.frame.origin.x, follow_selTableVw.frame.origin.y, follow_selTableVw.frame.size.width, shareselectInfo.count*60);
    
    [follow_selTableVw reloadData];
    
    [UIView transitionWithView: select_totalVw
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        select_totalVw.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                        
                    }
     ];
}

- (IBAction)follow_Pre_Sur_Date_click:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
        
    if(btn.tag ==53)
    {
        
        calendarVw.calendar_Titlelabel.text = @"Select Preop Date";
        sel_tag = 53;
        
    }
    else
    {
        sel_tag = 54;
        calendarVw.calendar_Titlelabel.text = @"Select Surgery Date";
          
    }
    
    
    [UIView transitionWithView: calendarVw
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        calendarVw.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                        
                    }
     ];
    
}

-(void)setfollow_Date:(NSNotification *)userinfo
{
   
    UIButton* btnC = (UIButton*)[self.view viewWithTag:sel_tag];
    
    [btnC setTitle:userinfo.userInfo[@"selectedDate"] forState:UIControlStateNormal];
   
    
    
    NSLog(@"datainfo = %@", userinfo.userInfo);
    
    [self closecalendar];
}

-(void)closecalendar
{
    [UIView transitionWithView: calendarVw
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        calendarVw.hidden = YES;
                    }
                    completion:^(BOOL finished) {
                        
                        
                    }
     ];
}

- (IBAction)follow_calcloseBtn_click:(id)sender {
    
   
}


/////////////////////////////////////////////////////  Tap button of Home page  ////////////////////////////////////////////

- (IBAction)category_click:(id)sender
{
    [self dismissKeyboard];
    
    ///////// Anatoli
    if (smallPenBtn_flag) {
        [smallpenBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyepagePecBtn.png"] forState:UIControlStateNormal];
        panGesture.enabled = YES;
        [drawerFaqsView clear];
        drawerFaqsView.hidden = YES;
        smallpenColorBtnlbl.hidden = YES;
        smallpenThickBtnlbl.hidden = YES;
        [totalscrollVw setScrollEnabled:YES];
        smallPenBtn_flag = NO;
    }
    ////////
    
    UIButton *btn = (UIButton*)sender;
    UIButton *btnC;
    for(int tag = 10; tag < 16; tag++)
    {
        if(tag == btn.tag)
        {
            if(tag == 10)
            {
                
               patientlbl.enabled = NO;
               
                // eyelbl.enabled = NO; FAQslbl.enabled = NO; aboutuslbl.enabled = NO; summarylbl.enabled = NO;  followuplbl.enabled = NO;
                
                eyelbl.hidden = YES;FAQslbl.hidden = YES;aboutuslbl.hidden = YES;summarylbl.hidden = YES;followuplbl.hidden = YES;
                
                txt_flag = NO;
                
               [totalscrollVw setScrollEnabled:NO];
                
               trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = YES; FAQs_pageVw.hidden = YES;
               
                
            }
            else if(tag == 11)
            {
                eyeVw.hidden = NO;
                
                [totalscrollVw setScrollEnabled:NO];
                
                trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = YES; FAQs_pageVw.hidden = YES;
            }
            else if(tag == 12)
            {
                lastpagenumber = 12;
                FAQs_pageVw.numberOfPages = 9;
                FAQs_pageVw.currentPage = 0;
                
                [FAQscrollVw setContentOffset:CGPointMake(0, 0) animated:NO];
                [aboutscrollVw setContentOffset:CGPointMake(0, 0) animated:NO];
                
                [totalscrollVw setScrollEnabled:YES];
                
                trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = NO; smalleyeBtnlbl.hidden = NO; FAQs_pageVw.hidden = NO;
            }
            else if(tag == 13)
            {
               lastpagenumber = 13;
                FAQs_pageVw.numberOfPages = 7;
                FAQs_pageVw.currentPage = 0;
                
                [aboutscrollVw setContentOffset:CGPointMake(0, 0) animated:NO];
                [FAQscrollVw setContentOffset:CGPointMake(self.view.frame.size.width*8, 0) animated:NO];
                
                [totalscrollVw setScrollEnabled:YES];
                
                trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = NO; smalleyeBtnlbl.hidden = NO; FAQs_pageVw.hidden = NO;
            }
            else if(tag == 14)
            {
                lastpagenumber = 14;
                [totalscrollVw setScrollEnabled:YES];
                
                FAQs_pageVw.numberOfPages = 7;
                FAQs_pageVw.currentPage = 6;
                [aboutscrollVw setContentOffset:CGPointMake(self.view.frame.size.width*6, 0) animated:NO];
                [FAQscrollVw setContentOffset:CGPointMake(self.view.frame.size.width*8, 0) animated:NO];
                
                trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = NO; FAQs_pageVw.hidden = YES;
            }
            else if(tag == 15)
            {
                lastpagenumber = 15;
                [totalscrollVw setScrollEnabled:YES];
                
                FAQs_pageVw.numberOfPages = 7;
                FAQs_pageVw.currentPage = 6;
                [aboutscrollVw setContentOffset:CGPointMake(self.view.frame.size.width*6, 0) animated:NO];
                [FAQscrollVw setContentOffset:CGPointMake(self.view.frame.size.width*8, 0) animated:NO];
                
                trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = NO; FAQs_pageVw.hidden = YES;
            }
           
            if(tag == 11)
            {
                totalscrollVw.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                
                totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height);
                
                
            }
            else
            {
                totalscrollVw.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-140);
                
                totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height-140);
                
                
            }
            
            if(tag == 10)  { patient_flag = YES; }
            else
            { patient_flag = NO; }
            
            [totalscrollVw setContentOffset:CGPointMake((tag-10)*self.view.frame.size.width, 0) animated:NO];
            
            btnC = (UIButton*)[self.view viewWithTag:tag];
            
            [btnC setTitleColor:[UIColor colorWithRed:15.0f / 255.0f green:89.0f / 255.0f blue:153.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
            [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
           /*
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options: UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 
                                 lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
                                 [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
                             }
                             completion:^(BOOL finished){
                                 NSLog(@"Open !!!!!");
                             }];*/
            
        }
        else
        {
            btnC = (UIButton*)[self.view viewWithTag:tag];
            [btnC setTitleColor:[UIColor colorWithRed:200.0f / 255.0f green:200.0f / 255.0f blue:200.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)eyebotton_click:(id)sender {
    
    
}

- (IBAction)penbottom_click:(id)sender {
    
    
}

#pragma mark Scrollview delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    
    pagenumber = sender.contentOffset.x / sender.frame.size.width;
    
    
    if(sender == totalscrollVw)
    {
        pagenumber = pagenumber % 6;
        NSLog(@"currntpage = %ld ",(long)pagenumber % 6);
        
        UIButton *btnC;
        
        
        for(int tag = 10; tag < 16; tag++)
        {
            if(tag == pagenumber+10)
            {
                if(tag == 12)
                {
                    
                    FAQs_pageVw.hidden = NO; smallpenBtnlbl.hidden = NO;
                    FAQs_pageVw.numberOfPages = 9;
                    
                    if(lastpagenumber == 11)
                    {
                         FAQs_pageVw.currentPage = 0;
                        
                    }
                    else
                    {
                        FAQs_pageVw.currentPage = 8;
                        
                    }
                }
                else if(tag == 13)
                {
                    FAQs_pageVw.hidden = NO; smallpenBtnlbl.hidden = NO;
                    FAQs_pageVw.numberOfPages = 7;
                    
                    if(lastpagenumber == 12)
                    {
                        FAQs_pageVw.currentPage = 0;
                        
                    }
                    else
                    {
                        FAQs_pageVw.currentPage = 6;
                        
                    }
                }
                else if(tag == 14)
                {
                    
                    [totalscrollVw setScrollEnabled:YES];
                    
                    trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = NO; FAQs_pageVw.hidden = YES;
                }
                else if(tag == 15)
                {
                    [totalscrollVw setScrollEnabled:YES];
                    
                    trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = NO; FAQs_pageVw.hidden = YES;
                }
                else if(tag == 11)
                {
                    
                    [totalscrollVw setScrollEnabled:NO];
                    
                    trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = YES; FAQs_pageVw.hidden = YES;
                }
                else if(tag == 10)
                {
                    
                    
                    [totalscrollVw setScrollEnabled:NO];
                    
                    trademarkImgVw.hidden = YES; smallpenBtnlbl.hidden = YES; smalleyeBtnlbl.hidden = YES; FAQs_pageVw.hidden = YES;
                }
                
                if(tag == 11)
                {
                    eyeVw.hidden = NO;
                    
                    totalscrollVw.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                    
                    totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height);
                }
                else
                {
                    eyeVw.hidden = YES;
                    totalscrollVw.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-140);
                    
                    totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height-140);
                }
                
                btnC = (UIButton*)[self.view viewWithTag:tag];
                
                [btnC setTitleColor:[UIColor colorWithRed:15.0f / 255.0f green:89.0f / 255.0f blue:153.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
                
                lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
                [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
                
              /*  [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     
                                     lineVw.frame = CGRectMake(lineVw.frame.origin.x, lineVw.frame.origin.y, btnC.frame.size.width, lineVw.frame.size.height);
                                     [lineVw setCenter:CGPointMake(btnC.center.x, lineVw.center.y)];
                                 }
                                 completion:^(BOOL finished){
                                     NSLog(@"Open !!!!!");
                                 }];*/
                
                lastpagenumber = tag;
                
                
            }
            else
            {
                btnC = (UIButton*)[self.view viewWithTag:tag];
                [btnC setTitleColor:[UIColor colorWithRed:231.0f / 255.0f green:231.0f / 255.0f blue:231.0f / 255.0f alpha:1.0f] forState:UIControlStateNormal];
            }
        }
    }
    else if(sender == FAQscrollVw)
    {
        pagenumber = pagenumber % 9;
        NSLog(@"currntpage = %ld ",(long)pagenumber % 9 );
       
        [totalscrollVw setScrollEnabled:YES];
        FAQs_pageVw.currentPage = pagenumber;
        
        eyeVw.hidden = YES;
        totalscrollVw.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-140);
        
        totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height-140);
        
        
    }
    else if(sender == aboutscrollVw)
    {
        pagenumber = pagenumber % 7;
        NSLog(@"currntpage = %ld ",(long)pagenumber % 7);
        [totalscrollVw setScrollEnabled:YES];
        FAQs_pageVw.currentPage = pagenumber;
        
        eyeVw.hidden = YES;
        totalscrollVw.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-140);
        
        totalscrollVw.contentSize = CGSizeMake(self.view.frame.size.width*6, self.view.frame.size.height-140);
        
        
    }
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == patfirstName || textField == patlastName || textField == pricetxt1 || textField == pricetxt2 || textField ==addreftxt)
    {
        if(!txt_flag)
        {
            
            NSTimeInterval animationDuration = 0.3;
            CGRect frame = patient_totalVw.frame;
            CGRect frame1 = follow_totalVw.frame;
            frame.origin.y -= 100;
            if(!recomment1_flag&&!recomment2_flag&&!recomment3_flag&&!recomment4_flag)
                 frame1.origin.y -= 50;
            else
                frame1.origin.y -= 190;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            patient_totalVw.frame = frame;
            follow_totalVw.frame = frame1;
            [UIView commitAnimations];
            txt_flag = YES;
            
        }
    }
    
    
    return TRUE;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    if(textField == patfirstName || textField == patlastName || textField == pricetxt1 || textField == pricetxt2 || textField ==addreftxt)
    {
        if(txt_flag)
        {
            NSTimeInterval animationDuration = 0.3;
            CGRect frame = patient_totalVw.frame;
            CGRect frame1 = follow_totalVw.frame;
            frame.origin.y += 100;
            if(!recomment1_flag&&!recomment2_flag&&!recomment3_flag&&!recomment4_flag)
                frame1.origin.y += 50;
            else
                frame1.origin.y += 190;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            patient_totalVw.frame = frame;
            follow_totalVw.frame = frame1;
            [UIView commitAnimations];
            
            txt_flag = NO;
            
            
        }
    }
    
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
 /*   if(textField == patfirstName || textField == patlastName)
    {
       if(txt_flag)
        {
            NSTimeInterval animationDuration = 0.3;
            CGRect frame = patient_totalVw.frame;
            frame.origin.y += 100;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            patient_totalVw.frame = frame;
            [UIView commitAnimations];
            
            txt_flag = NO;
            
        }
        
        
    }*/
    
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    
    if([textField.text length]-1 == 0)
    {
        if([string isEqualToString:@""])
        {
            if(textField == patfirstName || textField == patlastName)
            {
                [patient_continueBtnlbl setBackgroundColor:[UIColor colorWithRed:206.0f / 255.0f green:206.0f / 255.0f blue:206.0f / 255.0f alpha:1.0f]];
                
                patient_continueBtnlbl.enabled = NO;
            }
        }
        
    }
    else
    {
        if(textField == patfirstName)
        {
            if(![patlastName.text isEqualToString:@""])
            {
                [patient_continueBtnlbl setBackgroundColor:[UIColor colorWithRed:106.0f / 255.0f green:166.0f / 255.0f blue:218.0f / 255.0f alpha:1.0f]];
                patient_continueBtnlbl.enabled = YES;
            }
        }
        else if(textField == patlastName)
        {
            if(![patfirstName.text isEqualToString:@""])
            {
                [patient_continueBtnlbl setBackgroundColor:[UIColor colorWithRed:106.0f / 255.0f green:166.0f / 255.0f blue:218.0f / 255.0f alpha:1.0f]];
                
                patient_continueBtnlbl.enabled = YES;
            }
        }
        
    }
    
    if([textField.text length] == 0)
    {
        if(textField == pricetxt1 )
        {
            pricetxt1.text = @"$";
        }
        else if(textField == pricetxt2)
        {
            pricetxt2.text = @"$";
        }
    }
    else if([textField.text length]-1 == 1)
    {
        if([string isEqualToString:@""])
        {
            
            if(textField == pricetxt1 )
            {
                pricetxt1.text = @"";
            }
            else if(textField == pricetxt2)
            {
                pricetxt2.text = @"";
            }
            
        }
    }
    
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma Table view code starts from here ----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return shareselectInfo.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
     if (cell == nil)
     {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
    
    cell.tag = indexPath.row;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CellClicked:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    cell.preservesSuperviewLayoutMargins = NO;
    cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    
    cell.textLabel.text = shareselectInfo[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:231.0f / 255.0f green:231.0f / 255.0f blue:231.0f / 255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20.0];
    
    UIButton* btnC = (UIButton*)[self.view viewWithTag:sel_tag];
    
   // NSLog(@"%@", btnC.titleLabel.text);
    
    if([btnC.titleLabel.text isEqualToString:shareselectInfo[indexPath.row]])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    
    [cell setUserInteractionEnabled:YES];
    [cell addGestureRecognizer:singleTap];
    
    // }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
}

-(void)CellClicked:(UITapGestureRecognizer *)gesture
{
    NSLog(@"%ld index clicked", (long)gesture.view.tag);
    
    UIButton* btnC = (UIButton*)[self.view viewWithTag:sel_tag];
    
    [btnC setTitle:shareselectInfo[gesture.view.tag] forState:UIControlStateNormal];
     NSLog(@"%@", btnC.titleLabel.text);
   // [follow_selTableVw reloadData];
    
    [UIView transitionWithView: select_totalVw
                      duration: 0.2
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // My flip specific code
                        select_totalVw.hidden = YES;
                    }
                    completion:^(BOOL finished) {
                        
                        
                    }
     ];
    
}


#pragma - Anatoli codes

-(void) init_dataSource_gestureRecognizer{
    
    smallPenBtn_flag = NO;
    _preIndex = 0;
    NSMutableArray *test = [NSMutableArray array];
    for(int y =0 ; y< 18; y++)
    {
        for (int x = 0; x < 36; x++)
        {
            NSString *fname = [[NSString alloc] initWithFormat:@"%d_%d_.jpg", y, x];
            [test addObject:[UIImage imageNamed:fname]];
        }
    }
    self.dataSource = [test copy];
    
    NSMutableArray *test1 = [NSMutableArray array];
    for(int y =0 ; y< 18; y++)
    {
        for (int x = 0; x < 36; x++)
        {
            NSString *fname = [[NSString alloc] initWithFormat:@"%d_%d.png", y, x];
            [test1 addObject:[UIImage imageNamed:fname]];
        }
    }
    self.dataSource_label = [test1 copy];
    
    self.imageCount = self.dataSource.count;
    
 //   self.eyepageImageVw.contentMode = UIViewContentModeScaleAspectFill;

    self.eyepageImageVw.contentMode = UIViewContentModeCenter;

    if (self.dataSource.count)
    {
        //////// Anatoli    inside
        // 36*yPos+xPos;
//        xPos = 18; yPos = 8;
//        _currentIndex = 36 * 8 + 18;
//        self.eyepageImageVw.image =[UIImage imageNamed:@"sample_eye"];
//        // Init image set
         xPos = 0; yPos = 8;
        _currentIndex = 36*yPos+xPos;
        self.eyepageImageVw.image = [self.dataSource objectAtIndex:36*yPos+xPos];
    }
    
    _panDistance = 11;
    _direction = MMSpinViewDirectionForward;
    
    _is_gesture_start = false;
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPan:)];
    
    panGesture.maximumNumberOfTouches = 1;
    //    panGesture.delegate = self;
    panGesture.cancelsTouchesInView = YES;
    //[self.view addGestureRecognizer:panGesture];
    [self.eyeVw addGestureRecognizer:panGesture];
    
    pinchGestureReconnizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.eyeScrollVw addGestureRecognizer:pinchGestureReconnizer];
    //[self.view setUserInteractionEnabled:NO];
    
    
}

-(void)handlePinch:(UIPinchGestureRecognizer *)pinchGesture
{
    if (pinchGesture.state == UIGestureRecognizerStateEnded || pinchGesture.state == UIGestureRecognizerStateChanged) {
        
        
        CGFloat currentScale = self.eyeScrollVw.frame.size.width / self.eyeScrollVw.bounds.size.width;
        CGFloat newScale = currentScale * pinchGesture.scale;
        
        if (newScale < 0.5) {
            newScale = 0.5;
        }
        if (newScale > 4.0) {
            newScale = 4.0;
        }
        
        //CGAffineTransform zoomTransform = CGAffineTransformMakeScale([pinchGesture scale],[pinchGesture scale]);
        CGAffineTransform zoomTransform = CGAffineTransformMakeScale(newScale, newScale);
        
        [[pinchGesture view] setTransform:zoomTransform];
         pinchGesture.scale = 1;
    }

   // pinchGesture.scale = 1.0f;
}


- (void)actionPan:(UIPanGestureRecognizer*)gesture
{
    if (!_is_gesture_start) {
        return;
    }

    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.xtouchIndex = self.currentIndex % 36;
            self.ytouchIndex = (int)self.currentIndex / 36;
            
            //            self.touchPoint = [gesture locationInView:self];
            self.touchPoint = [gesture locationInView:self.eyepageImageVw];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            //            CGPoint pt = [gesture locationInView:self];
            CGPoint pt = [gesture locationInView:self.eyepageImageVw];
            
            double offset = pt.x - self.touchPoint.x;
            double offsety = pt.y - self.touchPoint.y;
            
            //            if ( self.direction == MMSpinViewDirectionBackward )
            //            {
            //                offset = -offset;
            //            }
            //
            //            if ( self.direction == MMSpinViewDirectionUp )
            //            {
            //                offsety = -offsety;
            //            }
            
            //            NSInteger index = (int)(((offset+self.panDistance/2.0f) + (1000*self.panDistance) )/ self.panDistance) - 1000 + self.touchIndex;
            NSInteger index = -offset/self.panDistance + 0.5 + self.xtouchIndex;
            NSInteger indexy = offsety/self.panDistance + 0.5 + self.ytouchIndex;
            if(indexy>17) indexy=17;
            if(indexy<0) indexy=0;
            
            if ( index != self.currentIndex )
            {
                //self.currentIndex = (index + self.imageCount*1000) % self.imageCount;
                xPos = (index + 36*1000) % 36;
                yPos = (indexy + 18*1000) % 18;
                
                self.currentIndex = 36*yPos+xPos;
                
                
                //                if ( [self.delegate respondsToSelector:@selector(spinImageView:didSpinToIndex:)] )
                //                {
                //                    [self.delegate spinImageView:self didSpinToIndex:index];
                //                }
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (!_is_gesture_start) {
        _currentIndex = 36 * 8 + 0;
        return;
    }
    if (_preIndex == currentIndex) {
        return;
    }
    _preIndex = currentIndex;
    if ( self.dataSource )
    {
        _currentIndex = currentIndex;
        
        xPos = currentIndex % 36;
        yPos = (int)currentIndex / 36;
        if (eyehint_flag) {
            self.eyepageImageVw.image = (currentIndex>=self.imageCount)?nil:[self.dataSource_label objectAtIndex:currentIndex];
        }else{
            self.eyepageImageVw.image = (currentIndex>=self.imageCount)?nil:[self.dataSource objectAtIndex:currentIndex];
        }
        
        NSLog(@"%ld %ld",(long)xPos, (long)yPos);
        
    }
    else
    {
        _currentIndex = 0;
    }
    
}
// smallPenBnt_event

- (IBAction)on_smallPenBtn_click:(id)sender {
    if (!smallPenBtn_flag) {
        [smallpenBtnlbl setBackgroundImage:[UIImage imageNamed:@"sel_eyepagePecBtn.png"] forState:UIControlStateNormal];
        panGesture.enabled = NO;
        [self.drawerFaqsView setLineColor:self.selectedSmallColor];
        [self.drawerFaqsView setLineWidth:self.selectedSmallWidth];
        drawerFaqsView.hidden = NO;
        smallpenColorBtnlbl.hidden = NO;
        smallpenThickBtnlbl.hidden = NO;
        [totalscrollVw setScrollEnabled:NO];
    }else{
        [smallpenBtnlbl setBackgroundImage:[UIImage imageNamed:@"eyepagePecBtn.png"] forState:UIControlStateNormal];
        panGesture.enabled = YES;
         [drawerFaqsView clear];
         drawerFaqsView.hidden = YES;
        smallpenColorBtnlbl.hidden = YES;
        smallpenThickBtnlbl.hidden = YES;
        [totalscrollVw setScrollEnabled:YES];
    }
    smallPenBtn_flag = !smallPenBtn_flag;
}

- (IBAction)on_smallpenColorBtn_click:(id)sender {
    
    
    if(smallpenColor_Index == 0)
    {
        [smallpenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"smallPen_redcolor.png"] forState:UIControlStateNormal];
        
        smallpenThickBtnlbl.backgroundColor = [UIColor colorWithRed:245.0f / 255.0f green:84.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        self.selectedSmallColor = [UIColor colorWithRed:245.0f / 255.0f green:84.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        [self.drawerFaqsView setLineColor:self.selectedSmallColor];
        smallpenColor_Index = 1;
    }
    else if(smallpenColor_Index == 1)
    {
        [smallpenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"smallPen_greencolor.png"] forState:UIControlStateNormal];
        smallpenThickBtnlbl.backgroundColor = [UIColor colorWithRed:110.0f / 255.0f green:200.0f / 255.0f blue:14.0f / 255.0f alpha:1.0f];
        self.selectedSmallColor = [UIColor colorWithRed:110.0f / 255.0f green:200.0f / 255.0f blue:14.0f / 255.0f alpha:1.0f];
        [self.drawerFaqsView setLineColor:self.selectedSmallColor];
        smallpenColor_Index = 2;
    }
    else if(smallpenColor_Index == 2)
    {
        [smallpenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"smallPen_blackcolor.png"] forState:UIControlStateNormal];        smallpenThickBtnlbl.backgroundColor = [UIColor blackColor];
        self.selectedSmallColor = [UIColor blackColor];
        [self.drawerFaqsView setLineColor:self.selectedSmallColor];
        smallpenColor_Index = 3;
    }
    else if(smallpenColor_Index == 3)
    {
        [smallpenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"smallPen_orangecolor.png"] forState:UIControlStateNormal];
       smallpenThickBtnlbl.backgroundColor = [UIColor colorWithRed:245.0f / 255.0f green:238.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        self.selectedSmallColor = [UIColor colorWithRed:245.0f / 255.0f green:238.0f / 255.0f blue:33.0f / 255.0f alpha:1.0f];
        [self.drawerFaqsView setLineColor:self.selectedSmallColor];
        smallpenColor_Index = 4;
    }
    else if(smallpenColor_Index == 4)
    {
        [smallpenColorBtnlbl setBackgroundImage:[UIImage imageNamed:@"smallPen_bluecolor.png"] forState:UIControlStateNormal];
        smallpenThickBtnlbl.backgroundColor = [UIColor colorWithRed:41.0f / 255.0f green:121.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f];
        self.selectedSmallColor = [UIColor colorWithRed:41.0f / 255.0f green:121.0f / 255.0f blue:255.0f / 255.0f alpha:1.0f];
        [self.drawerView setLineColor:self.selectedSmallColor];
        smallpenColor_Index = 0;
    }
    
}

- (IBAction)on_smallpenThickBtn_Click:(id)sender {
    if(smallpenThick_Index == 0)
    {
        smallpenThickBtnlbl.frame = CGRectMake(smallpenThickBtnlbl.frame.origin.x, smallpenThickBtnlbl.frame.origin.y, smallpenThickBtnlbl.frame.size.width, smallpenThickBtnlbl.frame.size.height+4.5);
        self.selectedSmallWidth = 10.0f;
        [self.drawerFaqsView setLineWidth:self.selectedSmallWidth];
        
        smallpenThick_Index = 1;
    }
    else if(smallpenThick_Index == 1)
    {
        smallpenThickBtnlbl.frame = CGRectMake(smallpenThickBtnlbl.frame.origin.x, smallpenThickBtnlbl.frame.origin.y, smallpenThickBtnlbl.frame.size.width, smallpenThickBtnlbl.frame.size.height+6);
        self.selectedSmallWidth = 15.0f;
        [self.drawerFaqsView setLineWidth:self.selectedSmallWidth];
        smallpenThick_Index = 2;
    }
    else if(smallpenThick_Index == 2)
    {
        smallpenThickBtnlbl.frame = CGRectMake(smallpenThickBtnlbl.frame.origin.x, smallpenThickBtnlbl.frame.origin.y, smallpenThickBtnlbl.frame.size.width, 6);
        self.selectedSmallWidth = 5.0f;
        [self.drawerFaqsView setLineWidth:self.selectedSmallWidth];
        smallpenThick_Index = 0;
    }
    
    smallpenThickBtnlbl.center = CGPointMake(smallpenThickBtnlbl.center.x, 735);
}

@end
