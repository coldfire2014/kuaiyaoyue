//
//  CHWLEditorViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "CHWLEditorViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "GridInfo.h"
#import "PhotoCell.h"
#import "picViewAnimate.h"
#import "ImgCollectionViewController.h"
#import "ShowData.h"
#import "TimeTool.h"
#import "FileManage.h"
#import "DataBaseManage.h"
#import "NSInfoImg.h"
#import "Info.h"
#import "Fixeds.h"
#import "UDObject.h"
#import "HttpManage.h"
#import "StatusBar.h"
#import "PlayView.h"
#import "PreviewViewController.h"

@interface CHWLEditorViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate,SDDelegate,PVDelegate,AVAudioPlayerDelegate>{
    BOOL is_yl;
    int count;
    PlayView *playview;
    NSMutableArray *addimg;
    int row_index;
    
    AssetHelper* assert;
    ShowData *show;
    NSString *hltime;
    NSString *bmendtime;
    BOOL time_type;
    
    UICollectionView *gridview;
    
    UIScrollView *scrollview;
    NSMutableArray *data;
    NSMutableArray *imgdata;
    
    NSString * ypurl;
    
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    NSString *audioname;
    NSTimer *timer;
    CGFloat curCount;
    double lowPassResults;
    NSString *recordedFile;
    
    NSString *jh_name;
    NSString *address_name;
    NSString *xlr_name;
    NSString *xxfs_name;
    NSString *wxts_name;
}

@end

@implementation CHWLEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    audioname = @"";
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"快邀约";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setTintColor:color];
    
    assert = ASSETHELPER;
    assert.bReverse = YES;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleBordered target:self action:@selector(RightBarBtnClicked:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    imgdata = [[NSMutableArray alloc] init];
    data = [[NSMutableArray alloc] init];
    
    [self addview];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([PhotoCell class]) bundle:nil];
    [gridview registerNib:nib forCellWithReuseIdentifier:@"PhotoCell"];
    [self getHistorical];
    
    playview.audio_showview.userInteractionEnabled = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(send_onclick:)];
    
    [_send_view addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendandshare_onclick:)];
    
    [_sendshare_view addGestureRecognizer:tap1];
    
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    
    else
        [session setActive:YES error:nil];
    
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session requestRecordPermission:^(BOOL granted) {
            if (granted) {
                [self ypviewsx];
            }
            else {
                [self ypviewsx1];
            }
        }];
    }
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editviewonclick:)];
    [playview.editview addGestureRecognizer:tap2];
}

- (void)editviewonclick:(UITapGestureRecognizer *)gr{
    [self.view endEditing:NO];
    [playview.editview setHidden:YES];
}

-(void)ypviewsx{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(LongPressed:)];
    
    longPress.allowableMovement = NO;
    longPress.minimumPressDuration = 0.0;
    //将长按手势添加到需要实现长按操作的视图里
    [playview.audio_showview addGestureRecognizer:longPress];
    
    
}

-(void)ypviewsx1{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(LongPressed1:)];
    
    longPress.allowableMovement = NO;
    longPress.minimumPressDuration = 0.0;
    //将长按手势添加到需要实现长按操作的视图里
    [playview.audio_showview addGestureRecognizer:longPress];
    
    
}

//长按事件的实现方法
- (void) LongPressed1:(UILongPressGestureRecognizer *)gestureRecognizer {
    [SVProgressHUD dismissWithError:@"请打开麦克风" afterDelay:1];
}

//长按事件的实现方法
- (void) LongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        curCount = 0;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *str = [formatter stringFromDate:[NSDate date]];
        audioname = [NSString stringWithFormat:@"audio%@.wav", str];
        
        recordedFile = [[FileManage sharedFileManage] GetYPFile:audioname];
        
        recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath: recordedFile] settings:[self getAudioRecorderSettingDict] error:nil];
        
        recorder.meteringEnabled = YES;
        [recorder prepareToRecord];
        [recorder record];
        player = nil;
        
        //启动计时器
        [self startTimer];
        
        [playview.audio_view setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^{
            [playview.audio_view setFrame:CGRectMake(playview.audio_view.frame.origin.x, 9, playview.audio_view.frame.size.width, playview.audio_view.frame.size.height)];
            [playview.audio_view setAlpha:1.0];
        }];
        
        [playview.audio_img setImage:[UIImage imageNamed:@"btn_120_recordingpre"]];
        
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"curCount-%f",curCount);
        [self stopTimer];
        
        [recorder stop];
        recorder = nil;
        
        //上传音频
        if (curCount >= 1) {
            [playview.audio_view setHidden:NO];
            [playview.audio_showview setHidden:YES];
            [playview.del_button setHidden:NO];
            playview.show_audioname.text = @"删除重录";
            
            
        }
        else{
            recordedFile = nil;
            audioname = @"";
            [SVProgressHUD showErrorWithStatus:@"发送时间过短" duration:1];
            
            [UIView animateWithDuration:0.3 animations:^{
                [playview.audio_view setFrame:CGRectMake(playview.audio_view.frame.origin.x, 51, playview.audio_view.frame.size.width, playview.audio_view.frame.size.height)];
                [playview.audio_view setAlpha:0.0];
                
            }completion:^(BOOL finished) {
                [playview.audio_view setHidden:YES];
            }];
        }
        
        [playview.audio_img setImage:[UIImage imageNamed:@"btn_120_recording"]];
    }
}

#pragma mark - 启动定时器
- (void)startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
    
}

-(void)levelTimer:(NSTimer*)timer_
{
    [recorder updateMeters];
    curCount += 0.1;
    
    if (curCount >= 30) {
        [self stopTimer];
        [recorder stop];
        recorder = nil;
        [SVProgressHUD showErrorWithStatus:@"发送时间太长" duration:1];
    }
    
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
    curCount += 0.1;
    if (lowPassResults >=0.22) {
       
    }
    else if (lowPassResults>=0.2) {
        
    }else if(lowPassResults>=0.15){
        
    }else if(lowPassResults>=0.1){
        
    }else if(lowPassResults>=0.5){
        
    }else{
        
    }
    
}

#pragma mark - 停止定时器
- (void)stopTimer{
    if (timer && timer.isValid){
        [timer invalidate];
        timer = nil;
    }
}

/**
 获取录音设置
 @returns 录音设置
 */
//原来的
- (NSDictionary*)getAudioRecorderSettingDict
{
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                                   [NSNumber numberWithFloat:10000.0],AVSampleRateKey,
                                   [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                                   [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                   nil];
    return recordSetting;
}

-(void)changeHigh{
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:NO];
}

-(void)addview{
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 50 - 64)];
    scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollview];
    
    playview = [[[NSBundle mainBundle] loadNibNamed:@"PlayView" owner:self options:nil] firstObject];
    playview.frame = CGRectMake(0, 0, self.view.frame.size.width, playview.frame.size.height);
    playview.backgroundColor = [UIColor clearColor];
    playview.delegate = self;
    playview.jh_edit.delegate = self;
    playview.address_edit.delegate = self;
    playview.xlr_edit.delegate = self;
    playview.xlfs_edit.delegate = self;
    playview.show_summary.delegate = self;
    
    playview.text_label_num.text = [NSString stringWithFormat:@"剩余%d字",70-playview.show_summary.text.length];
    
    gridview = playview.girdview;
    gridview.delegate = self;
    gridview.dataSource = self;
    scrollview.delegate = self;
    [scrollview addSubview:playview];
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, 790)];
    
    NSString* name = @"ShowData";
    show = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] firstObject];
    show.delegate = self;
    show.center = CGPointMake( self.view.frame.size.width/2.0,  self.view.frame.size.height*3.0/2.0);
    show.backgroundColor = [UIColor clearColor];
    [self.view addSubview:show];
}

-(void)getHistorical{
    count = 9;
    if ([UDObject getwljh_name].length > 0) {
        playview.jh_edit.text = [UDObject getwljh_name];
        hltime = [UDObject gewltime];
        bmendtime = [UDObject getwlbmendtime];
        playview.time_label.text = [TimeTool getFullTimeStr:[hltime longLongValue]/1000];
        playview.bmtime_label.text = [TimeTool getFullTimeStr:[bmendtime longLongValue]/1000];
        playview.address_edit.text = [UDObject getwladdress_name];
        playview.xlr_edit.text = [UDObject getwllxr_name];
        playview.xlfs_edit.text = [UDObject getwllxfs_name];
        playview.show_summary.text = [UDObject getwlts_name];
        
        if ([UDObject getwlaudio].length > 0) {
            NSArray *array = [[UDObject getwlaudio] componentsSeparatedByString:@"/"];
            audioname = [array objectAtIndex:([array count] - 1)];
            recordedFile = [[FileManage sharedFileManage] GetYPFile:audioname];
        
            [playview.audio_view setFrame:CGRectMake(playview.audio_view.frame.origin.x, 9, playview.audio_view.frame.size.width, playview.audio_view.frame.size.height)];
            [playview.audio_view setAlpha:1.0];
            [playview.audio_view setHidden:NO];
            [playview.audio_showview setHidden:YES];
            [playview.del_button setHidden:NO];
            playview.show_audioname.text = @"删除重录";
        }
        
        NSArray *arr = [[UDObject getwlimgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
        NSString *name = @"";
        if ([arr count] > 0) {
            name = [arr objectAtIndex:0];
        }
        if (name.length > 0) {
            
            for (NSString *name in arr) {
                NSArray *array = [name componentsSeparatedByString:@"/"];
                NSString *imgname = [array objectAtIndex:([array count] - 1)];
                NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: imgname];
                UIImage *img = [[UIImage alloc]initWithContentsOfFile:imgpath];
                GridInfo *info = [[GridInfo alloc] initWithDictionary:YES :img];
                [data addObject:info];
            }
            count -= [arr count];
        }
    }
    [self initImgData];
}

-(void)sethigh{
    long index = [data count];
    long height = 130 + 155 + (gridview.frame.size.width - 2*9)/3 + 9 + 10;
    long addheight = (gridview.frame.size.width - 2*9)/3 + 9;
    
//    NSLog(@"%f",moreview.girdview.frame.origin.y);
    
    if (index <= 3) {
        playview.bottom_view.frame = CGRectMake(0, playview.bottom_view.frame.origin.y, playview.bottom_view.frame.size.width, height);
        gridview.frame = CGRectMake(playview.girdview.frame.origin.x, playview.girdview.frame.origin.y, playview.girdview.frame.size.width, addheight);
    }else if(index > 3 && index <= 6){
        playview.bottom_view.frame = CGRectMake(playview.bottom_view.frame.origin.x, playview.bottom_view.frame.origin.y, playview.bottom_view.frame.size.width, height+addheight);
        gridview.frame = CGRectMake(playview.girdview.frame.origin.x, playview.girdview.frame.origin.y, playview.girdview.frame.size.width, addheight*2);
    }else if(index > 6){
        playview.bottom_view.frame = CGRectMake(playview.bottom_view.frame.origin.x, playview.bottom_view.frame.origin.y, playview.bottom_view.frame.size.width, height+addheight*2);
        gridview.frame = CGRectMake(playview.girdview.frame.origin.x, playview.girdview.frame.origin.y, playview.girdview.frame.size.width, addheight*3);
    }
    playview.audiobottomview.frame = CGRectMake(playview.audiobottomview.frame.origin.x,gridview.frame.origin.y+gridview.frame.size.height + 10, playview.audiobottomview.frame.size.width, playview.audiobottomview.frame.size.height);
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, playview.bottom_view.frame.origin.y + playview.bottom_view.frame.size.height+50)];
}

-(void)RightBarBtnClicked:(id)sender{
    //preview
    is_yl = NO;
    [self SendUp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    is_yl = YES;
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, -1000)];
}

-(void)initImgData{
    GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
    [data addObject:info];
    [gridview reloadData];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"imgSelect"] == NSOrderedSame ) {
        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
        des.maxCount = count;
        des.needAnimation = NO;
        des.delegate = self;
    }else if ([segue.identifier compare:@"preview"] == NSOrderedSame){
        PreviewViewController *view = (PreviewViewController*)segue.destinationViewController;
        view.type = 2;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([data count] > 9) {
        return 9;
    }else{
        return [data count];
    }
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((gridview.frame.size.width - 2*9)/3, (gridview.frame.size.width - 2*9)/3);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridInfo *info = [data objectAtIndex:[indexPath row]];
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.index = [indexPath row];
    cell.delegate = self;
    
    //    cell.add_view.backgroundColor = self.nowkColor;
    if (info.is_open) {
        [cell.del_button setHidden:NO];
        cell.show_img.image = info.img;
        cell.show_img.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            cell.show_img.alpha = 1;
        }];
    }else{
        [cell.del_button setHidden:YES];
        cell.show_img.image = nil;
    }
    
    cell.show_img.clipsToBounds = YES;
    cell.show_img.contentMode = UIViewContentModeScaleAspectFill;
    
    //    _bottomview.clipsToBounds = YES;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GridInfo *info = [data objectAtIndex:[indexPath row]];
    if (!info.is_open) {
        [self.view endEditing:NO];
        [self performSegueWithIdentifier:@"imgSelect" sender:nil];
    }else{
    }
}

- (void)PhotoCellDelegate:(PhotoCell *)cell didTapAtIndex:(long ) index{
    GridInfo *info = [data objectAtIndex:index];
    [data removeObject:info];
    [gridview reloadData];
    count ++;
    //    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

-(void)didSelectAssets:(NSArray*)items{
    NSLog(@"%@",items);
    for (int i = 0; i < items.count; i++)
    {
        ALAsset* al = [items objectAtIndex:i];
        UIImage *img = [assert getImageFromAsset:al type:ASSET_PHOTO_SCREEN_SIZE];
        GridInfo *info = [[GridInfo alloc] initWithDictionary:YES :img];
        [data addObject:info];
    }
    
    for (int j = 0;j< [data count] ; j++) {
        GridInfo *info = [data objectAtIndex:j];
        if (!info.is_open) {
            [data removeObject:info];
        }
    }
    
    GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
    [data addObject:info];
    [gridview reloadData];
    count -= items.count;
    
    //   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

- (void)PVDelegate:(PlayView *)cell didTapAtIndex:(int) type{
    if (type == 0) {
        time_type = YES;
        [self.view endEditing:NO];
        [UIView animateWithDuration:0.4f animations:^{
            show.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if (type == 1){
        [self.view endEditing:NO];
        if (hltime != nil) {
            time_type = NO;
            NSDate * date=[NSDate dateWithTimeIntervalSince1970:([hltime longLongValue]/1000)];
            [show.picker setMaximumDate:date];
            [UIView animateWithDuration:0.4f animations:^{
                show.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    }else if (type == 2){
        if (recordedFile.length > 0) {
            [self AudioPlay];
        }
    }else if (type == 3){
        recordedFile = nil;
        audioname = @"";
        [playview.audio_showview setHidden:NO];
        [playview.del_button setHidden:YES];
        playview.show_audioname.text = @"长按录制";
        [UIView animateWithDuration:0.3 animations:^{
            [playview.audio_view setFrame:CGRectMake(playview.audio_view.frame.origin.x, 51, playview.audio_view.frame.size.width, playview.audio_view.frame.size.height)];
            [playview.audio_view setAlpha:0.0];
            
        }completion:^(BOOL finished) {
            [playview.audio_view setHidden:YES];
        }];

    }
}

- (void)SDDelegate:(ShowData *)cell didTapAtIndex:(NSString *) timebh{
    if (timebh != nil) {
        if (time_type) {
            hltime = timebh;
            playview.time_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
        }else{
            bmendtime = timebh;
            playview.bmtime_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
        }
    }
    [UIView animateWithDuration:0.4f animations:^{
        show.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
    }
    if (textField == playview.xlr_edit || textField == playview.xlfs_edit) {
        [UIView animateWithDuration:0.3 animations:^{
            [scrollview setContentOffset:CGPointMake(0, 150)];
        }];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == playview.jh_edit || textField == playview.xlr_edit) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }else if (textField == playview.address_edit){
        if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
        }
    }else if (textField == playview.xlfs_edit){
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [scrollview setContentOffset:CGPointMake(0, 290)];
    }];
    
    [playview.editview setHidden:NO];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%d",textView.text.length);
    if(textView == playview.show_summary){
        if (textView.text.length > 70) {
            textView.text = [textView.text substringToIndex:70];
        }
        NSLog(@"%d",textView.text.length);
        playview.text_label_num.text = [NSString stringWithFormat:@"剩余%d",70-textView.text.length];
    }
    
    return YES;
}

-(void)AudioPlay{
    NSError *playerError;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: recordedFile] error:&playerError];
    [player prepareToPlay];
    player.volume = 10.0f;
    player.delegate = self;
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    //    player.delegate = self;
    if([player isPlaying])
    {
        [player pause];
    }
    //If the track is not player, play the track and change the play button to "Pause"
    else
    {
        [player play];
        
        playview.gif_img.animationImages = [NSArray arrayWithObjects:
                                          [UIImage imageNamed:@"bubble_play_1"],
                                          [UIImage imageNamed:@"bubble_play_2"],
                                          [UIImage imageNamed:@"bubble_play_3"],
                                          nil];
        
        playview.gif_img.animationDuration = 1.25;
        playview.gif_img.animationRepeatCount = 0;
        [playview.gif_img startAnimating];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        [playview.gif_img stopAnimating];
        [playview.gif_img setImage:[UIImage imageNamed:@"bubble_play_3"]];
        
    }
}

- (void)send_onclick:(UITapGestureRecognizer *)gr{
    [self SendUp];
}

- (void)sendandshare_onclick:(UITapGestureRecognizer *)gr{
    
}


-(void)SendUp{
    jh_name = playview.jh_edit.text;
    address_name = playview.address_edit.text;
    xlr_name = playview.xlr_edit.text;
    xxfs_name = playview.xlfs_edit.text;
    
    if (jh_name.length > 0 && address_name.length > 0 && hltime.length > 0 && bmendtime.length > 0 && xlr_name.length > 0 && xxfs_name.length > 0) {
        [self setbg];
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"内容不能为空" inTime:0.5];
    }
    
}

-(void)setbg{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *urlpath = [documentsDirectory stringByAppendingString:_nefmbdw];
    UIImage *bgimg = [self getimg:urlpath];
    [self upmbdt:bgimg];
}

-(UIImage *)getimg :(NSString *) str{
    NSArray *dataarray = [[DataBaseManage getDataBaseManage] GetInfo:_unquieId];
    NSInfoImg* infodata = [[NSInfoImg alloc] initWithbgImagePath:str];//背景图文件路径
    
    CGFloat red1 = 0.0;
    CGFloat green1 = 0.0;
    CGFloat blue1 = 0.0;
    
    for (int i = 0; i < [dataarray count]; i++) {
        Info *info = [dataarray objectAtIndex:i];
        NSString *parameterName = info.nefparametername;
        CGFloat x = [info.nefx floatValue];
        CGFloat y = [info.nefy floatValue];
        CGFloat w = [info.nefwidth floatValue];
        CGFloat h = [info.nefheight floatValue];
        NSString *rgb = info.neffontcolor;
        NSString *a = [rgb substringToIndex:3];
        a = [a substringFromIndex:1];
        CGFloat b = strtoul([a UTF8String],0,16);
        NSString *c = [rgb substringToIndex:5];
        c = [c substringFromIndex:3];
        CGFloat d = strtoul([c UTF8String],0,16);
        NSString *f = [rgb substringFromIndex:5];
        CGFloat e = strtoul([f UTF8String],0,16);
        CGFloat size = [info.neffontsize floatValue];
        
        red1 = b;
        green1 = d;
        blue1 = e;
        
        if ([parameterName isEqualToString:@"partyName"]) {
            
            [infodata addInfoWithValue:playview.jh_edit.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
            
        }else if ([parameterName isEqualToString:@"timestamp"]) {
            
            [infodata addInfoWithValue:playview.time_label.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
            
        }else if ([parameterName isEqualToString:@"address"]) {
            [infodata addInfoWithValue:playview.address_edit.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }else if ([parameterName isEqualToString:@"description"]) {
            NSString *content = playview.show_summary.text;
            if (content.length > 0) {
                [infodata addInfoWithValue:playview.show_summary.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:NO:YES];
            }
        }
    }
    NSArray *fixeds = [[DataBaseManage getDataBaseManage] GetFixeds:_unquieId];
    for (Fixeds *info in fixeds) {
        CGFloat x = info.nefX;
        CGFloat y = info.nefY;
        CGFloat w = info.nefWidth;
        CGFloat h = info.nefHeight;
        CGFloat size = info.nefFontSize;
        [infodata addInfoWithValue:info.nefContent andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
    }
    UIImage *bgimg = [infodata getSaveImg :YES];
    return bgimg;
}

-(void)upmbdt:(UIImage *)img{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    addimg = [[NSMutableArray alloc] init];
    [UDObject setMbimg:[NSString stringWithFormat:@"../Image/%@",uuid]];
    [UIImageJPEGRepresentation(img,0.8) writeToFile:imgpath atomically:YES];
    
    if (is_yl) {
        [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeBlack];
        [HttpManage uploadTP:img name:uuid cb:^(BOOL isOK, NSString *URL) {
            NSLog(@"%@",URL);
            if (isOK) {
                imgdata = [[NSMutableArray alloc] init];
                if (recordedFile.length > 0) {
                    [HttpManage uploadYP:recordedFile name:audioname cb:^(BOOL isOK, NSString *URL1) {
                        NSLog(@"%@",URL1);
                        if (isOK) {
                            if ([data count] - 1 > 0) {
                                row_index = 0;
                                GridInfo *info = [data objectAtIndex:row_index];
                                [self postupload:info.img :URL :URL1] ;
                            }else{
                                NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                                [self party:playview.jh_edit.text :playview.xlr_edit.text :playview.xlfs_edit.text :playview.address_edit.text :arr :@"" :hltime :bmendtime :playview.show_summary.text :URL :_unquieId :URL1];
                            }
                        }else{
                            [SVProgressHUD dismiss];
                            [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
                        }
                    }];
                }else{
                    if ([data count] - 1 > 0) {
                        row_index = 0;
                        GridInfo *info = [data objectAtIndex:row_index];
                        [self postupload:info.img :URL :@""] ;
                    }else{
                        NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                        [self party:playview.jh_edit.text :playview.xlr_edit.text :playview.xlfs_edit.text :playview.address_edit.text :arr :@"" :hltime :bmendtime :playview.show_summary.text :URL :_unquieId :@""];
                    }
                }
            }else{
                [SVProgressHUD dismiss];
                [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
            }
        }];
    }else{
            if ([data count] - 1 > 0) {
                    for (int i = 0; i<[data count] - 1; i++) {
                        GridInfo *info = [data objectAtIndex:i];
                        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
                        NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
                        uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
                        NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
                        [addimg addObject:[NSString stringWithFormat:@"../Image/%@",uuid]];
                        [UIImageJPEGRepresentation(info.img,0.8) writeToFile:imgpath atomically:YES];
                    }
                }
                NSArray *arr = [[NSArray alloc] initWithArray:addimg];
                NSString *hlarr = [arr componentsJoinedByString:@","];
                NSString *audioname1 = [NSString stringWithFormat:@"../Audio/%@",audioname];
        
                [UDObject setWLContent:playview.jh_edit.text wltime:hltime wlbmendtime:bmendtime wladdress_name:playview.address_edit.text wllxr_name:playview.xlr_edit.text wllxfs_name:playview.xlfs_edit.text wlts_name:playview.show_summary.text wlaudio:audioname1 wlimgarr:hlarr];
                [self performSegueWithIdentifier:@"preview" sender:nil];
    }
}

-(void)postupload :(UIImage *) img :(NSString *)URL :(NSString *)URL1{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    [addimg addObject:[NSString stringWithFormat:@"../Image/%@",uuid]];
    [UIImageJPEGRepresentation(img,0.8) writeToFile:imgpath atomically:YES];
    [HttpManage uploadTP:img name:uuid  cb:^(BOOL isOK, NSString *arry) {
        if (isOK) {
            //解析服务器图片名称
            [imgdata addObject:arry];
            row_index ++;
            if (row_index > [data count] - 2) {
                NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                [self party:playview.jh_edit.text :playview.xlr_edit.text :playview.xlfs_edit.text :playview.address_edit.text :arr :@"" :hltime :bmendtime :playview.show_summary.text :URL :_unquieId :URL1];
                
            }else{
                GridInfo *info = [data objectAtIndex:row_index];
                [self postupload:info.img :URL :URL1];
            }
        }else{
            [SVProgressHUD dismiss];
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
        }
    }];
}

-(void)party:(NSString *) partyName :(NSString *)inviter :(NSString *)telephone :(NSString *)address :(NSArray *)images :(NSString *) tape :(NSString *) timestamp :(NSString *) closetime :(NSString *) description :(NSString *) background :(NSString *) unquieId :(NSString *)musicUrl{
    
    [SVProgressHUD dismiss];
    [HttpManage party:[UDObject gettoken] partyName:partyName inviter:inviter telephone:(NSString *)telephone address:address images:images tape:musicUrl timestamp:timestamp closetime:closetime description:description background:background mid:unquieId cb:^(BOOL isOK, NSDictionary *array) {
        if (isOK) {
            NSArray *arr = [[NSArray alloc] initWithArray:addimg];
            NSString *hlarr = [arr componentsJoinedByString:@","];
            
            if (musicUrl.length > 0) {
                audioname = [NSString stringWithFormat:@"../Audio/%@",audioname];
            }
            [UDObject setWLContent:partyName wltime:timestamp wlbmendtime:closetime wladdress_name:address wllxr_name:inviter wllxfs_name:telephone wlts_name:description wlaudio:audioname wlimgarr:hlarr];
            
            [[StatusBar sharedStatusBar] talkMsg:@"已生成" inTime:0.5];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
        }
    }];
}


@end
