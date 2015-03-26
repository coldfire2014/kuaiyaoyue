//
//  MusicViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MusicTableViewController.h"
@protocol MVCDelegate;

@interface MusicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MusicTableDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, weak) id<MVCDelegate> delegate;
@property (nonatomic, strong) NSString *typeid;
@end
@protocol MVCDelegate <NSObject>

- (void)MVCDelegate:(MusicViewController *)cell didTapAtIndex:(NSString *) url :(NSString *)name;

@end