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

@interface DetailViewController ()<DVCCellDelegate>{
    BOOL isopen;
    NSInteger selectRow;
    NSMutableArray* data;
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
    data = [[NSMutableArray alloc] init];
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"哈哈哈",@"name",
                         @"12",@"count",
                         @"18650140605",@"phone",
                         @"哈哈哈",@"talk",nil];
    [data addObject:dic];
    selectRow = -1;
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0 ,0, 0);
    
    [self layoutheadview];
    [self setupRefresh];
    [self renewal];
}

-(void)renewal{
    [HttpManage renewal:_uniqueId timestamp:@"-1" cb:^(BOOL isOK, NSMutableArray *array) {
        if (isOK) {
            NSLog(@"%@",array);
        }else{
            
        }
    }];
}

-(void)layoutheadview{
    BigStateView* s = [[BigStateView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 44.5,65 + 5, 99, 99)];
    [s setState:StateGoing withAll:@"19" andAdd:@""];
    [s setStartTime:[NSDate dateWithTimeIntervalSinceNow:-10] EndTime:[NSDate dateWithTimeIntervalSinceNow:5] andGoneTime:[NSDate dateWithTimeIntervalSinceNow:8]];
    
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
        [data removeAllObjects];
        for (int i = 0; i< 20; i++) {
            NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"哈哈哈",@"name",
                                 @"12",@"count",
                                 @"18650140605",@"phone",
                                 @"哈哈哈",@"talk",nil];
            [data addObject:dic];
        }
        [_tableView reloadData];
        
        [_tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        for (int i = 0; i< 4; i++) {
            NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"哈哈哈",@"name",
                                 @"12",@"count",
                                 @"18650140605",@"phone",
                                 @"哈哈哈",@"talk",nil];
            [data addObject:dic];
        }
        [_tableView reloadData];
        
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
    
        NSDictionary* dic = [data objectAtIndex:indexPath.row];
        cell.show_num.text = [dic objectForKey:@"count"];
        cell.show_name.text = [dic objectForKey:@"name"];
        cell.show_content.text = [dic objectForKey:@"talk"];
        cell.phone = [dic objectForKey:@"phone"];
        cell.talk = [dic objectForKey:@"talk"];
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

-(void)didSelectItemAtIndex:(NSIndexPath*)indexPath{
    NSInteger oldselect = selectRow;
    if (indexPath.row == selectRow) {
        selectRow = -1;
    }else{
        if (selectRow != -1) {
            selectRow = indexPath.row;
            NSIndexPath* old = [NSIndexPath indexPathForRow:oldselect inSection:1];
            [self.tableView reloadRowsAtIndexPaths:@[old] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        selectRow = indexPath.row;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)didShowPhone:(NSString*) phone{
    NSLog(@"%@",phone);
}


@end
