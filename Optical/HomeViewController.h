//
//  HomeViewController.h
//  Optical
//
//  Created by Mr.Hwang on 10/12/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "ProgressGradientView.h"
#import "SelectCounselor.h"

@interface HomeViewController : UIViewController<UIGestureRecognizerDelegate>
{
    
    NSInteger pagenumber;
    NSInteger lastpagenumber;
    
    BOOL patient_flag;
    BOOL txt_flag;
    BOOL menu_flag;
    
    SelectCounselor* counselorVw;
    CalendarView* calendarVw;
    ProgressGradientView *pgv;
    CGFloat progress;
    
////////////////////////////////////////////  Eye page  ////////////////////////////////////////////
    
    BOOL eyehint_flag;
    BOOL eyepagebtn_flag;
    BOOL eyepagePencil_flag;
    
    NSInteger eyepenColor_Index;
    NSInteger eyepenthick_Index;
    
    
////////////////////////////////////////////  Summary page  ////////////////////////////////////////////
    
    BOOL summarycontine_click_flag;
    
    BOOL myopia_flag;
    BOOL presby_flag;
    BOOL astigm_flag;
    BOOL cataract_flag;
    BOOL hypero_flag;
    BOOL kerato_flag;
    
    BOOL lasik_deless_flag;
    BOOL lasik_ded_flag;
    BOOL recomment1_flag,recomment2_flag,recomment3_flag,recomment4_flag;
    BOOL recomment5_flag,recomment6_flag,recomment7_flag,recomment8_flag;
    BOOL prk_flag;
    BOOL icl_flag;
   
    BOOL trad_flag;
    BOOL larse_flag;
    BOOL glaucoma_flag;
    BOOL rle_flag;
    
    ///////// Anatoli
    BOOL smallPenBtn_flag;
    /////////
    
////////////////////////////////////////////  Follow Up page  ////////////////////////////////////////////
    
    BOOL candidate_flag;
    BOOL sendmail_flag;
    NSInteger sel_tag;
    
    NSArray* shareselectInfo;
    
    
}

////////////////////////////////////////////  Home page  ////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UIButton *patientlbl;
@property (weak, nonatomic) IBOutlet UIButton *eyelbl;
@property (weak, nonatomic) IBOutlet UIButton *FAQslbl;
@property (weak, nonatomic) IBOutlet UIButton *aboutuslbl;
@property (weak, nonatomic) IBOutlet UIButton *summarylbl;
@property (weak, nonatomic) IBOutlet UIButton *followuplbl;

@property (nonatomic,retain) IBOutlet UIScrollView *totalscrollVw;

@property (nonatomic,retain) IBOutlet UIView *patientVw;
@property (nonatomic,retain) IBOutlet UIView *eyeVw;
@property (nonatomic,retain) IBOutlet UIScrollView *eyeScrollVw;

@property (nonatomic,retain) IBOutlet UIView *FAQsVw;
@property (nonatomic,retain) IBOutlet UIView *aboutusVw;
@property (nonatomic,retain) IBOutlet UIView *summary;
@property (nonatomic,retain) IBOutlet UIView *followupVw;
@property (weak, nonatomic) IBOutlet UIView *lineVw;

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (weak, nonatomic) IBOutlet UILabel *usernamelbl;
@property (weak, nonatomic) IBOutlet UILabel *menuImgTimer;
@property (weak, nonatomic) IBOutlet UILabel *menuScheduTimer;
@property (weak, nonatomic) IBOutlet UIView *menuhiddenView;

@property (weak, nonatomic) IBOutlet UIButton *menu_logout;



- (IBAction)menu_logoutBtn_click:(id)sender;
- (IBAction)menuBtn_click:(id)sender;

////////////////////////////////////////////  Patient page  ////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UIView *patient_totalVw;
@property (weak, nonatomic) IBOutlet UIImageView *trademarkImgVw;

@property (weak, nonatomic) IBOutlet UIButton *smalleyeBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *smallpenBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *smallpenColorBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *smallpenThickBtnlbl;

@property (weak, nonatomic) IBOutlet UIButton *patient_continueBtnlbl;

@property (weak, nonatomic) IBOutlet UILabel *countxt;

@property (weak, nonatomic) IBOutlet UITextField *patfirstName;
@property (weak, nonatomic) IBOutlet UITextField *patlastName;

- (IBAction)patient_continue_click:(id)sender;




////////////////////////////////////////////  Eye page  ////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UIView *eyepagetotalVw;
@property (weak, nonatomic) IBOutlet UIButton *eyepageBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *eyepagePenBtnlbl;

@property (weak, nonatomic) IBOutlet UIButton *eyepagehintBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *eyepageCameralbl;
@property (weak, nonatomic) IBOutlet UIButton *eyepageTitleBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *eyepageDownarrowlbl;
@property (weak, nonatomic) IBOutlet UIImageView *eyepageImageVw;
@property (weak, nonatomic) IBOutlet UIButton *eyepageCloseBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *eyePenColorBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *eyepenThickBtnlbl;



- (IBAction)eyepageBtn_click:(id)sender;
- (IBAction)eyepagePenBtn_click:(id)sender;
- (IBAction)eyepagehint_click:(id)sender;
- (IBAction)eyepageCamera_click:(id)sender;
- (IBAction)eyepageTitleBtn_click:(id)sender;
- (IBAction)eyepageDownarrowBtn_click:(id)sender;
- (IBAction)eyePenColorBtn_click:(id)sender;
- (IBAction)eyepenThickBtn_click:(id)sender;

- (IBAction)eyeclose:(id)sender;

////////////////////////////////////////////  FAQs and About Us page  ////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UIPageControl *FAQs_pageVw;
@property (weak, nonatomic) IBOutlet UIScrollView *FAQscrollVw;
@property (weak, nonatomic) IBOutlet UIScrollView *aboutscrollVw;

////////////////////////////////////////////  Summary page  ////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UIView *summary_totalVw;
@property (weak, nonatomic) IBOutlet UIButton *summary_continuelbl;
@property (weak, nonatomic) IBOutlet UIButton *myopialbl;
@property (weak, nonatomic) IBOutlet UILabel *summary_datelbl;




- (IBAction)myopiaBtn_click:(id)sender;

- (IBAction)sum_contine_click:(id)sender;



////////////////////////////////////////////  Follow Up page  ////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UIView *follow_totalVw;
@property (weak, nonatomic) IBOutlet UIButton *follow_completelbl;
@property (weak, nonatomic) IBOutlet UIView *lastVw;

@property (weak, nonatomic) IBOutlet UIView *subVw1;
@property (nonatomic,retain) IBOutlet UIView *subVw2;
@property (weak, nonatomic) IBOutlet UIButton *candilbl;
@property (weak, nonatomic) IBOutlet UIButton *sendmaillbl;
@property (weak, nonatomic) IBOutlet UILabel *recommentlbl1;
@property (weak, nonatomic) IBOutlet UILabel *recommentlbl2;
@property (weak, nonatomic) IBOutlet UITextField *emailtxt;
@property (weak, nonatomic) IBOutlet UITextField *addreftxt;
@property (weak, nonatomic) IBOutlet UITextField *pricetxt1;
@property (weak, nonatomic) IBOutlet UITextField *pricetxt2;
@property (weak, nonatomic) IBOutlet UILabel *follow_datelbl;
@property (weak, nonatomic) IBOutlet UIView *select_totalVw;

@property (weak, nonatomic) IBOutlet UIButton *select_closeBtnlbl;
@property (weak, nonatomic) IBOutlet UILabel *select_Titlelbl;
@property (weak, nonatomic) IBOutlet UIButton *follow_eyes1lbl;
@property (weak, nonatomic) IBOutlet UIButton *follow_eyes2lbl;
@property (weak, nonatomic) IBOutlet UIButton *follow_refeBtnlbl;
@property (weak, nonatomic) IBOutlet UITableView *follow_selTableVw;
@property (weak, nonatomic) IBOutlet UIView *select_CalendarVw;
@property (weak, nonatomic) IBOutlet UILabel *Calendar_Titlelbl;
@property (weak, nonatomic) IBOutlet UIButton *preopBtnlbl;
@property (weak, nonatomic) IBOutlet UIButton *surgeryBtnlbl;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *waitlbl;
@property (weak, nonatomic) IBOutlet UILabel *uploadinglbl;



- (IBAction)follow_calcloseBtn_click:(id)sender;
-(void)closecalendar;

- (IBAction)follow_complete_click:(id)sender;

- (IBAction)candidateBtn_click:(id)sender;
- (IBAction)sendmailBtn_click:(id)sender;

- (IBAction)select_closeBtn_click:(id)sender;
- (IBAction)follow_eyesBtn_click:(id)sender;

- (IBAction)follow_Pre_Sur_Date_click:(id)sender;


- (IBAction)category_click:(id)sender;
- (IBAction)eyebotton_click:(id)sender;
- (IBAction)penbottom_click:(id)sender;

@end
