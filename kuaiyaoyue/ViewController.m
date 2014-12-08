//
//  ViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController (){
    NSMutableArray *data;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"主页";
    
     data = [[NSMutableArray alloc] init];
    [self inData];
    [self setupRefresh];
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
    [_tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [_tableview headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableview addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [data removeAllObjects];
        for (int i = 0; i< 4; i++) {
            NSDictionary *dic = [[NSDictionary alloc] init];
            [data addObject:dic];
        }
        [_tableview reloadData];
        
        [_tableview headerEndRefreshing];
    });
}

- (void)footerRereshing
{

    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        for (int i = 0; i< 4; i++) {
            NSDictionary *dic = [[NSDictionary alloc] init];
            [data addObject:dic];
        }
        [_tableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableview footerEndRefreshing];
    });
}

-(void)inData{
   
    for (int i = 0; i< 4; i++) {
        NSDictionary *dic = [[NSDictionary alloc] init];
        [data addObject:dic];
    }
[_tableview reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ViewCell";
    ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0:
            [self performSegueWithIdentifier:@"zdyedit" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"hledit" sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:@"swedit" sender:nil];
            break;
        case 3:
            [self performSegueWithIdentifier:@"chedit" sender:nil];
            break;
            
        default:
            break;
    }
}

- (IBAction)menu_onclick:(id)sender {
    
    [self performSegueWithIdentifier:@"menu" sender:nil];
}
@end
