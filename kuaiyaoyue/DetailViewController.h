//
//  DetailViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DVCDelegate;

@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headview;

@property (weak, nonatomic) NSString *uniqueId;
@property long long starttime;
@property long long endtime;
@property long long datatime;

@property (weak, nonatomic) NSString *maxnum;
@property (weak, nonatomic) IBOutlet UIView *endtime_view;
- (IBAction)endtime_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *cancel_view;
- (IBAction)cancel_onclick:(id)sender;


@property (nonatomic, weak) id<DVCDelegate> delegate;

@end
@protocol DVCDelegate <NSObject>

- (void)DVCDelegate:(DetailViewController *)cell didTapAtIndex:(NSString *) nefid;

@end