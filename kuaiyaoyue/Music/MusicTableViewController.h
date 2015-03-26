//
//  MusicTableViewController.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/3/26.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "MusicTableViewCell.h"
#import <UIKit/UIKit.h>
@protocol MusicTableDelegate <NSObject>

- (void)didSelectWithFile:(NSString *) url andName:(NSString *)name;

@end
@interface MusicTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AVAudioPlayerDelegate>{
    NSMutableArray *data;
    long num;
    AVAudioPlayer *player;
    MusicTableViewCell *bfcell;
    NSManagedObjectContext *context;
    long tjnum;
    long addnum;
    NSURL *URL;
    NSString *name;
}
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, weak) id<MusicTableDelegate> delegate;

@end
