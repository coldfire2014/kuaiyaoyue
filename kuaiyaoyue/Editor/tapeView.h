//
//  tapeView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/16.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myImageView.h"
#import <AVFoundation/AVFoundation.h>
@interface tapeView : UIView<AVAudioPlayerDelegate>{
    myImageView* recordBtn;
    myImageView* playBk;
    myImageView* removeBtn;
    UILabel* tapLbl;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    NSTimer* timer;
    NSTimer* playTimer;
    double recorderTime;
}
@property (nonatomic ,strong) NSString* fileName;
-(void)showFile:(NSString*)fn;
-(void)outofScreen;
@end
