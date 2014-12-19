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

#import "TimeTool.h"

#import "HttpManage.h"
#import "UDObject.h"
#import "DataBaseManage.h"
#import "Userdata.h"
#import "DetailViewController.h"


@interface ViewController (){
    NSArray *data;
    NSString *uniqueId;
    int run;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
     data = [[NSArray alloc] init];
    [self setupRefresh];
    
    CreateBtn* btnView = [[CreateBtn alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
    btnView.tag = 99;
    btnView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-btnView.frame.size.height/2.0 - 12.0);
    [self.view addSubview:btnView];
    
    UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPan)];
    [btnView addGestureRecognizer:pan];//160*220
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeTimeAtTimedisplay) userInfo:nil repeats:YES];
    [timer fire];
    
    [self headview];
    
    //滑动监听
//    _tableview.contentInset = UIEdgeInsetsMake(-20, 0 ,0, 0);
//   [_tableview setContentOffset:CGPointMake(0, -196) animated:YES];
    
    NSDate * date = [NSDate date];
    //1418630019
    NSLog(@"%ld",(long)[date timeIntervalSince1970]);
    
    [TimeTool TopJZTime:1418630019];
    
//    if ([UDObject gettoken].length > 0) {
//        [self j_spring_security_check:@"123456789" password:@"123456789"];
//        NSLog(@"登录");
//    }else{
//        NSLog(@"已登录");
//    }
    [self GetRecord];
}

//-(void)j_spring_security_check:(NSString *)username password:(NSString *)password{
//    [HttpManage j_spring_security_check:username password:password phoneId:[UDObject getTSID] j_username:username j_password:password isJson:@"true" cb:^(BOOL isOK, NSDictionary *dic) {
//        if (isOK) {
//            NSString *token = [dic objectForKey:@"token"];
//            [UDObject setUserInfo:username userName:@"" token:token];
//        }else{
//            
//        }
//    }];
//}

-(void)GetHTTPRecord{
    [HttpManage multiHistory:[UDObject gettoken] timestamp:@"-1" cb:^(BOOL isOK, NSDictionary *array) {
        NSLog(@"%@",array);
        if (isOK) {
            NSArray *customList = [array objectForKey:@"customList"];
            for (NSDictionary *dic in customList) {
                [[DataBaseManage getDataBaseManage] AddUserdata:dic type:0];
            }
            NSArray *marryList = [array objectForKey:@"marryList"];
            for (NSDictionary *dic in marryList) {
                [[DataBaseManage getDataBaseManage] AddUserdata:dic type:1];
            }
            NSArray *partyList = [array objectForKey:@"partyList"];
            for (NSDictionary *dic in partyList) {
                [[DataBaseManage getDataBaseManage] AddUserdata:dic type:2];
            }
            [self GetRecord];
        }
    }];
}

-(void)GetRecord{
    data = [[DataBaseManage getDataBaseManage] getUserdata];
    run = 0;
    if ([data count] > 0) {
        [self showToptitle];
        [_tableview reloadData];
    }else{
        [self GetHTTPRecord];
    }
}

//0自定义，1婚礼，2趴体
-(void)showToptitle{
    NSDate *datenow = [NSDate date];
    long newdata = (long)[datenow timeIntervalSince1970];
    int runtime = 0;
    for (int i = 0; i < [data count]; i++) {
        Userdata *info = [data objectAtIndex:i];
        long closetime;
        switch (info.neftype) {
            case 0:
                closetime = (long)([info.nefclosetimestamp longLongValue] /1000);
                break;
            case 1:
                closetime = (long)([info.neftimestamp longLongValue] /1000);
                break;
            case 2:
                closetime = (long)([info.nefclosetimestamp longLongValue] /1000);
                break;
                
            default:
                break;
        }
        if (newdata < closetime) {
            runtime++;
        }
    }
    
    NSString *toptitle = [NSString stringWithFormat:@"共%d个邀约,%d个正在进行....",[data count],runtime];
    _show_toptitle.text = toptitle;

}


-(void)headview{
    
    _show_img.layer.masksToBounds = YES;
    _show_img.layer.cornerRadius = 34;
    _showview_img.layer.cornerRadius = 36;
    
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
    [self performSegueWithIdentifier:@"menu" sender:snapshotImage];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"menu"] == NSOrderedSame ) {
        MenuViewController* des = (MenuViewController*)segue.destinationViewController;
        des.bgimg = (UIImage*)sender;
    }else if ([segue.identifier compare:@"detail"] == NSOrderedSame){
        DetailViewController *view = (DetailViewController*)segue.destinationViewController;
        view.uniqueId = uniqueId;
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
        
        [self GetRecord];
        [_tableview headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
//        for (int i = 0; i< 4; i++) {
//            NSDictionary *dic = [[NSDictionary alloc] init];
//            [data addObject:dic];
//        }
//        [_tableview reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableview footerEndRefreshing];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ViewCell";
    ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.widht = self.view.frame.size.width;
    cell.info = [data objectAtIndex:[indexPath row]];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Userdata *info = [data objectAtIndex:[indexPath row]];
    uniqueId = info.nefid;
    [self performSegueWithIdentifier:@"detail" sender:nil];
}

//写滑动监听

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    float destinaOffset = -96;
//    float startChangeOffset = -scrollView.contentInset.top;
//    
//    CGPoint newOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y<startChangeOffset?startChangeOffset:(scrollView.contentOffset.y>destinaOffset?destinaOffset:scrollView.contentOffset.y));
//    float newY = -newOffset.y-scrollView.contentInset.top;
//
//    [_head_view setFrame:CGRectMake(0, newY, _showview_img.frame.size.width, _showview_img.frame.size.height)];
//    
//    float d = destinaOffset-startChangeOffset;
//    float alpha = 1-(newOffset.y-startChangeOffset)/d;
//    NSLog(@"%f",(newOffset.y-startChangeOffset)/d);
//    NSLog(@"%f",1 - (0.5-(0.5)*(alpha)));
//    
//    [_showview_img setFrame:CGRectMake( 17-(17)*(1-alpha) + 9,80-(80)*(alpha) + 36, _showview_img.frame.size.width, _showview_img.frame.size.height)];
//    
//    [_showsetting setFrame:CGRectMake(_showsetting.frame.origin.x, 92-(92)*(alpha) + 28
//                                      , _showsetting.frame.size.width, _showsetting.frame.size.height)];
//    _show_title.alpha = 1 - alpha;
//    
//    _showtm.backgroundColor = [[UIColor alloc] initWithRed:(69.0/255.0) green:(76.0/255.0) blue:(78.0/255.0) alpha:1 - (0.5-(0.5)*(alpha))];
//}


@end
