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
#import "StatusBar.h"
#import "ShareView.h"
@interface ViewController ()<VCDelegate,DVCDelegate>{
    NSMutableArray *data;
    NSString *uniqueId;
    long long starttime;
    long long endtime;
    long long datatime;
    NSString *maxnum;
    
    int run;
    UITableViewCellEditingStyle selectEditingStyle;
    BOOL is_chose;
    
    NSString *url;
    NSString *msg;
    NSString *title;
    NSIndexPath *index_path;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
    [self setupRefresh];
    is_chose = YES;
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
    [self loaddata];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

}

-(void)GetRecord{
    [HttpManage multiHistory:[UDObject gettoken] timestamp:@"-1" cb:^(BOOL isOK, NSDictionary *array) {
        NSLog(@"%@",array);
        if (isOK) {
            NSArray *customList = [array objectForKey:@"customList"];
            for (NSDictionary *dic in customList) {
                BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                if (!is_bcz) {
                    [[DataBaseManage getDataBaseManage] AddUserdata:dic type:0];
                }
            }
            NSArray *marryList = [array objectForKey:@"marryList"];
            for (NSDictionary *dic in marryList) {
                BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                if (!is_bcz) {
                    [[DataBaseManage getDataBaseManage] AddUserdata:dic type:1];
                }
            }
            NSArray *partyList = [array objectForKey:@"partyList"];
            for (NSDictionary *dic in partyList) {
                BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                if (!is_bcz) {
                    [[DataBaseManage getDataBaseManage] AddUserdata:dic type:2];
                }
            }
            [self loaddata];
        }else{
            [self loaddata];
        }
    }];
}

-(void)getBottomRecord{
    if ([data count] > 29) {
        Userdata *user = [data objectAtIndex:[data count]];
        NSString* timestamp = user.nefdate;
        [HttpManage multiHistory:[UDObject gettoken] timestamp:timestamp cb:^(BOOL isOK, NSDictionary *array) {
            NSLog(@"%@",array);
            if (isOK) {
                NSArray *customList = [array objectForKey:@"customList"];
                for (NSDictionary *dic in customList) {
                    Userdata *userdata = [[Userdata alloc] init];
                    userdata.neftitle = [dic objectForKey:@"title"];
                    userdata.neflogo = [dic objectForKey:@"logo"];
                    userdata.nefmusic = [dic objectForKey:@"music"];
                    userdata.nefcontent = [dic objectForKey:@"content"];
                    userdata.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
                    userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
                    userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
                    userdata.nefurl = [dic objectForKey:@"url"];
                    userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
                    userdata.nefthumb = [NSString stringWithFormat:@"%@",[dic objectForKey:@"thumb"]];
                    userdata.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
                    userdata.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
                    userdata.neftype = 0;
                    [data addObject:userdata];
                    
                }
                NSArray *marryList = [array objectForKey:@"marryList"];
                for (NSDictionary *dic in marryList) {
                    Userdata *userdata = [[Userdata alloc] init];
                    userdata.nefid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unquieId"]];
                    userdata.nefbride = [dic objectForKey:@"bride"];
                    userdata.nefgroom = [dic objectForKey:@"groom"];
                    userdata.nefaddress = [dic objectForKey:@"address"];
                    userdata.neflocation = [dic objectForKey:@"location"];
                    NSArray *arr = [dic objectForKey:@"images"];
                    if (arr != nil) {
                        userdata.nefimages = [arr componentsJoinedByString:@","];
                    }else{
                        userdata.nefimages = @"";
                    }
                    userdata.neftimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
                    userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
                    userdata.nefurl = [dic objectForKey:@"url"];
                    userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
                    userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
                    userdata.nefbackground = [dic objectForKey:@"background"];
                    userdata.nefmusicurl = [dic objectForKey:@"musicUrl"];
                    userdata.nefthumb = [NSString stringWithFormat:@"%@",[dic objectForKey:@"thumb"]];
                    userdata.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
                    userdata.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
                    userdata.neftype = 1;
                    [data addObject:userdata];
                }
                NSArray *partyList = [array objectForKey:@"partyList"];
                for (NSDictionary *dic in partyList) {
                    Userdata *userdata = [[Userdata alloc] init];
                    userdata.nefid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"unquieId"]];
                    userdata.nefinviter = [dic objectForKey:@"inviter"];
                    userdata.nefaddress = [dic objectForKey:@"address"];
                    NSArray *arr = [dic objectForKey:@"images"];
                    if (arr != nil) {
                        userdata.nefimages = [arr componentsJoinedByString:@","];
                    }else{
                        userdata.nefimages = @"";
                    }
                    userdata.neftape = [dic objectForKey:@"tape"];
                    userdata.neftimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
                    userdata.nefclosetimestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeTimestamp"]];
                    userdata.nefdescription = [dic objectForKey:@"description"];
                    userdata.nefdate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];
                    userdata.nefurl = [dic objectForKey:@"url"];
                    userdata.neftypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
                    userdata.nefpartyname = [dic objectForKey:@"partyName"];
                    userdata.neftemplateurl = [dic objectForKey:@"templateUrl"];
                    userdata.nefcardtypeId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cardTypeId"]];
                    userdata.nefthumb = [NSString stringWithFormat:@"%@",[dic objectForKey:@"thumb"]];
                    userdata.nefnumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"number"]];
                    userdata.neftotal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"total"]];
                    userdata.neftype = 2;
                    [data addObject:userdata];
                }
                run = 0;
                [self showToptitle];
                [_tableview reloadData];
            }else{
            
            }
        }];
    }
}

-(void)loaddata{
    data = [[NSMutableArray alloc] init];
    NSArray *arr = [[DataBaseManage getDataBaseManage] getUserdata];
    for (Userdata *user in arr) {
        [data addObject:user];
    }
    run = 0;
    [self showToptitle];
    [_tableview reloadData];
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
    [self GetRecord];
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
//    ShareView* share = [ShareView sharedShareView];
//    share.fromvc = self;
//    share.url = @"http://baidu.com";
//    share.msg = @"lailai";
//    share.title = @"haha";
//    NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
//    UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"T4" ofType:@"png"]];
//    share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
//    [share show];
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
        view.maxnum = maxnum;
        view.starttime = starttime;
        view.datatime = datatime;
        view.endtime = endtime;
        view.delegate = self;
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
        [self getBottomRecord];
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
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    index_path = indexPath;
    Userdata *info = [data objectAtIndex:[indexPath row]];
    uniqueId = info.nefid;
    starttime = [info.nefdate longLongValue]/1000;
    endtime = [info.nefclosetimestamp longLongValue]/1000;
    datatime = [info.neftimestamp longLongValue]/1000;
    maxnum = info.neftotal;
    
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


- (IBAction)del_onclick:(id)sender {
    selectEditingStyle = UITableViewCellEditingStyleDelete;
    [_tableview setEditing:is_chose animated:YES];
    is_chose = !is_chose;
}

// 是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 编辑模式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模式
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        Userdata *userdata = [data objectAtIndex:indexPath.row];
        [SVProgressHUD showWithStatus:@"删除中" maskType:SVProgressHUDMaskTypeBlack];
        [HttpManage deleteRecords:userdata.nefid cb:^(BOOL isOK, NSDictionary *array) {
            [SVProgressHUD dismiss];
            if (isOK) {
                // 从数据源中删除
                [data removeObjectAtIndex:indexPath.row];
                // 删除行
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [[DataBaseManage getDataBaseManage] DelUserdata:userdata.nefid];
                [[StatusBar sharedStatusBar] talkMsg:@"删除成功" inTime:0.51];
            }else{
                [[StatusBar sharedStatusBar] talkMsg:@"删除失败" inTime:0.51];
            }
        }];
        
    }
    // 添加模式
//    else if(editingStyle == UITableViewCellEditingStyleInsert){
//        
//        // 从数据源中添加
//        [self.dataArray insertObject:@"new iPhone" atIndex:indexPath.row];
//        
//        // 添加行
//        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic ];
//    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (MFMailComposeResultSent == result || MFMailComposeResultSaved == result) {
        [[StatusBar sharedStatusBar] talkMsg:@"分享成功。" inTime:0.51];
    } else {
        [[StatusBar sharedStatusBar] talkMsg:@"消息未发送。" inTime:0.51];
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        ShareView* share = [ShareView sharedShareView];
        share.fromvc = self;
        share.url = url;
        share.msg = msg;
        share.title = title;
        NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon57" ofType:@"png"]];
        share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        [share show];
    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result == MessageComposeResultSent) {
        [[StatusBar sharedStatusBar] talkMsg:@"分享成功。" inTime:0.51];
    } else {
        [[StatusBar sharedStatusBar] talkMsg:@"消息未发送。" inTime:0.51];
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        ShareView* share = [ShareView sharedShareView];
        share.fromvc = self;
        share.url = url;
        share.msg = msg;
        share.title = title;
        NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon57" ofType:@"png"]];
        share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        [share show];
    }];
}

- (void)VCDelegate:(ViewCell *)cell didTapAtIndex:(long ) index{
    Userdata *user = [data objectAtIndex:index];
    NSLog(@"%d",user.neftype);
    switch (user.neftype) {
        case 0:
            
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@&%@ 婚礼",user.nefgroom,user.nefbride];
            msg = [NSString stringWithFormat:@"%@ %@",[TimeTool getFullTimeStr:[user.neftimestamp longLongValue]/1000],user.nefaddress];
            url = user.nefurl;
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
    
    ShareView* share = [ShareView sharedShareView];
    share.fromvc = self;
    share.url = url;
    share.msg = msg;
    share.title = title;
    UIImage* img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon57" ofType:@"png"]];
    share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
    [share show];
    
}

- (void)DVCDelegate:(DetailViewController *)cell didTapAtIndex:(NSString *) nefid{
    [SVProgressHUD showWithStatus:@"删除中" maskType:SVProgressHUDMaskTypeBlack];
    [HttpManage deleteRecords:nefid cb:^(BOOL isOK, NSDictionary *array) {
        [SVProgressHUD dismiss];
        if (isOK) {
            // 从数据源中删除
            [data removeObjectAtIndex:index_path.row];
            // 删除行
            [_tableview deleteRowsAtIndexPaths:@[index_path] withRowAnimation:UITableViewRowAnimationFade];
            [[DataBaseManage getDataBaseManage] DelUserdata:nefid];
            [[StatusBar sharedStatusBar] talkMsg:@"删除成功" inTime:0.51];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"删除失败" inTime:0.51];
        }
    }];
}

@end
