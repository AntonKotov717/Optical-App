//
//  SelectCounselor.h
//  Optical
//
//  Created by Mr.Hwang on 10/16/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCounselor : UIView<UITableViewDelegate, UITableViewDataSource>
{
    NSArray* doctorInfo1;
    NSArray* doctorInfo2;
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *counColseBtnlbl;

@property (weak, nonatomic) IBOutlet UITextField *searchtxt;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;




@end
