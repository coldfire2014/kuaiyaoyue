//
//  ViewCell.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ViewCell.h"
#import "TimeTool.h"

@implementation ViewCell{
    StateView* s;
}

- (void)awakeFromNib {
    // Initialization code
    NSLog(@"%f",_widht);
    s = [[StateView alloc] initWithFrame:CGRectMake(0,-5, 55, 55)];
    
    [_show_time addSubview:s];
    
    _show_img.layer.cornerRadius = 3;
    _show_img.clipsToBounds = YES;
    _show_img.contentMode = UIViewContentModeScaleAspectFill;
    
    _show_send.layer.cornerRadius = 3;
    
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//0自定义，1为婚礼，2为派对

-(void)layoutSubviews{
    [super layoutSubviews];
    int type = _info.neftype;
    long long kstime = 0;
    long long endtime = 0;
    long long hdtime = 0;
    
    switch (type) {
        case 0:
            _show_title.text = _info.neftitle;
            _show_endtime.text = [NSString stringWithFormat:@"报名截止：%@",_info.nefclosetimestamp];
            _show_hdtime.text = [NSString stringWithFormat:@"活动时间：%@",[TimeTool getFullTimeStr:[_info.neftimestamp longLongValue]/1000]];
            [s setState:StateGoing withAll:_info.neftotal andAdd:@""];
            
            kstime = [_info.nefdate longLongValue]/1000;
            endtime = [_info.nefclosetimestamp longLongValue]/1000;
            hdtime = [_info.neftimestamp longLongValue]/1000;
            
            // s:发送时间 。e:报名截止 g:活动时间
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:kstime] EndTime:[NSDate dateWithTimeIntervalSince1970:endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:hdtime]];
            
            break;
        case 1:
            _show_title.text = [NSString stringWithFormat:@"%@&%@ 婚礼",_info.nefgroom,_info.nefbride];
            _show_endtime.text = [NSString stringWithFormat:@"报名截止：%@",[TimeTool getFullTimeStr:[_info.nefclosetimestamp longLongValue]/1000]];
            _show_hdtime.text = [NSString stringWithFormat:@"活动时间：%@",[TimeTool getFullTimeStr:[_info.neftimestamp longLongValue]/1000]];
            [s setState:StateGoing withAll:_info.neftotal andAdd:@""];
            
            kstime = [_info.nefdate longLongValue]/1000;
            endtime = [_info.nefclosetimestamp longLongValue]/1000;
            hdtime = [_info.neftimestamp longLongValue]/1000;
            
            // s:发送时间 。e:报名截止 g:活动时间
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:kstime] EndTime:[NSDate dateWithTimeIntervalSince1970:endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:hdtime]];
            
            break;
        case 2:
            _show_title.text = _info.nefpartyname;
            _show_endtime.text = [NSString stringWithFormat:@"报名截止：%@",_info.nefclosetimestamp];
            _show_hdtime.text = [NSString stringWithFormat:@"活动时间：%@",[TimeTool getFullTimeStr:[_info.neftimestamp longLongValue]/1000]];
            [s setState:StateGoing withAll:_info.neftotal andAdd:@""];
            
            kstime = [_info.nefdate longLongValue]/1000;
            endtime = [_info.nefclosetimestamp longLongValue]/1000;
            hdtime = [_info.neftimestamp longLongValue]/1000;
            
            // s:发送时间 。e:报名截止 g:活动时间
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:kstime] EndTime:[NSDate dateWithTimeIntervalSince1970:endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:hdtime]];
            
            break;
            
        default:
            break;
    }
}

- (IBAction)send_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(VCDelegate:didTapAtIndex:)]){
        [self.delegate VCDelegate:self didTapAtIndex:_index];}
}

@end
