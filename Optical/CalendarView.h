//
//  CalendarView.h
//  Optical
//
//  Created by Mr.Hwang on 10/15/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"
#import "NSDate+convenience.h"
#import <EventKit/EventKit.h>


@interface CalendarView : UIView <VRGCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *calendar_Titlelabel;
@property(nonatomic, retain) IBOutlet UIButton * calendar_closeBtnlbl;



@end
