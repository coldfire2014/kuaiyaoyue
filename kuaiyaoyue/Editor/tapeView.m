//
//  tapeView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/16.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "tapeView.h"
#import "StatusBar.h"
#import "waitingView.h"
#import <AVFoundation/AVFoundation.h>
@implementation tapeView

- (instancetype)initWithFrame:(CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self) {
        playBk = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 176.0/2.0, 75.0/2.0) andImageName:@"bg_bubble@2x" withScale:2.0];
        playBk.center = CGPointMake(frame.size.width/2.0, frame.size.height - 40.0/2.0 - 20.0/2.0 - 24.0/2.0 - 120.0/2.0 - 8.0/2.0 - 75.0/4.0);
//        [self setPlay];
        [self setrecord];
        [self addSubview:playBk];
        recordBtn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 120.0/2.0, 120.0/2.0) andImageName:@"btn_120_recording@2x" withScale:2.0];
        recordBtn.center = CGPointMake(frame.size.width/2.0, frame.size.height - 40.0/2.0 - 20.0/2.0 - 24.0/2.0 - 120.0/4.0);
        [self addSubview:recordBtn];
        removeBtn = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 120.0/2.0, 120.0/2.0) andImageName:@"btn_120_recording_del@2x" withScale:2.0];
        removeBtn.alpha = 0;
        removeBtn.center = CGPointMake(frame.size.width/2.0, frame.size.height - 40.0/2.0 - 20.0/2.0 - 24.0/2.0 - 120.0/4.0);
        [self addSubview:removeBtn];
        
        tapLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0,frame.size.height - 40.0/2.0 - 24.0/2.0, frame.size.width, 24.0/2.0)];
        tapLbl.textAlignment = NSTextAlignmentCenter;
        tapLbl.font = [UIFont systemFontOfSize:13];
        tapLbl.backgroundColor = [UIColor clearColor];
        tapLbl.textColor =  [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        tapLbl.text=@"删除录音";
        tapLbl.tag = 510;
        [self addSubview:tapLbl];
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if(session == nil){
            NSLog(@"Error creating session: %@", [sessionError description]);
        }
        else{
            [session setActive:YES error:nil];
        }
        if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
            [session requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    [self setLongPress];
                }
                else {
                    [self gotoSetting];
                }
            }];
        }
    }
    return self;
}
-(void)setrecord{
    UIView *jd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 72.0/6.0)];
    jd.backgroundColor = [UIColor whiteColor];
    jd.tag = 900;
//    jd.alpha = 0;
    jd.center = CGPointMake(playBk.bounds.size.width/2.0, (playBk.bounds.size.height-6)/2.0);
    [playBk addSubview:jd];
    for (int i = 1; i < 10; i++) {
        UIView *jl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 72.0/6.0)];
        jl.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:1.0-0.05*i];
        jl.tag = 900 + i;
//        jl.alpha = 0;
        jl.center = CGPointMake(playBk.bounds.size.width/2.0 + i*4.0, (playBk.bounds.size.height-6)/2.0);
        [playBk addSubview:jl];
        UIView *jr = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 72.0/6.0)];
        jr.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:1.0-0.05*i];
        jr.tag = 800 + i;
//        jr.alpha = 0;
        jr.center = CGPointMake(playBk.bounds.size.width/2.0 - i*4.0, (playBk.bounds.size.height-6)/2.0);
        [playBk addSubview:jr];
    }
}
//for (int i = 1; i < 10; i++) {
//    if (lowPassResults >= 0.02 + (0.30-0.02)/9.0*i) {
//        UIView* l = [playview.lyyl_view viewWithTag:900+i];
//        l.alpha = 1;
//        UIView* r = [playview.lyyl_view viewWithTag:800+i];
//        r.alpha = 1;
//    }else{
//        UIView* l = [playview.lyyl_view viewWithTag:900+i];
//        l.alpha = 0;
//        UIView* r = [playview.lyyl_view viewWithTag:800+i];
//        r.alpha = 0;
//    }
//}
-(void)setPlay{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play)];
    [playBk addGestureRecognizer:tap];
    
    UILabel* tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0,0, playBk.frame.size.width, 64.0/2.0)];
    tipLbl.textAlignment = NSTextAlignmentCenter;
    tipLbl.font = [UIFont systemFontOfSize:16];
    tipLbl.backgroundColor = [UIColor clearColor];
    tipLbl.textColor =  [UIColor whiteColor];
    tipLbl.text=@"听一下";
    tipLbl.tag = 109;
    [playBk addSubview:tipLbl];
    for (int i = 0; i<3; i++) {
        CGFloat r = 48.0/2.0-8.0*i;
        UIView* playItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, r, r)];
        playItem.tag = 110 + i;
        playItem.center = CGPointMake(playBk.frame.size.width - 74.0/4.0, 64.0/4.0);
        playItem.backgroundColor = [UIColor clearColor];
        CAShapeLayer* racetrack = [CAShapeLayer layer];
        racetrack.opacity = YES;
        racetrack.strokeColor = [UIColor whiteColor].CGColor;
        racetrack.fillColor = [UIColor clearColor].CGColor;
        racetrack.lineWidth = 1.0;
        UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(r/2.0, r/2.0)
                                                             radius:r/2.0
                                                         startAngle:-M_PI_4
                                                           endAngle:M_PI_4
                                                          clockwise:YES];
        aPath.lineCapStyle = kCGLineCapSquare; //线条拐角
        aPath.lineJoinStyle = kCGLineCapSquare; //终点处理
        racetrack.path = aPath.CGPath;
        [playItem.layer addSublayer:racetrack];
        [playBk addSubview:playItem];
    }
}
-(void)gotoSetting{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setting)];
    [self addGestureRecognizer:tap];
}
-(void)setting{
    [[StatusBar sharedStatusBar] talkMsg:@"请在设置中开启麦克风。" inTime:1.0];
}
-(void)setLongPress{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tooSmall)];
    [self addGestureRecognizer:tap];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressed:)];
    [self addGestureRecognizer:longPress];
}
-(void)tooSmall{
    [[waitingView sharedwaitingView] WarningByMsg:@"录音时间太短了" haveCancel:NO];
}
//长按事件的实现方法
- (void) LongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        if (is_audio) {
//            curCount = 0;
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setLocale:[NSLocale currentLocale]];
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//            NSString *str = [formatter stringFromDate:[NSDate date]];
//            audioname = [NSString stringWithFormat:@"audio%@.wav", str];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                recordedFile = [[FileManage sharedFileManage] GetYPFile1:audioname];
//                recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath: recordedFile] settings:[self getAudioRecorderSettingDict] error:nil];
//                recorder.meteringEnabled = YES;
//                [recorder prepareToRecord];
//                [recorder record];
//            });
//            
//            
//            player = nil;
//            
//            //启动计时器
//            [self startTimer];
//            
//            [playview.audio_view setHidden:NO];
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                [playview.audio_view setFrame:CGRectMake(playview.audio_view.frame.origin.x, 9, playview.audio_view.frame.size.width, playview.audio_view.frame.size.height)];
//                [playview.audio_view setAlpha:1.0];
//            }];
//            
//            [playview.audio_img setImage:[UIImage imageNamed:@"btn_120_recordingpre"]];
//        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
//        NSLog(@"curCount-%f",curCount);
//        if (is_audio) {
//            [self stopTimer];
//            
//            [recorder stop];
//            recorder = nil;
//            
//            //上传音频
//            if (curCount >= 1) {
//                [playview.audio_view setHidden:NO];
//                [playview.audio_showview setHidden:YES];
//                [playview.del_button setHidden:NO];
//                playview.show_audioname.text = @"删除重录";
//                
//                [playview.lyyl_view setHidden:YES];
//                [playview.tyx_label setHidden:NO];
//                [playview.gif_img setHidden:NO];
//            }
//            else{
//                is_audio = NO;
//                [[waitingView sharedwaitingView] WarningByMsg:@"录音时间太短了" haveCancel:NO];
//                recordedFile = nil;
//                audioname = @"";
//                //            [[StatusBar sharedStatusBar] talkMsg:@"录音时间太短了。" inTime:1.0];
//                
//                [UIView animateWithDuration:0.3 animations:^{
//                    [playview.audio_view setFrame:CGRectMake(playview.audio_view.frame.origin.x, 51, playview.audio_view.frame.size.width, playview.audio_view.frame.size.height)];
//                    [playview.audio_view setAlpha:0.0];
//                    
//                }completion:^(BOOL finished) {
//                    [playview.audio_view setHidden:YES];
//                    [playview.lyyl_view setHidden:NO];
//                    [playview.tyx_label setHidden:YES];
//                    [playview.gif_img setHidden:YES];
//                }];
//                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    is_audio = YES;
//                    [[waitingView sharedwaitingView] stopWait];
//                });
//                
//            }
//            
//            [playview.audio_img setImage:[UIImage imageNamed:@"btn_120_recording"]];
//        }
    }
}
-(void)play{
    
}
@end
