//
//  DetailViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "DetailViewController.h"
#import "TalkingData.h"
#import "DVCCell.h"
#import "myImageView.h"
#import "MJRefresh.h"
#import "BigStateView.h"
#import "HttpManage.h"
#import "DataBaseManage.h"
#import "Contacts.h"
#import "DatetimeInput.h"
#import "waitingView.h"
#import "UIPhoneWindow.h"
#import "PCHeader.h"
@interface DetailViewController ()<DVCCellDelegate,datetimeInputDelegate>{
    BOOL isopen;
    NSInteger selectRow;
    NSArray *data;
    BigStateView* s;
    NSString *dateAndTime;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage* img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"big" ofType:@"png"]];
    _showview_img.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
   
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = self.title;
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    
    self.navigationController.navigationBar.alpha = 0.8;
    selectRow = -1;
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0 ,0, 0);
    
    [self layoutheadview];
    [self setupRefresh];
    [self renewal];
    
    [self.navigationController.navigationBar setTintColor:color];
    
    _endtime_view.layer.cornerRadius = 21;
    _cancel_view.layer.cornerRadius = 21;
    
    _tableView.separatorStyle = NO;
}

-(void)changeHight{
    
}

-(void)renewal{
    NSArray *arr = [[DataBaseManage getDataBaseManage] GetContacts:_uniqueId];
    NSString *time = nil;
    if ([arr count] > 0) {
        Contacts *contacts = [arr objectAtIndex:0];
        time = contacts.timestamp;
    }else{
        time = @"-1";
    }
    
    [HttpManage renewal:_uniqueId timestamp:time size:@"-1" cb:^(BOOL isOK, NSMutableArray *array) {
        NSLog(@"%@",array);
        if (isOK) {
            for (NSDictionary *dic in array) {
                [[DataBaseManage getDataBaseManage] AddContacts:dic :_uniqueId];
            }
            [self initData];
        }else{
            [self initData];
        }
    }];
}

-(void)bottomrenewal{
    
}

-(void)initData{
    data = [[DataBaseManage getDataBaseManage] GetContacts:_uniqueId];
    if (data.count > 0) {
        [_bg_view setHidden:YES];
    }else{
        [_bg_view setHidden:NO];
    }
    [_tableView reloadData];
    int16_t count = 0;
    for (Contacts *contacts in data) {
        count += contacts.number;
    }
    _maxnum = [[NSString alloc] initWithFormat:@"%d",count];
    [s setState:StateGoing withAll:_maxnum andAdd:@""];
    [s setStartTime:[NSDate dateWithTimeIntervalSince1970:_starttime] EndTime:[NSDate dateWithTimeIntervalSince1970:_endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:_datatime]];
    [_tableView headerEndRefreshing];
}

-(void)layoutheadview{
    s = [[BigStateView alloc] initWithFrame:CGRectMake(0,0, 99, 99)];
    [s setState:StateGoing withAll:_maxnum andAdd:@""];
    s.center = CGPointMake(self.view.bounds.size.width/2.0, _headview.bounds.size.height-58.0);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        CGRect f = IPAD_FRAME;
        s.center = CGPointMake(f.size.width/2.0, _headview.bounds.size.height-58.0);
    }
    // s:发送时间 。e:报名截止 g:活动时间
    [s setStartTime:[NSDate dateWithTimeIntervalSince1970:_starttime] EndTime:[NSDate dateWithTimeIntervalSince1970:_endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:_datatime]];
    
    [_headview addSubview:s];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [_tableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self renewal];
}

- (void)footerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView footerEndRefreshing];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
        return data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == selectRow) {
            return 143;
        } else {
            return 55;
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *identifier = @"DVCCell";
        DVCCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
        Contacts *contacts = [data objectAtIndex:[indexPath row]];
        cell.show_num.text = @"";//[NSString stringWithFormat:@"%d人",contacts.number];
        cell.show_name.text = [NSString stringWithFormat:@"%@报名,到场%d人",contacts.name,contacts.number];
        cell.show_content.text = contacts.message;
        cell.phone = contacts.mobile;
        cell.talk = contacts.message;
        cell.index = indexPath;
        cell.delegate = self;
    
        if ([cell.phone compare:@""] == NSOrderedSame) {
            [cell.show_phone setEnabled:NO];
        } else {
            [cell.show_phone setEnabled:YES];
        }
        if ([cell.talk compare:@""] == NSOrderedSame) {
            [cell.show_message setEnabled:NO];
        } else {
            [cell.show_message setEnabled:YES];
            
            if (indexPath.row == selectRow) {
                [UIView animateWithDuration:0.3 animations:^{
                    cell.show_message.layer.transform = CATransform3DMakeRotation( -M_PI_2,0,0,1);
                }];
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    cell.show_message.layer.transform = CATransform3DIdentity;
                }];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3  && !isopen) {
        isopen = true;
        [tableView reloadData];
    }else if (indexPath.row == data.count  && isopen) {
        isopen = false;
        [tableView reloadData];
    }else{
        
    }
}

-(void)didSelectItemAtIndex:(NSIndexPath*)indexPath :(DVCCell *)cell{
    NSInteger oldselect = selectRow;
    if (indexPath.row == selectRow) {
        selectRow = -1;
    }else{
        if (selectRow != -1) {
            selectRow = indexPath.row;
            NSIndexPath* old = [NSIndexPath indexPathForRow:oldselect inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[old] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        selectRow = indexPath.row;
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)didShowPhone:(NSString*) phone{
    NSLog(@"%@",phone);
    [self makeACall:phone];
}
- (UIImage *)imageFromView:(UIView *)view
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    CALayer *layer = [delegate.window layer];
        
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
-(void)makeACall :(NSString *) phoneNum{
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        UIImage *snapshotImage = [self imageFromView:self.view];
        [[UIPhoneWindow sharedwaitingView] callPhone:phoneNum andBK:snapshotImage];
    }
}

- (IBAction)endtime_onclick:(id)sender {
    [TalkingData trackEvent:@"修改截至时间"];
    [[DatetimeInput sharedDatetimeInput] setTime:[NSDate dateWithTimeIntervalSince1970:_endtime] andMaxTime:[NSDate dateWithTimeIntervalSince1970:_datatime] andMinTime:[NSDate date]];
    [DatetimeInput sharedDatetimeInput].time_delegate = self;
    [[DatetimeInput sharedDatetimeInput] show];
}

- (IBAction)cancel_onclick:(id)sender {
    [TalkingData trackEvent:@"删除邀约"];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"取消后，链接会失效哦！\n列表中也会自动删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    alert.alertViewStyle=UIAlertViewStyleDefault;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.delegate && [self.delegate respondsToSelector:@selector(DVCDelegate:didTapAtIndex:)]){
            [self.delegate DVCDelegate:self didTapAtIndex:_uniqueId];}
    }
    
}
- (BOOL)didSelectDateTime:(NSTimeInterval)time{
    [[waitingView sharedwaitingView] startWait];
    NSArray* time_s = [[[NSString alloc] initWithFormat:@"%f",time*1000.0] componentsSeparatedByString:@"."];
    [HttpManage dueDate:_uniqueId timestamp:[time_s objectAtIndex:0] cb:^(BOOL isOK, NSDictionary *array) {
        [[waitingView sharedwaitingView] stopWait];
        if (isOK) {
            _endtime = time;
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:_starttime] EndTime:[NSDate dateWithTimeIntervalSince1970:_endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:_datatime]];
//            [[StatusBar sharedStatusBar] talkMsg:@"修改成功" inTime:1.01];
//            [[waitingView sharedwaitingView] WarningByMsg:@"修改成功" haveCancel:NO];
//            [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:WAITING_TIME];
        }else{
//            [[StatusBar sharedStatusBar] talkMsg:@"修改失败" inTime:1.51];
            [[waitingView sharedwaitingView] WarningByMsg:@"修改失败" haveCancel:NO];
            [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
        }
    }];
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TalkingData trackPageBegin:@"报名列表"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [TalkingData trackPageEnd:@"报名列表"];
}

- (IBAction)bg_onclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [_delegate ShareDelegate:_index];
}
@end
