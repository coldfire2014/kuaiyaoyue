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
#import "TalkingData.h"
#import "TimeTool.h"
#import "myImageView.h"
#import "HttpManage.h"
#import "UDObject.h"
#import "DataBaseManage.h"
#import "Userdata.h"
#import "DetailViewController.h"
#import "ShareView.h"
#import "WebViewController.h"
#import "FileManage.h"
#import "waitingView.h"
#import "SettingViewController.h"
#import "PCHeader.h"
@interface ViewController ()<VCDelegate,DVCDelegate>{
    NSMutableArray *data;
    NSString *uniqueId;
    NSTimeInterval starttime;
    NSTimeInterval endtime;
    NSTimeInterval datatime;
    NSString *maxnum;
    BOOL inGetRecord;
    int run;
    UITableViewCellEditingStyle selectEditingStyle;
    BOOL is_chose;
    NSString *detailTitle;
    NSString *url;
    NSString *msg;
    NSString *title;
    NSString *thumb;
    NSIndexPath *index_path;
    myImageView* emptyImg;
    BOOL is_bcfs;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage* img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"small" ofType:@"png"]];
    self.showview_img.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
    is_bcfs = NO;
    inGetRecord = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"返回";
    [self setupRefresh];
    is_chose = YES;
    CreateBtn* btnView = [[CreateBtn alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
    btnView.tag = 99;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (ISIOS8LATER) {
            btnView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-btnView.frame.size.height/2.0 - 12.0);
        } else {
            btnView.center = CGPointMake(self.view.frame.size.height/2.0, self.view.frame.size.width-btnView.frame.size.height/2.0 - 12.0);
        }
    } else {
        btnView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-btnView.frame.size.height/2.0 - 12.0);
    }
    [self.view addSubview:btnView];
    
    UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPan)];
    [btnView addGestureRecognizer:pan];//160*220
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeTimeAtTimedisplay) userInfo:nil repeats:YES];
    [timer fire];
    
    [self headview];
    
    _tableview.separatorStyle = NO;
    //滑动监听
//    _tableview.contentInset = UIEdgeInsetsMake(-20, 0 ,0, 0);
//   [_tableview setContentOffset:CGPointMake(0, -196) animated:YES];
    emptyImg = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 456.0/2.0,431.0/2.0) andImageName:@"img_empty_homeb" withScale:2.0 ];
    emptyImg.alpha = 0;
    emptyImg.center = CGPointMake(btnView.center.x, btnView.center.y-47.0/2.0-431.0/4.0);
    [self.view addSubview:emptyImg];
    [_bg_view setHidden:YES];
    [self loaddata];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message) name:@"message" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bcfs) name:@"MSG_BCFS" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bc) name:@"MSG_FS" object:nil];
    UIView* tj_Btn = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
    tj_Btn.backgroundColor = [UIColor clearColor];
    tj_Btn.tag = 308;
    UITapGestureRecognizer* pan1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTJ)];
    [tj_Btn addGestureRecognizer:pan1];
    [self.head_view addSubview:tj_Btn];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    label.text = TJ_TITLE;
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    myImageView* btn_img = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 48.0/2.0, 48.0/2.0) andImageName:@"tj_btn" withScale:2.0];
    btn_img.center = CGPointMake(22, 22);
    [tj_Btn addSubview:btn_img];
    
    UIView* new_btn = [[UIView alloc] initWithFrame:CGRectMake(32, 10, 10, 10)];
    new_btn.backgroundColor = [UIColor redColor];
    new_btn.layer.cornerRadius = 5.0;
    new_btn.tag = 309;
    [tj_Btn addSubview:new_btn];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *is_tap = [userInfo valueForKey:@"TUIJIANDIDTAP"];
    if (is_tap != nil && [is_tap compare:@""] != NSOrderedSame) {
        new_btn.alpha = 0;
    }else{
        NSTimer* countDownTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
        [countDownTimer fire];
    }
    if ([YINGLOUURL compare:@""] != NSOrderedSame)
    {
        tj_Btn.alpha = 0;
    }
}
-(void)timeFireMethod:(NSTimer*)timer{
    CATransform3D t = CATransform3DIdentity;
    UIView* tj_Btn = [self.head_view viewWithTag:308];
    UIView* new_btn = [self.head_view viewWithTag:309];
    if (tj_Btn.alpha == 0 || new_btn.alpha == 0) {
        [timer invalidate];
        return;
    }
    CAKeyframeAnimation* transformAnim1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transformAnim1.values = [[NSArray alloc] initWithObjects:
                             [NSValue valueWithCATransform3D:CATransform3DRotate(t, -0.22, 0, 0, 4)],
                             [NSValue valueWithCATransform3D:CATransform3DRotate(t, -0.22, 0, 0, -3)],
                             [NSValue valueWithCATransform3D:CATransform3DRotate(t, -0.22, 0, 0, 2)],
                             [NSValue valueWithCATransform3D:CATransform3DRotate(t, -0.22, 0, 0, -0.5)],
                             [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
    transformAnim1.removedOnCompletion = YES;
    transformAnim1.duration = 0.4;
    transformAnim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [tj_Btn.layer addAnimation:transformAnim1 forKey:@"tj_Btn"];
}
-(void)showTJ{
//    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
//    [userInfo setValue:@"TUIJIANDIDTAP" forKey:@"TUIJIANDIDTAP"];
//    [userInfo synchronize];
    UIView* new_btn = [self.head_view viewWithTag:309];
    new_btn.alpha = 0;
    [TalkingData trackEvent: @"推荐点击"];
    WebViewController *view = [[WebViewController alloc] init];
    [view NavColor:[[UIColor alloc] initWithRed:248.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0] andtextColor:[UIColor whiteColor]];
    view.name = TJ_TITLE;
    view.weburl = TJ_URL;
    view.viewTitle = @"推荐页面";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        view.modalPresentationStyle = UIModalPresentationFormSheet;
    } else {
        view.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    //UIModalPresentationOverFullScreen 全屏对下透明
    view.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:view animated:YES completion:^{
        
    }];
}
-(void)message{
    [self GetRecord:@"-1"];
}
-(void)bc{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self loaddata];
}
-(void)bcfs{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self loaddata];
    Userdata *user = [data objectAtIndex:0];
    switch (user.neftype) {
        case 0:
            title = [NSString stringWithFormat:@"%@",user.neftitle];
            msg = [NSString stringWithFormat:@"%@",user.nefcontent];
            url = user.nefurl;
            thumb = user.neflogo;
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@&%@ 结婚典礼",user.nefgroom,user.nefbride];
            msg = [NSString stringWithFormat:@"谨定于%@ 席设%@",[TimeTool getFullTimeStr:[user.neftimestamp doubleValue]/1000.0],user.nefaddress];
            url = user.nefurl;
            thumb = user.nefthumb;
            break;
        case 2:
            title = [NSString stringWithFormat:@"%@",user.nefpartyname];
            msg = [NSString stringWithFormat:@"%@ %@ %@ %@",user.nefgroom,[TimeTool getFullTimeStr:[user.neftimestamp doubleValue]/1000.0],user.nefaddress,user.nefdescription];
            url = user.nefurl;
            thumb = user.nefthumb;
            break;
            
        default:
            break;
    }
    NSString *topimg = nil;
    if (user.neftype == 0) {
        NSArray *array = [user.neflogo componentsSeparatedByString:@"/"];
        topimg = [array objectAtIndex:([array count] - 1)];
        topimg = [[FileManage sharedFileManage] getImgFile:topimg];
    }else{
        NSArray *array = [user.nefthumb componentsSeparatedByString:@"/"];
        topimg = [array objectAtIndex:([array count] - 4)];
        topimg = [[FileManage sharedFileManage] getThumb:topimg];
        topimg = [NSString stringWithFormat:@"%@/assets/images/thumb",topimg];
    }
    
    ShareView* share = [ShareView sharedShareView];
    share.fromvc = self;
    share.url = url;
    share.msg = msg;
    share.title = title;
    share.imgUrl = thumb;
    UIImage *img = [[UIImage alloc]initWithContentsOfFile:topimg];
    share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
    [share show];
    
}

-(void)GetRecord:(NSString*)count{
    if (!inGetRecord) {
        inGetRecord = YES;
        [HttpManage multiHistory:[UDObject gettoken] timestamp:@"-1" size:count cb:^(BOOL isOK, NSDictionary *array) {
            if (isOK) {
                BOOL needReload = NO;
                NSNumber* ts_max = [NSNumber numberWithDouble:-1];
                NSArray *customList = [array objectForKey:@"customList"];
                for (NSDictionary *dic in customList) {
                    NSNumber* num = [dic valueForKey:@"date"];
                    if ([num compare:ts_max] == NSOrderedDescending) {
                        ts_max = num;
                    }
                    needReload = YES;
                    BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                    if (!is_bcz) {
                        [[DataBaseManage getDataBaseManage] AddUserdata:dic type:0];
                    }
                }
                NSArray *marryList = [array objectForKey:@"marryList"];
                for (NSDictionary *dic in marryList) {
                    NSNumber* num = [dic valueForKey:@"date"];
                    if ([num compare:ts_max] == NSOrderedDescending) {
                        ts_max = num;
                    }
                    needReload = YES;
                    BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                    if (!is_bcz) {
                        [[DataBaseManage getDataBaseManage] AddUserdata:dic type:1];
                    }
                }
                NSArray *partyList = [array objectForKey:@"partyList"];
                for (NSDictionary *dic in partyList) {
                    NSNumber* num = [dic valueForKey:@"date"];
                    if ([num compare:ts_max] == NSOrderedDescending) {
                        ts_max = num;
                    }
                    needReload = YES;
                    BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                    if (!is_bcz) {
                        [[DataBaseManage getDataBaseManage] AddUserdata:dic type:2];
                    }
                }
                if (needReload) {
                    [self reloaddata];
//                    if ([count compare:@"30"] == NSOrderedSame) {
//                        [_tableview headerEndRefreshing];
//                    }
                    [UDObject setTimestamp:[ts_max description]];
                }
            }
            inGetRecord = NO;
            [_tableview headerEndRefreshing];
        }];
    }
}

-(void)getBottomRecord{
    if ([data count] > 29) {
        Userdata *user = [data objectAtIndex:[data count] - 1];
        NSString* timestamp = user.nefdate;
        [HttpManage multiHistory:[UDObject gettoken] timestamp:timestamp size:@"30" cb:^(BOOL isOK, NSDictionary *array) {
            if (isOK) {
                BOOL needReload = NO;
                NSArray *customList = [array objectForKey:@"customList"];
                for (NSDictionary *dic in customList) {
                    needReload = YES;
                    BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                    if (!is_bcz) {
                        [[DataBaseManage getDataBaseManage] AddUserdata:dic type:0];
                    }
                }
                NSArray *marryList = [array objectForKey:@"marryList"];
                for (NSDictionary *dic in marryList) {
                    needReload = YES;
                    BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                    if (!is_bcz) {
                        [[DataBaseManage getDataBaseManage] AddUserdata:dic type:1];
                    }
                }
                NSArray *partyList = [array objectForKey:@"partyList"];
                for (NSDictionary *dic in partyList) {
                    needReload = YES;
                    BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                    if (!is_bcz) {
                        [[DataBaseManage getDataBaseManage] AddUserdata:dic type:2];
                    }
                }
                if (needReload) {
                    [self reloaddata];
                }
            }
            [_tableview footerEndRefreshing];
        }];
    }else{
        [_tableview footerEndRefreshing];
    }
}
-(void)reloaddata{
    data = [[NSMutableArray alloc] init];
    NSArray *arr = [[DataBaseManage getDataBaseManage] getUserdata];
    if (arr==nil || arr.count == 0) {
    } else {
        for (Userdata *user in arr) {
            [data addObject:user];
        }
        run = 0;
        [self showToptitle];
        [_tableview reloadData];
    }
}
-(void)loaddata{
    [self.navigationController popToRootViewControllerAnimated:NO];
    data = [[NSMutableArray alloc] init];
    NSArray *arr = [[DataBaseManage getDataBaseManage] getUserdata];
    if (arr==nil || arr.count == 0) {
        [self showToptitle];
        [_tableview headerBeginRefreshing];
        [self GetRecord:@"30"];
    } else {
        for (Userdata *user in arr) {
            [data addObject:user];
        }
        run = 0;
        [self showToptitle];
        [_tableview reloadData];
    }
}

//0自定义，1婚礼，2趴体
-(void)showToptitle{
    NSDate *datenow = [NSDate date];
    NSTimeInterval newdata = [datenow timeIntervalSince1970];
    int runtime = 0;
    for (int i = 0; i < [data count]; i++) {
        Userdata *info = [data objectAtIndex:i];
        NSTimeInterval closetime;
        switch (info.neftype) {
            case 0:
                closetime = [info.nefclosetimestamp doubleValue]/1000.0;
                break;
            case 1:
                closetime = [info.neftimestamp doubleValue] /1000.0;
                break;
            case 2:
                closetime = [info.nefclosetimestamp doubleValue] /1000.0;
                break;
                
            default:
                break;
        }
        if (newdata < closetime) {
            runtime++;
        }
    }
    if([data count] > 0){
        NSString *toptitle = [NSString stringWithFormat:@"共%lu个邀约,%d个正在进行……",(unsigned long)[data count],runtime];
        _show_toptitle.text = toptitle;
        emptyImg.alpha = 0;
    }else{
        NSString *toptitle = [NSString stringWithFormat:@"您还没有发起邀请哦，点击加号开始吧！"];
        _show_toptitle.text = toptitle;
        [UIView animateWithDuration:0.3 animations:^{
            emptyImg.alpha = 1;
        }];
    }
}


-(void)headview{
    _show_img.layer.masksToBounds = YES;
    _show_img.layer.cornerRadius = 34;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [TalkingData trackPageBegin:@"首页"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [TalkingData trackPageEnd:@"首页"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self GetRecord:@"-1"];//markwyb
}

-(void)changeTimeAtTimedisplay{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_MYLIST_CLICK" object:self userInfo:nil];
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
        view.uniqueId = [[NSString alloc] initWithFormat:@"%@", uniqueId ];
        view.maxnum = [[NSString alloc] initWithFormat:@"%@", maxnum ];
        view.starttime = starttime;
        view.datatime = datatime;
        view.endtime = endtime;
        view.delegate = self;
        view.index = [index_path row];
        view.title = detailTitle;
    }else if ([segue.identifier compare:@"showurl"] == NSOrderedSame){
        
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
    [self GetRecord:@"-1"];
}

- (void)footerRereshing
{
    [self getBottomRecord];
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
    
    cell.index = [indexPath row];
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
    starttime = [info.nefdate doubleValue]/1000.0;
    endtime = [info.nefclosetimestamp doubleValue]/1000.0;
    datatime = [info.neftimestamp doubleValue]/1000.0;
    maxnum = info.neftotal;
    
    if (info.neftype == 0) {
        detailTitle = [[NSString alloc] initWithFormat:@"%@",info.neftitle];
    } else if(info.neftype == 1){
        detailTitle = [[NSString alloc] initWithFormat:@"%@&%@ 婚礼",info.nefgroom,info.nefbride];
    }else{
        detailTitle = [[NSString alloc] initWithFormat:@"%@",info.nefpartyname];
    }
//    detailTitle = info.nef
    int num = [info.nefnumber intValue];
    if (num > 0) {
        [self cleanNumber];
    }
    [self performSegueWithIdentifier:@"detail" sender:nil];
}

-(void)cleanNumber{
    [HttpManage cleanNumber:uniqueId token:[UDObject gettoken] cb:^(BOOL isOK, NSDictionary *array) {
        if (isOK) {
            [[DataBaseManage getDataBaseManage] UpUserdata:uniqueId];
        }
    }];
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
    [TalkingData trackEvent:@"批量删除"];
}

- (IBAction)setting_onclick:(id)sender {
    [TalkingData trackEvent:@"点击设置"];
    SettingViewController* setting = [[SettingViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:setting];
    [navigationController setNavigationBarHidden:YES];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
//    [self performSegueWithIdentifier:@"setting" sender:nil];
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
        [[waitingView sharedwaitingView] startWait];
        [HttpManage deleteRecords:userdata.nefid cb:^(BOOL isOK, NSDictionary *array) {
            [[waitingView sharedwaitingView] stopWait];
            if (isOK) {
                // 从数据源中删除
                [data removeObjectAtIndex:indexPath.row];
                // 删除行
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [[DataBaseManage getDataBaseManage] DelUserdata:userdata.nefid];
//                [[StatusBar sharedStatusBar] talkMsg:@"删除成功" inTime:0.51];
                [[waitingView sharedwaitingView] WarningByMsg:@"删除成功" haveCancel:NO];
                [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:WAITING_TIME];
                [self showToptitle];
            }else{
//                [[StatusBar sharedStatusBar] talkMsg:@"删除失败" inTime:0.51];
                [[waitingView sharedwaitingView] WarningByMsg:@"删除失败" haveCancel:NO];
                [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
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
//        [[StatusBar sharedStatusBar] talkMsg:@"分享成功。" inTime:0.51];
        [[waitingView sharedwaitingView] WarningByMsg:@"分享成功。" haveCancel:NO];
        [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:WAITING_TIME];
    } else {
//        [[StatusBar sharedStatusBar] talkMsg:@"消息未发送。" inTime:0.51];
        [[waitingView sharedwaitingView] WarningByMsg:@"消息未发送。" haveCancel:NO];
        [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        ShareView* share = [ShareView sharedShareView];
        share.fromvc = self;
        share.url = url;
        share.msg = msg;
        share.title = title;
        share.imgUrl = @"http://pp.myapp.com/ma_icon/0/icon_11251614_19813241_1418702475/96";
        NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon57" ofType:@"png"]];
        share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        [share show];
    }];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result == MessageComposeResultSent) {
//        [[StatusBar sharedStatusBar] talkMsg:@"分享成功。" inTime:0.51];
        [[waitingView sharedwaitingView] WarningByMsg:@"分享成功。" haveCancel:NO];
        [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:WAITING_TIME];
    } else {
//        [[StatusBar sharedStatusBar] talkMsg:@"消息未发送。" inTime:0.51];
        [[waitingView sharedwaitingView] WarningByMsg:@"消息未发送。" haveCancel:NO];
        [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        ShareView* share = [ShareView sharedShareView];
        share.fromvc = self;
        share.url = url;
        share.msg = msg;
        share.title = title;
        share.imgUrl = @"http://pp.myapp.com/ma_icon/0/icon_11251614_19813241_1418702475/96";
        NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"imgBar" ofType:@"bundle"]];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon57" ofType:@"png"]];
        share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        [share show];
    }];
}

- (void)VCDelegate:(ViewCell *)cell didTapAtIndex:(long ) index type:(int)type{
    
    
    Userdata *user = [data objectAtIndex:index];
    switch (user.neftype) {
        case 0:
            title = [NSString stringWithFormat:@"%@",user.neftitle];
            msg = [NSString stringWithFormat:@"%@",user.nefcontent];
            url = user.nefurl;
            thumb = user.neflogo;
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@&%@ 结婚典礼",user.nefgroom,user.nefbride];
            msg = [NSString stringWithFormat:@"谨定于%@ 席设%@",[TimeTool getFullTimeStr:[user.neftimestamp doubleValue]/1000.0],user.nefaddress];
            url = user.nefurl;
            thumb = user.nefthumb;
            break;
        case 2:
            title = [NSString stringWithFormat:@"%@",user.nefpartyname];
            msg = [NSString stringWithFormat:@"%@ %@ %@ %@",user.nefgroom,[TimeTool getFullTimeStr:[user.neftimestamp doubleValue]/1000.0],user.nefaddress,user.nefdescription];
            url = user.nefurl;
            thumb = user.nefthumb;
            break;

        default:
            break;
    }
    if (type == 0) {
        ShareView* share = [ShareView sharedShareView];
        share.fromvc = self;
        share.url = url;
        share.msg = msg;
        share.title = title;
        share.imgUrl = thumb;
        UIImage* img = cell.show_img.image;
        share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        [share show];
        [TalkingData trackEvent:@"按钮发送"];
    }else{
        [TalkingData trackEvent:@"查看邀约"];
        WebViewController *view = [[WebViewController alloc] init];
        view.name = @"浏览";
        view.weburl = user.nefurl;
        view.viewTitle = @"生成后预览";
        view.modalPresentationStyle = UIModalPresentationFormSheet;
        //UIModalPresentationOverFullScreen 全屏对下透明
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:^{
            
        }];
    }
}

- (void)DVCDelegate:(DetailViewController *)cell didTapAtIndex:(NSString *) nefid{
    [TalkingData trackEvent:@"删除邀约"];
    [[waitingView sharedwaitingView] startWait];
    [HttpManage deleteRecords:nefid cb:^(BOOL isOK, NSDictionary *array) {
        [[waitingView sharedwaitingView] stopWait];
        if (isOK) {
            // 从数据源中删除
            [data removeObjectAtIndex:index_path.row];
            // 删除行
            [_tableview deleteRowsAtIndexPaths:@[index_path] withRowAnimation:UITableViewRowAnimationFade];
            [[DataBaseManage getDataBaseManage] DelUserdata:nefid];
            //                [[StatusBar sharedStatusBar] talkMsg:@"删除成功" inTime:0.51];
            [self showToptitle];
        }else{
            //                [[StatusBar sharedStatusBar] talkMsg:@"删除失败" inTime:0.51];
            [[waitingView sharedwaitingView] WarningByMsg:@"删除失败" haveCancel:NO];
            [[waitingView sharedwaitingView] performSelector:@selector(stopWait) withObject:nil afterDelay:ERR_TIME];
        }
    }];
}

- (void)ShareDelegate:(NSInteger) index{
    Userdata *user = [data objectAtIndex:index];
    switch (user.neftype) {
        case 0:
            title = [NSString stringWithFormat:@"%@",user.neftitle];
            msg = [NSString stringWithFormat:@"%@",user.nefcontent];
            url = user.nefurl;
            thumb = user.neflogo;
            break;
        case 1:
            title = [NSString stringWithFormat:@"%@&%@ 结婚典礼",user.nefgroom,user.nefbride];
            
            msg = [NSString stringWithFormat:@"谨定于%@ 席设%@",[TimeTool getFullTimeStr:[user.neftimestamp doubleValue]/1000.0],user.nefaddress];
            url = user.nefurl;
            thumb = user.nefthumb;
            break;
        case 2:
            title = [NSString stringWithFormat:@"%@",user.nefpartyname];
            
            msg = [NSString stringWithFormat:@"%@ %@ %@ %@",user.nefgroom,[TimeTool getFullTimeStr:[user.neftimestamp doubleValue]/1000.0],user.nefaddress,user.nefdescription];
            url = user.nefurl;
            thumb = user.nefthumb;
            break;
            
        default:
            break;
    }
    NSString *topimg = nil;
    if (user.neftype == 0) {
        NSArray *array = [user.neflogo componentsSeparatedByString:@"/"];
        topimg = [array objectAtIndex:([array count] - 1)];
        topimg = [[FileManage sharedFileManage] getImgFile:topimg];
    }else{
        NSArray *array = [user.nefthumb componentsSeparatedByString:@"/"];
        topimg = [array objectAtIndex:([array count] - 4)];
        topimg = [[FileManage sharedFileManage] getThumb:topimg];
        topimg = [NSString stringWithFormat:@"%@/assets/images/thumb",topimg];
    }
    
    
    ShareView* share = [ShareView sharedShareView];
    share.fromvc = self;
    share.url = url;
    share.msg = msg;
    share.title = title;
    share.imgUrl = thumb;
    UIImage* img = [[UIImage alloc]initWithContentsOfFile:topimg];
    share.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
    [share show];
}

@end
