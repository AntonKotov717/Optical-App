//
//  SelectCounselor.m
//  Optical
//
//  Created by Mr.Hwang on 10/16/15.
//  Copyright © 2015 Mr.wang. All rights reserved.
//

#import "SelectCounselor.h"

@interface SelectCounselor()


@end

@implementation SelectCounselor

@synthesize searchtxt, tableView1, tableView2;

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self = [super initWithCoder:aDecoder];
        
        [self setinit];
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


-(void)setinit
{
   
    
    UIGestureRecognizer *singleTapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self addGestureRecognizer:singleTapRecognizer];
    
    //[searchtxt setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIColor *color = [UIColor whiteColor];
    
    searchtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search" attributes:@{NSForegroundColorAttributeName: color}];
    
    doctorInfo1 =  [[NSArray alloc]initWithObjects:@"Demo Counselor (Demo)",  @"Nikki Lapitan", @"Giselle Vides", nil];
    doctorInfo2 =  [[NSArray alloc]initWithObjects:@"Jenifer Kim",  @"Doctor Lee", @"Elizabeth Zazueta", nil];
    
   /* self.tableView1 = [[UITableView alloc] initWithFrame: CGRectMake(219, 182, 320, 150) style:UITableViewStylePlain];
    [self.tableView1 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.tableView1 setBackgroundColor:[UIColor clearColor]];
    [self.tableView1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView1 setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView1 setDelegate:self];
    [self.tableView1 setDataSource:self];
    [self.tableView1 setScrollEnabled:NO];
    [self addSubview:self.tableView1];
    
    tableView2 = [[UITableView alloc] initWithFrame: CGRectMake(550, 182, 320, 150) style:UITableViewStylePlain];
    
    [tableView2 setDelegate:self];
    [tableView2 setDataSource:self];
    //[tableView2 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [tableView2 setBackgroundColor:[UIColor clearColor]];
    [tableView2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView2 setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
   // [tableView1 setSeparatorColor:[UIColor colorWithRed:45.0f/255 green:110.0f/255 blue:162.0f/255 alpha:1.0]];
    [tableView2 setScrollEnabled:NO];
    [self addSubview:tableView2];*/
}

- (void)dismissKeyboard {
    
    [searchtxt resignFirstResponder];
   
}

#pragma Table view code starts from here ----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
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
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doctor1Clicked:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    
    UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doctor2Clicked:)];
    singleTap1.numberOfTapsRequired = 1;
    singleTap1.numberOfTouchesRequired = 1;
    
    cell.backgroundColor = [UIColor colorWithRed:53.0f / 255.0f green:114.0f / 255.0f blue:168.0f / 255.0f alpha:1.0f];
   
    
    /*cell.preservesSuperviewLayoutMargins = NO;
    cell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);*/
    
    if(tableView == tableView1)
    {
      cell.textLabel.text = doctorInfo1[indexPath.row];
      [cell addGestureRecognizer:singleTap];
    }
    else if(tableView == tableView2)
    {
     cell.textLabel.text = doctorInfo2[indexPath.row];
     [cell addGestureRecognizer:singleTap1];
    }
   
    
    cell.textLabel.textColor = [UIColor colorWithRed:231.0f / 255.0f green:231.0f / 255.0f blue:231.0f / 255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22.0];
    
    
    [cell setUserInteractionEnabled:YES];
    
    
   return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void)doctor1Clicked:(UITapGestureRecognizer *)gesture
{
    NSLog(@"%ld index clicked", (long)gesture.view.tag);
    
    NSDictionary *userInfo;
    
    
    userInfo = @{ @"doctorName":   doctorInfo1[gesture.view.tag]};
    
    
    [[NSNotificationCenter defaultCenter]  postNotificationName:@"SelectDoctor" object:nil userInfo:userInfo];
    
}

-(void)doctor2Clicked:(UITapGestureRecognizer *)gesture
{
    NSLog(@"%ld index clicked", (long)gesture.view.tag);
    
    NSDictionary *userInfo;
    
    
    userInfo = @{ @"doctorName":   doctorInfo2[gesture.view.tag]};
    
    
    [[NSNotificationCenter defaultCenter]  postNotificationName:@"SelectDoctor" object:nil userInfo:userInfo];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
     
    return TRUE;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
   
    
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
          
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}


@end
