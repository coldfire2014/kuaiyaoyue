//
//  ShowData.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/20.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ShowData.h"

@implementation ShowData{
    NSString *timebh;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    [_picker addTarget:self action:@selector(DatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_picker setMinimumDate:[NSDate date]];
    
}

- (void)DatePickerValueChanged:(UIDatePicker *) sender {
    NSDate *select = [sender date]; // 获取被选中的时间
    timebh = [NSString stringWithFormat:@"%lld", ((long long)[select timeIntervalSince1970] *1000)];
}

- (IBAction)sure_picker:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SDDelegate:didTapAtIndex:)]){
        [self.delegate SDDelegate:self didTapAtIndex:timebh];}
}

- (IBAction)qx_picker:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SDDelegate:didTapAtIndex:)]){
        [self.delegate SDDelegate:self didTapAtIndex:nil];}
}

- (void)SDDelegate:(ShowData *)cell didTapAtIndex:(NSString *) timebh{
    
}

@end
