//
//  VRGCalendarView.h
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIColor+expanded.h"

#define kVRGCalendarViewTopBarHeight 80
#define kVRGCalendarViewWidth 520

#define kVRGCalendarViewDayWidth 74
#define kVRGCalendarViewDayHeight 68

@protocol VRGCalendarViewDelegate;
@interface VRGCalendarView : UIView {
    id <VRGCalendarViewDelegate> delegate;
    
    NSDate *currentMonth;
    
    UILabel *labelCurrentMonth;
    
    BOOL isAnimating;
    BOOL prepAnimationPreviousMonth;
    BOOL prepAnimationNextMonth;
    
    
    UIImageView *animationView_A;
    UIImageView *animationView_B;
    
    NSMutableArray *markedDates;
    NSArray *markedColors;
    
    NSInteger month_count;
}
@property (strong, nonatomic) NSMutableArray *selday;
@property (nonatomic, retain) id <VRGCalendarViewDelegate> delegate;
@property (nonatomic, retain) NSDate *currentMonth;
@property (nonatomic, retain) UILabel *labelCurrentMonth;
@property (nonatomic, retain) UIImageView *animationView_A;
@property (nonatomic, retain) UIImageView *animationView_B;
@property (strong, nonatomic)  NSMutableArray *markedDates;
@property (nonatomic, retain) NSArray *markedColors;
@property (nonatomic, getter = calendarHeight) float calendarHeight;
@property (nonatomic, retain, getter = selectedDate) NSDate *selectedDate;

-(void)selectDate:(int)date;
-(void)reset;

-(void)markDates:(NSMutableArray *)dates;
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors;

-(void)showNextMonth;
-(void)showPreviousMonth;

-(int)numRows;
-(void)updateSize;
-(UIImage *)drawCurrentState;

@end

@protocol VRGCalendarViewDelegate <NSObject>
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated;
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSString *)date;
@end
