

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
    
    num = -1;
    addnum = 0;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarBtnClicked:)];
    self.navigationItem.rightBarButtonItem = right;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    _tableView.separatorStyle = NO;
    [self inData];
}

- (void)leftBarBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(MVCDelegate:didTapAtIndex::)]){
        [self.delegate MVCDelegate:self didTapAtIndex:URL:name];}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)inData{
    
    data = [[NSMutableArray alloc] init];
    NSString *timestamp = nil;
    NSArray *arr = [[DataBaseManage getDataBaseManage] getMusic];
    if ([arr count] > 0) {
        Music *music = [arr objectAtIndex:[arr count] -1];
        timestamp = music.timestamp;
        NSLog(@"music-%@",music);
    }else{
        timestamp = @"-1";
    }
    [[waitingView sharedwaitingView] waitByMsg:@"音乐列表努力加载中……" haveCancel:NO];
    [HttpManage getAll:timestamp cb:^(BOOL isOK, NSMutableArray *array) {
        if (isOK) {
             NSLog(@"%@",array);
             tjnum = [array count];
             if (tjnum > 0) {
                 [[waitingView sharedwaitingView] changeWord:@"真在为您下载新的音乐……"];
                 for (int i = 0; i < [array count]; i++) {
                     NSDictionary *dic = [array objectAtIndex:i];
                     [[DataBaseManage getDataBaseManage] setMusic:dic];
                     [self downYP:[dic objectForKey:@"uniqueId"] :[dic objectForKey:@"url"]];
                 }
             }else{
                 [[waitingView sharedwaitingView] stopWait];
                 [self showdid];
             }
             
         }else{
             [[waitingView sharedwaitingView] stopWait];
             [self showdid];
         }
     }];
}

-(void)downYP:(NSString *)ypname :(NSString *)url{
    BOOL is_bd = [[FileManage sharedFileManage] ISYPFile:ypname];
    NSString *file  = [[FileManage sharedFileManage] GetYPFile:ypname];
    if (!is_bd) {
        [HttpManage DownMusic:url filepath:file cb:^(BOOL isOK) {
            addnum++;
            if (addnum == tjnum) {
                [[waitingView sharedwaitingView] stopWait];
                [self showdid];
            }
        }];
    }else{
         addnum++;
        if (addnum == tjnum) {
            [[waitingView sharedwaitingView] stopWait];
            [self showdid];
        }
    }
}

-(void)showdid {
    NSArray *arr = [[DataBaseManage getDataBaseManage] getMusic:_typeid];
    for (Music *music in arr) {
        MusicInfo *info = [[MusicInfo alloc] SetMusicValue:NO :music.nefname :music.nefurl :music.uniqueId];
        [data addObject:info];
    }
    [_tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"music";
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
    [self AudioPlay:file];
}
-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
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
