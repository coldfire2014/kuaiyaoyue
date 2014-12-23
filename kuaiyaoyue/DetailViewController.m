//
//  DetailViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "DetailViewController.h"

#import "DVCCell.h"
#import "myImageView.h"
#import "MJRefresh.h"
#import "BigStateView.h"
#import "HttpManage.h"
#import "DataBaseManage.h"
#import "Contacts.h"
#import "StatusBar.h"

@interface DetailViewController ()<DVCCellDelegate>{
    BOOL isopen;
    NSInteger selectRow;
    NSArray *data;
    BigStateView* s;
    NSString *timebh;
    NSString *dateAndTime;
    UIWebView *phoneCallWebView;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"快邀约";
    [label sizeToFit];
    label.textColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1.0];
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    
    self.navigationController.navigationBar.alpha = 0.8;
    selectRow = -1;
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0 ,0, 0);
    
    [self layoutheadview];
    [self setupRefresh];
    [self renewal];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    _endtime_view.layer.cornerRadius = 21;
    _cancel_view.layer.cornerRadius = 21;
    
    [_picker addTarget:self action:@selector(DatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_picker setMinimumDate:[NSDate date]];
    NSDate *enddate=[NSDate dateWithTimeIntervalSince1970:_endtime];
    [_picker setMaximumDate:enddate];
    
    [_bottom_view setFrame:CGRectMake(0, 1000, _bottom_view.frame.size.width, _bottom_view.frame.size.height)];
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
    [_tableView reloadData];
}

-(void)layoutheadview{
    s = [[BigStateView alloc] initWithFrame:CGRectMake(0,0, 99, 99)];
    [s setState:StateGoing withAll:_maxnum andAdd:@""];
    s.center = CGPointMake(self.view.bounds.size.width/2.0, _headview.bounds.size.height-58.0);
    // s:发送时间 。e:报名截止 g:活动时间
    [s setStartTime:[NSDate dateWithTimeIntervalSince1970:_starttime] EndTime:[NSDate dateWithTimeIntervalSince1970:_endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:_datatime]];
    
    [_headview addSubview:s];
}

- (void)viewWillAppear:(BOOL)animated
{
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
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
//        [data removeAllObjects];
//        for (int i = 0; i< 20; i++) {
//            NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                 @"哈哈哈",@"name",
//                                 @"12",@"count",
//                                 @"18650140605",@"phone",
//                                 @"哈哈哈",@"talk",nil];
//            [data addObject:dic];
//        }
        [_tableView reloadData];
        
        [_tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
//        for (int i = 0; i< 4; i++) {
//            NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                 @"哈哈哈",@"name",
//                                 @"12",@"count",
//                                 @"18650140605",@"phone",
//                                 @"哈哈哈",@"talk",nil];
//            [data addObject:dic];
//        }
//        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
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
        cell.show_num.text = [NSString stringWithFormat:@"%d",contacts.number];
        cell.show_name.text = contacts.name;
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
            [cell.show_message setHidden:YES];
        } else {
            [cell.show_message setHidden:NO];
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

-(void)makeACall :(NSString *) phoneNum{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    if ( !phoneCallWebView ) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的View 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (IBAction)endtime_onclick:(id)sender {
    [_bottom_view setHidden:NO];
    [UIView animateWithDuration:0.4f animations:^{
        [self.bottom_view setFrame:CGRectMake(self.bottom_view.frame.origin.x,0, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height)];
    }];
}

- (IBAction)cancel_onclick:(id)sender {
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

- (IBAction)sure_picker:(id)sender{
    [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeBlack];
    [HttpManage dueDate:_uniqueId timestamp:timebh cb:^(BOOL isOK, NSDictionary *array) {
        [SVProgressHUD dismiss];
        if (isOK) {
            _endtime = [timebh longLongValue]/1000;
            [s setStartTime:[NSDate dateWithTimeIntervalSince1970:_starttime] EndTime:[NSDate dateWithTimeIntervalSince1970:_endtime] andGoneTime:[NSDate dateWithTimeIntervalSince1970:_datatime]];
            NSDate *enddate=[NSDate dateWithTimeIntervalSince1970:_endtime];
            [_picker setMaximumDate:enddate];
            [[StatusBar sharedStatusBar] talkMsg:@"修改成功" inTime:0.51];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"修改失败" inTime:0.51];
        }
    }];
}

- (IBAction)qx_picker:(id)sender{
    [UIView animateWithDuration:0.4f animations:^{
        [self.bottom_view setFrame:CGRectMake(self.bottom_view.frame.origin.x,self.view.frame.size.height, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height)];
    }];
}

- (void)DatePickerValueChanged:(UIDatePicker *) sender {
    NSDate *select = [sender date]; // 获取被选中的时间
    timebh = [NSString stringWithFormat:@"%lld", ((long long)[select timeIntervalSince1970] *1000)];
}

@end
