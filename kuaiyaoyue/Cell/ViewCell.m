//
//  ViewCell.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ViewCell.h"
#import "TimeTool.h"
#import "FileManage.h"
#import "UIImageView+AFNetworking.h"
#import "ZipDown.h"
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
    
    _show_img.userInteractionEnabled = YES;
    
    _show_send.layer.cornerRadius = 3;
    
    _show_newview.layer.cornerRadius = 9;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareonclick:)];
    
    [_show_img addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutSubviews) name:@"MSG_MYLIST_CLICK" object:nil];

}

- (void)shareonclick:(UITapGestureRecognizer *)gr{
    if (self.delegate && [self.delegate respondsToSelector:@selector(VCDelegate:didTapAtIndex:type:)]){
        [self.delegate VCDelegate:self didTapAtIndex:_index type:1];}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//0自定义，1为婚礼，2为派对

-(void)layoutSubviews{
    [super layoutSubviews];
    int type = _info.neftype;
    NSTimeInterval kstime = 0;
    NSTimeInterval endtime = 0;
    NSTimeInterval hdtime = 0;
    NSString *topimg = nil;
    NSDate* dd = [NSDate dateWithTimeIntervalSince1970:[_info.nefclosetimestamp doubleValue]/1000.0];
    
    if ([_info.nefnumber intValue] > 0) {
        [_show_newview setHidden:NO];
    }else{
        [_show_newview setHidden:YES];
    }
    
    _show_newnum.text = _info.nefnumber;
    
    if (type == 0) {
        NSArray *array = [_info.neflogo componentsSeparatedByString:@"/"];
        topimg = [array objectAtIndex:([array count] - 1)];
        topimg = [[FileManage sharedFileManage] getImgFile:topimg];
    }else{
        NSArray *array = [_info.nefthumb componentsSeparatedByString:@"/"];
        NSString *topName = [array objectAtIndex:([array count] - 4)];
        topimg = [[FileManage sharedFileManage] getThumb:topName];
        topimg = [NSString stringWithFormat:@"%@/assets/images/thumb",topimg];
        if (![[NSFileManager defaultManager] fileExistsAtPath:topimg]) {
            [ZipDown UnzipSingle:topName];
        }
    }
    
    UIImage *img = [[UIImage alloc]initWithContentsOfFile:topimg];
    switch (type) {
        case 0:
            _show_title.text = _info.neftitle;
            
            _show_endtime.text = [NSString stringWithFormat:@"报名截止: %@",[TimeTool TopJZTime:dd]];
            _show_hdtime.text = [NSString stringWithFormat:@"活动时间: %@",[TimeTool getFullTimeStr:[_info.neftimestamp doubleValue]/1000.0]];
            [s setState:StateGoing withAll:_info.neftotal andAdd:@""];
            
            kstime = [_info.nefdate doubleValue]/1000.0;
            endtime = [_info.nefclosetimestamp doubleValue]/1000.0;
            hdtime = [_info.neftimestamp doubleValue]/1000.0;
            
            if (img == nil) {

                [_show_img setImageWithURL:[NSURL URLWithString:_info.neflogo] placeholderImage:[UIImage imageNamed:@"icon120.png"]];
            }else{
                _show_img.image = img;
            }
            
            // s:发送时间 。e:报名截止 g:活动时间
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:kstime] EndTime:[NSDate dateWithTimeIntervalSince1970:endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:hdtime]];
            
            break;
        case 1:
            _show_title.text = [NSString stringWithFormat:@"%@&%@ 婚礼",_info.nefgroom,_info.nefbride];
            _show_endtime.text = [NSString stringWithFormat:@"报名截止: %@",[TimeTool TopJZTime:dd]];
            _show_hdtime.text = [NSString stringWithFormat:@"活动时间: %@",[TimeTool getFullTimeStr:[_info.neftimestamp doubleValue]/1000.0]];
            _show_img.image = img;
            
            [s setState:StateGoing withAll:_info.neftotal andAdd:@""];
            
            kstime = [_info.nefdate doubleValue]/1000.0;
            endtime = [_info.nefclosetimestamp doubleValue]/1000.0;
            hdtime = [_info.neftimestamp doubleValue]/1000.0;
            
            // s:发送时间 。e:报名截止 g:活动时间
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:kstime] EndTime:[NSDate dateWithTimeIntervalSince1970:endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:hdtime]];
            
            
            break;
        case 2:
            _show_title.text = _info.nefpartyname;
            _show_endtime.text = [NSString stringWithFormat:@"报名截止: %@",[TimeTool TopJZTime:dd]];
            _show_hdtime.text = [NSString stringWithFormat:@"活动时间: %@",[TimeTool getFullTimeStr:[_info.neftimestamp doubleValue]/1000.0]];
            [s setState:StateGoing withAll:_info.neftotal andAdd:@""];
            
            kstime = [_info.nefdate doubleValue]/1000.0;
            endtime = [_info.nefclosetimestamp doubleValue]/1000.0;
            hdtime = [_info.neftimestamp doubleValue]/1000.0;
            
            _show_img.image = img;
            
            // s:发送时间 。e:报名截止 g:活动时间
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:kstime] EndTime:[NSDate dateWithTimeIntervalSince1970:endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:hdtime]];
            
            break;
            
        default:
            break;
    }
    
    if ([[TimeTool TopJZTime:dd] isEqualToString:@"已截止"]) {
        [_show_send setBackgroundColor:[UIColor lightGrayColor]];
        [_show_send setEnabled:NO];
        [_send_obutton setEnabled:NO];
    }else{
        [_show_send setEnabled:YES];
        [_send_obutton setEnabled:YES];
        UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [_show_send setBackgroundColor:color];
    }
    
}

- (IBAction)send_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(VCDelegate:didTapAtIndex:type:)]){
        [self.delegate VCDelegate:self didTapAtIndex:_index type:0];}
}

@end
