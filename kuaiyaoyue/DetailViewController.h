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

@property (strong, nonatomic) NSString *uniqueId;
@property NSTimeInterval starttime;
@property NSTimeInterval endtime;
@property NSTimeInterval datatime;

@property (weak, nonatomic) IBOutlet UIImageView *showview_img;
@property (strong, nonatomic) NSString *maxnum;
@property (weak, nonatomic) IBOutlet UIView *endtime_view;
- (IBAction)endtime_onclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *cancel_view;
- (IBAction)cancel_onclick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bg_view;
- (IBAction)bg_onclick:(id)sender;

@property NSInteger index;

@property (nonatomic, weak) id<DVCDelegate> delegate;

@end
@protocol DVCDelegate <NSObject>

- (void)DVCDelegate:(DetailViewController *)cell didTapAtIndex:(NSString *) nefid;
- (void)ShareDelegate:(NSInteger) index;

@end