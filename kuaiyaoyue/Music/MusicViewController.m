

//
//  MusicViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MusicViewController.h"
#import "MusicTableViewCell.h"
#import "MusicInfo.h"
#import "FileManage.h"
#import "HttpManage.h"
#import "DataBaseManage.h"
#import "Music.h"
#import "waitingView.h"
#import "TalkingData.h"
#import "PCHeader.h"
@interface MusicViewController ()<AVAudioPlayerDelegate>{
    NSMutableArray *data;
    long num;
    AVAudioPlayer *player;
    MusicTableViewCell *bfcell;
    NSManagedObjectContext *context;
    long tjnum;
    long addnum;
    NSString *URL;
    NSString *name;
}

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat top = 20.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        top = 0.0;
        w = 540;
        h = 620;
    }
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 88.0/2.0 + top)];
    navView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
    [self.view addSubview:navView];
    
    UIView* btnLeft = [[UIView alloc] initWithFrame:CGRectMake(8.0, top, 44.0, 44.0)];
    btnLeft.tag = 102;
    [navView addSubview:btnLeft];
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [btnLeft addGestureRecognizer:tap1 ];
    UILabel* lbl_back = [[UILabel alloc] initWithFrame:btnLeft.bounds];
    lbl_back.font = [UIFont systemFontOfSize:18];
    lbl_back.text = @"返回";
    lbl_back.textAlignment = NSTextAlignmentCenter;
    lbl_back.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    [btnLeft addSubview:lbl_back];
    
    UIView* btnRight = [[UIView alloc] initWithFrame:CGRectMake(w-44.0-8.0, top, 44.0, 44.0)];
    btnRight.tag = 103;
    [navView addSubview:btnRight];
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftBarBtnClicked)];
    [btnRight addGestureRecognizer:tap2 ];
    UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnLeft.bounds];
    lbl_OK.font = [UIFont systemFontOfSize:18];
    lbl_OK.text = @"确定";
    lbl_OK.textAlignment = NSTextAlignmentCenter;
    lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    [btnRight addSubview:lbl_OK];

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, navView.frame.size.height-0.5, navView.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    [navView addSubview:line];
    
    UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(100.0, top, navView.frame.size.width - 200.0, 44.0)];
    lbl.tag = 105;
    lbl.font = [UIFont systemFontOfSize:20];
    lbl.text = @"选择背景音乐";
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
    [navView addSubview:lbl];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+top, w, h-44-top)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tag = 110;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    num = -1;
    addnum = 0;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    _tableView.separatorStyle = NO;
//    [self inData];
    [self showdid];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)leftBarBtnClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MVCDelegate:didTapAtIndex::)]){
        [self.delegate MVCDelegate:self didTapAtIndex:URL:name];
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showdid {
    data = [[NSMutableArray alloc] init];
    NSArray *arr = [[DataBaseManage getDataBaseManage] getMusic:_typeid];
    for (Music *music in arr) {
        MusicInfo *info = [[MusicInfo alloc] SetMusicValue:NO :music.nefname :music.nefurl :music.uniqueId];
        [data addObject:info];
    }
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"music";
    
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    MusicInfo *info = [data objectAtIndex:[indexPath row]];
    cell.index = [indexPath row];
    if (!info.state) {
        [cell.show_status setHidden:YES];
    }else{
        [cell.show_status setHidden:NO];
        URL = info.url;
        name = info.title;
    }
    cell.show_content.text = info.title;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (num != -1) {
        MusicInfo *info = [data objectAtIndex:num];
        info.state = NO;
        [data replaceObjectAtIndex:num withObject:info];
    }
    
     MusicInfo *info = [data objectAtIndex:[indexPath row]];
     info.state = YES;
    [data replaceObjectAtIndex:[indexPath row] withObject:info];
    num = [indexPath row];
    [_tableView reloadData];
    
    NSString *file  = [[FileManage sharedFileManage] GetYPFile:info.uniqueId];
    if(![[NSFileManager defaultManager] fileExistsAtPath:file]){
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"sdyy" ofType:@"bundle"]];
        NSString *path = [bundle.bundlePath stringByAppendingString:@"/musicFiles"];
        
        NSString* copyfile = [path stringByAppendingPathComponent:[[file componentsSeparatedByString:@"/"] lastObject]];
        if(![[NSFileManager defaultManager] fileExistsAtPath:copyfile]){
            return;
        }else{
            [[NSFileManager defaultManager] copyItemAtPath:copyfile toPath:file error:nil];
            [NSThread detachNewThreadSelector:@selector(AudioPlay:) toTarget:self withObject:copyfile];
        }
    }else{
        [NSThread detachNewThreadSelector:@selector(AudioPlay:) toTarget:self withObject:file];
    }
//    [self AudioPlay:file];
}
-(void)viewWillAppear:(BOOL)animated{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    [TalkingData trackPageBegin:@"音乐选择页"];
}
-(void)viewDidDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"音乐选择页"];
}
-(void)AudioPlay:(NSString *)recordedFile{
    NSError *playerError;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: recordedFile] error:&playerError];
    NSLog(@"%@",[NSURL fileURLWithPath: recordedFile]);
    [player prepareToPlay];
//    player.volume = 10.0f;
    player.delegate = self;
    player.numberOfLoops = 1;
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
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    //播放结束时执行的动作
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer*)player error:(NSError *)error{
    //解码错误执行的动作
}
- (void)audioPlayerBeginInteruption:(AVAudioPlayer*)player{
    //处理中断的代码
}
- (void)audioPlayerEndInteruption:(AVAudioPlayer*)player{
    //处理中断结束的代码
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
