

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
#import "SVProgressHUD.h"

@interface MusicViewController ()<AVAudioPlayerDelegate>{
    NSMutableArray *data;
    long num;
    AVAudioPlayer *player;
    MusicTableViewCell *bfcell;
    NSManagedObjectContext *context;
    long tjnum;
    long addnum;
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
    
    [self inData];
}

- (void)leftBarBtnClicked:(id)sender
{
    

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
    }else{
        timestamp = @"-1";
    }
    [HttpManage getAll:timestamp cb:^(BOOL isOK, NSMutableArray *array) {
         if (isOK) {
             NSLog(@"%@",array);
             tjnum = [array count];
             if (tjnum > 0) {
                 [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
                 for (int i = 0; i < [array count]; i++) {
                     NSDictionary *dic = [array objectAtIndex:i];
                     [[DataBaseManage getDataBaseManage] setMusic:dic];
                     [self downYP:[dic objectForKey:@"name"] :[dic objectForKey:@"url"]];
                 }
             }else{
                 [SVProgressHUD dismiss];
                 [self showdid];
             }
             
         }else{
             [self showdid];
         }
     }];
}

-(void)downYP:(NSString *) name :(NSString *)url{
    BOOL is_bd = [[FileManage sharedFileManage] ISYPFile:name];
    NSString *file  = [[FileManage sharedFileManage] GetYPFile:name];
    if (!is_bd) {
        [HttpManage DownMusic:url filepath:file cb:^(BOOL isOK) {
            addnum++;
            if (addnum == tjnum) {
                [SVProgressHUD dismiss];
                [self showdid];
            }
        }];
    }
}

-(void)showdid {
    NSArray *arr = [[DataBaseManage getDataBaseManage] getMusic];
    for (Music *music in arr) {
        MusicInfo *info = [[MusicInfo alloc] SetMusicValue:NO :music.nefname :music.nefurl];
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
        cell.show_status.text = @"关";
    }else{
        cell.show_status.text = @"开";
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
    
    NSString *file  = [[FileManage sharedFileManage] GetYPFile:info.title];
    [self AudioPlay:file];
}


-(void)AudioPlay:(NSString *)recordedFile{
    NSError *playerError;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath: recordedFile] error:&playerError];
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
