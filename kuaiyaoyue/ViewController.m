//
//  ViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/3.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "CreateBtn.h"
#import "StateView.h"
#import "BigStateView.h"
#import "MenuViewController.h"
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
    
    CreateBtn* btnView = [[CreateBtn alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
    btnView.tag = 99;
    btnView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-btnView.frame.size.height/2.0 - 12.0);
    [self.view addSubview:btnView];
    
    UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPan)];
    [btnView addGestureRecognizer:pan];//160*220
    StateView* s = [[StateView alloc] initWithFrame:CGRectMake(264, 110+55, 55, 55)];
    s.tag = 101;
    [s setState:StateGoing withAll:@"19" andAdd:@"+9"];
    [s setStartTime:[NSDate dateWithTimeIntervalSinceNow:-10] EndTime:[NSDate dateWithTimeIntervalSinceNow:5] andGoneTime:[NSDate dateWithTimeIntervalSinceNow:8]];
    [self.view addSubview:s];
    
    BigStateView* b = [[BigStateView alloc] initWithFrame:CGRectMake(0, 200, 320.0/2.0, 220.0/2.0)];
    b.tag = 102;
    b.center = CGPointMake(self.view.bounds.size.width/2.0, 200);
    [b setState:StateGoing withAll:@"999" andAdd:@"+99"];
    [b setStartTime:[NSDate dateWithTimeIntervalSinceNow:-10] EndTime:[NSDate dateWithTimeIntervalSinceNow:5] andGoneTime:[NSDate dateWithTimeIntervalSinceNow:8]];
    [self.view addSubview:b];


    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeTimeAtTimedisplay) userInfo:nil repeats:YES];
    [timer fire];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)changeTimeAtTimedisplay{
    static double t = 5;
    BigStateView* s = (BigStateView*)[self.view viewWithTag:102];
    t = t - 0.2;
    [s setStartTime:[NSDate dateWithTimeIntervalSinceNow:-10] EndTime:[NSDate dateWithTimeIntervalSinceNow:t] andGoneTime:[NSDate dateWithTimeIntervalSinceNow:3+t]];
}
- (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)didPan{
    UIView* view = [self.view viewWithTag:99];
    view.alpha = 0;
    UIImage *snapshotImage = [self imageFromView:self.view];
    view.alpha = 1;
//    [self performSegueWithIdentifier:@"CreateIncoming" sender:snapshotImage];
    [self performSegueWithIdentifier:@"menu" sender:snapshotImage];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"Imgcoming"] == NSOrderedSame ) {
//        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
//        des.maxCount = 2;
//        des.needAnimation = YES;
//        des.delegate = self;
    } else {
        MenuViewController* des = (MenuViewController*)segue.destinationViewController;
        des.bgimg = (UIImage*)sender;
    }
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
            [self performSegueWithIdentifier:@"del" sender:nil];
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
@end
