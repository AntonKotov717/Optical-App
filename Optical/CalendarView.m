//
//  CalendarView.m
//  Optical
//
//  Created by Mr.Hwang on 10/15/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import "CalendarView.h"


@interface CalendarView ()


@end

@implementation CalendarView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
          self = [super initWithCoder:aDecoder];
        
        [self SetInitialValue];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
         self = [super initWithFrame:frame];
        
        }
    
    return self;
}

-(void) SetInitialValue
{
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [self addSubview:calendar];
}


-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSString *)date {
    NSLog(@"Selected date = %@",date);
    
    NSDictionary *userInfo;
    
    
    userInfo = @{ @"selectedDate":   date};
    
    
    [[NSNotificationCenter defaultCenter]  postNotificationName:@"setDate" object:nil userInfo:userInfo];
    
}


@end
