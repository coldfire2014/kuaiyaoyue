//
//  TemplateViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "TemplateViewController.h"
#import "MenuBackBtn.h"
#import "EditBtn.h"
#import "myImageView.h"
#import "TemplateCell.h"
#import "PCHeader.h"
#import "DataBaseManage.h"
#import "Template.h"
#import "UDObject.h"
#import "StatusBar.h"
#import "TalkingData.h"
#import "ZipDown.h"
#import "EditViewController.h"
@interface TemplateViewController (){
    NSString *neftypeId;
    NSArray *data;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    UIColor* nowColor;
    UIColor* nowkColor;
    NSString *unquieId;
    NSString *nefmbdw;
}

@end

@implementation TemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView* bk = [[UIImageView alloc] initWithImage:self.bgimg];
    UIVisualEffectView* all = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    all.frame = bk.bounds;
    all.tag = 299;
    [bk addSubview:all];
    UIColor* bgCover;
    if (nil != all) {
        bgCover = [UIColor clearColor];
    } else {
        bgCover = [[UIColor alloc] initWithWhite:0.9 alpha:0.95];
    }
    bk.tag = 289;
    [self.view addSubview:bk];
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGFloat subTap = -20;
    if (ISIOS7LATER) {
        subTap = 0;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        mainScreenFrame = IPAD_FRAME;
    }
    CGFloat titleHeight = 30;
    UIView* bgView = [[UIView alloc] initWithFrame:mainScreenFrame];
    bgView.backgroundColor = bgCover;
    bgView.layer.opacity = 1;
    bgView.tag = 301;
    [bk addSubview:bgView];
    //列表布局
    _tempList = [[ctView alloc] initWithFrame:CGRectMake(5,20+44+titleHeight + subTap,mainScreenFrame.size.width-10,mainScreenFrame.size.height-60-20-44-titleHeight- subTap)];
    
    _tempList.tag = 404;
    _tempList.userInteractionEnabled = YES;
    _tempList.backgroundColor = [UIColor clearColor];
    [self.view addSubview: _tempList];
    
    _tempList.delegate = self;
    CGFloat h =  _tempList.frame.size.height - 20;
    CGFloat w =  h * mainScreenFrame.size.width / mainScreenFrame.size.height;
    _tempList.itemSize = CGSizeMake(w,h);//定义cell的显示大小
//     [_tempList reloadViews];//加载cell
//
    UILabel* mbtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, _tempList.frame.origin.y-21.0, _tempList.itemSize.width,21.0)];
    mbtitle.tag = 501;
    mbtitle.center = CGPointMake(mainScreenFrame.size.width/2.0, mbtitle.center.y);
    [mbtitle setFont:[UIFont systemFontOfSize:19]];
    [mbtitle setTextAlignment:NSTextAlignmentLeft];
    [mbtitle setLineBreakMode:NSLineBreakByClipping];
    [mbtitle setTextColor:[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0  blue:88.0/255.0  alpha:1.0]];
    [mbtitle setBackgroundColor:[UIColor clearColor]];
    [mbtitle setText:@""];
    [bk addSubview:mbtitle];
    UILabel* mbtotle = [[UILabel alloc] initWithFrame:CGRectMake(0, _tempList.frame.origin.y-14.0, _tempList.itemSize.width,14.0)];
    mbtotle.tag = 502;
    mbtotle.center = CGPointMake(mainScreenFrame.size.width/2.0, mbtotle.center.y);
    [mbtotle setFont:[UIFont systemFontOfSize:13]];
    [mbtotle setTextAlignment:NSTextAlignmentRight];
    [mbtotle setLineBreakMode:NSLineBreakByClipping];
    [mbtotle setTextColor:[[UIColor alloc] initWithWhite:0.2 alpha:1.0]];
    [mbtotle setBackgroundColor:[UIColor clearColor]];
    [mbtotle setText:@""];
    [bk addSubview:mbtotle];
    UILabel* mbid = [[UILabel alloc] initWithFrame:CGRectMake(0, _tempList.frame.origin.y-21.0, _tempList.itemSize.width-40,21.0)];//50
    mbid.tag = 503;
    mbid.center = CGPointMake(mainScreenFrame.size.width/2.0, mbid.center.y);
    [mbid setFont:[UIFont systemFontOfSize:19]];
    [mbid setTextAlignment:NSTextAlignmentRight];
    [mbid setLineBreakMode:NSLineBreakByClipping];
    [mbid setTextColor:[[UIColor alloc] initWithWhite:0.2 alpha:1.0]];
    [mbid setBackgroundColor:[UIColor clearColor]];
    [mbid setText:@""];
    [bk addSubview:mbid];
//    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20.0+subTap, mainScreenFrame.size.width,54.0)];
    [title setFont:[UIFont systemFontOfSize:20]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setLineBreakMode:NSLineBreakByClipping];
    [title setTextColor:[[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0  blue:88.0/255.0  alpha:1.0]];
    [title setBackgroundColor:[UIColor clearColor]];
    if ([_type isEqualToString:@"hunli"]) {
        [title setText:@"婚礼微喜帖"];
    }else if ([_type isEqualToString:@"sanwu"]){
        [title setText:@"商务邀请函"];
    }else if ([_type isEqualToString:@"cihe"]){
        [title setText:@"聚会邀请函"];
    }else if ([_type isEqualToString:@"zdy"]){
        [title setText:@"自定义请柬"];
    }
    
    [bk addSubview:title];

    myImageView* backall = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 54.0/2.0, 54.0/2.0) andImageName:@"ic_54_x@2x" withScale:2.0];
    backall.center = CGPointMake(mainScreenFrame.size.width-31.0, 20.0+subTap + 29.0);
    backall.tag = 304;
    [self.view addSubview:backall];
    UITapGestureRecognizer* panall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAll)];
    [backall addGestureRecognizer:panall];
    
    MenuBackBtn* backBtn = [[MenuBackBtn alloc] initWithFrame:CGRectMake(0, 20.0+subTap, 88.0/2.0, 88.0/2.0) andType:self.type];
    backBtn.tag = 303;
    [self.view addSubview:backBtn];
    UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [backBtn addGestureRecognizer:pan];
    
    EditBtn* btnView = [[EditBtn alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
    btnView.tag = 302;
    btnView.center = CGPointMake(mainScreenFrame.size.width/2.0, mainScreenFrame.size.height-btnView.frame.size.height/2.0 - 12.0);
//    btnView.layer.transform = CATransform3DMakeRotation(-M_PI*2.0-M_PI_4,0,0,1);
    [self.view addSubview:btnView];
    
    UITapGestureRecognizer* tapEdit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(edit)];
    [btnView addGestureRecognizer:tapEdit];
    
    myImageView* editimg = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 54.0/2.0, 54.0/2.0) andImageName:@"ic_54_edit@2x" withScale:2.0];
    editimg.center = CGPointMake(btnView.bounds.size.width/2.0, 62.0/4.0);
    [btnView addSubview:editimg];
    UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(0, 24.0, 47.0,20.0)];
    [add setFont:[UIFont systemFontOfSize:13]];
    [add setTextAlignment:NSTextAlignmentCenter];
    [add setLineBreakMode:NSLineBreakByClipping];
    [add setTextColor:[[UIColor alloc] initWithWhite:1.0 alpha:1.0]];
    [add setBackgroundColor:[UIColor clearColor]];
    [add setText:@"编辑"];
    [btnView addSubview:add];
    
    [self indata];
    loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.view addSubview: loading];
    
    loading.center = _tempList.center;
    [self.view bringSubviewToFront:loading];
//    [loading startAnimating];
    isloading = YES;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //showList加载数据完成后调用
    [TalkingData trackPageBegin:@"模板选择页"];
    
    if (isloading) {
        isloading = NO;
        [_tempList showList];
//        [loading stopAnimating];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [TalkingData trackPageEnd:@"模板选择页"];
}
- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)indata{
    if ([_type isEqualToString:@"hunli"]) {
        neftypeId = @"1";
    }else if ([_type isEqualToString:@"sanwu"]){
        neftypeId = @"2";
    }else if ([_type isEqualToString:@"cihe"]){
        neftypeId = @"3";
    }else if ([_type isEqualToString:@"zdy"]){
        neftypeId = @"4";
    }
    
    data = [[DataBaseManage getDataBaseManage] GetTemplate:neftypeId];
    if (data.count > 0) {
        [_tempList reloadViews];
        //    [_tempList showList];//进厂动画
        [self didShowItemAtIndex:0];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getmax" object:self userInfo:nil];
        [[StatusBar sharedStatusBar] talkMsg:@"模板正在下载中..." inTime:0.5];
    }
}

- (void)backAll{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [TalkingData trackEvent:@"退回主页"];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [TalkingData trackEvent:@"返回新建菜单"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfItems{
    //列表元素个数哈哈
    return [data count];
}

-(UIView*)cellForItemAtIndex:(NSInteger)index{
    Template *info = [data objectAtIndex:index];
    NSString *nefmbbg = [[NSString alloc] initWithFormat:@"%@",info.nefmbbg];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
    if (![[NSFileManager defaultManager] fileExistsAtPath:nefmbbg]) {
        NSArray* names = [info.nefmbbg componentsSeparatedByString:@"/"];
        NSString *name = [names objectAtIndex:2];
        [ZipDown UnzipSingle:name];
    }
    UIImage* imgt = [[UIImage alloc]initWithContentsOfFile:nefmbbg];
    UIImage* img = [[UIImage alloc] initWithCGImage:imgt.CGImage scale:2.0 orientation:UIImageOrientationUp];
    CGRect itemRect = CGRectMake(0, 0, _tempList.itemSize.width, _tempList.itemSize.height);
    TemplateCell* mainCell = [[TemplateCell alloc] initWithFrame:itemRect andImage:img];
    return mainCell;
}
-(void)edit{
    NSInteger index = [_tempList getIndex];
    [self didSelectItemAtIndex:index];
    
}
-(void)didSelectItemAtIndex:(NSInteger)index{
    Template *info = [data objectAtIndex:index];
    unquieId = [NSString stringWithFormat:@"%@",info.nefid];
    nefmbdw = info.nefmbdw;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *zipurl = [documentsDirectory stringByAppendingPathComponent:info.nefzipurl];
    [UDObject setWebUrl:zipurl];
    //选中事件
    int type = [neftypeId intValue];
    switch (type) {
        case 1:
            [self performSegueWithIdentifier:@"newedit" sender:@"1"];
            [TalkingData trackEvent:@"编辑内容" label:[[NSString alloc] initWithFormat:@"婚礼-%@",info.nefname]];
            break;
        case 2:
            [self performSegueWithIdentifier:@"newedit" sender:@"2"];
            [TalkingData trackEvent:@"编辑内容" label:[[NSString alloc] initWithFormat:@"商务-%@",info.nefname]];
//             [[StatusBar sharedStatusBar] talkMsg:@"尽请期待，请移步婚礼编辑。" inTime:0.51];
            break;
        case 3:
            [self performSegueWithIdentifier:@"newedit" sender:@"3"];
            [TalkingData trackEvent:@"编辑内容" label:[[NSString alloc] initWithFormat:@"吃喝玩乐-%@",info.nefname]];
//             [[StatusBar sharedStatusBar] talkMsg:@"尽请期待，请移步婚礼编辑。" inTime:0.51];
            break;
        case 4:
             [[StatusBar sharedStatusBar] talkMsg:@"尽请期待，请移步婚礼编辑。" inTime:0.51];
            break;
        default:
            break;
    }
}
-(void)didShowItemAtIndex:(NSInteger)index{
    UIView* btnView = [self.view viewWithTag:302];
    UILabel* mbtitle = (UILabel*)[self.view viewWithTag:501];
    UILabel* mbtotle = (UILabel*)[self.view viewWithTag:502];
    UILabel* mbid = (UILabel*)[self.view viewWithTag:503];
    //列表当前显示元素，目前用于换颜色
    Template *info = [data objectAtIndex:index];
    
    NSString *backColor = info.nefbackcolor;
    NSString *a = [backColor substringToIndex:3];
    a = [a substringFromIndex:1];
    long b = strtoul([a UTF8String],0,16);
    NSString *c = [backColor substringToIndex:5];
    c = [c substringFromIndex:3];
    long d = strtoul([c UTF8String],0,16);
    NSString *f = [backColor substringFromIndex:5];
    long e = strtoul([f UTF8String],0,16);
    
    red = b/255.0;
    green = d/255.0;
    blue = e/255.0;
    
    nowColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    nowkColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
    [UIView animateWithDuration:0.4 animations:^{
        btnView.backgroundColor = nowColor;
        mbtitle.textColor = nowColor;
        mbid.textColor = nowColor;
        mbtotle.text = [[NSString alloc] initWithFormat:@"/%lu",(unsigned long)data.count];
        mbid.text = [[NSString alloc] initWithFormat:@"%ld",index+1l];
        if ([_type isEqualToString:@"hunli"]) {
            mbtitle.text = [[NSString alloc] initWithFormat:@"%@",info.nefname];
        }else{
            mbtitle.text = @"";
        }
    }];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [loading stopAnimating];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [loading startAnimating];
    EditViewController* des = (EditViewController*)segue.destinationViewController;
    des.tempId = unquieId;
    des.tempLoc = nefmbdw;
    des.typeid = (NSString*)sender;
//    if ([segue.identifier compare:@"hledit"] == NSOrderedSame ) {
//        HLEditViewController* des = (HLEditViewController*)segue.destinationViewController;
//        des.unquieId = unquieId;
//        des.nefmbdw = nefmbdw;
//    }else if ([segue.identifier compare:@"swedit"] == NSOrderedSame){
//        SWYQViewController *view = (SWYQViewController *)segue.destinationViewController;
//        view.unquieId = unquieId;
//        view.nefmbdw = nefmbdw;
//    }else if ([segue.identifier compare:@"chedit"] == NSOrderedSame){
//        CHWLEditorViewController *view = (CHWLEditorViewController *)segue.destinationViewController;
//        view.unquieId = unquieId;
//        view.nefmbdw = nefmbdw;
//    }else if ([segue.identifier compare:@"zdedit"] == NSOrderedSame){
//        
//    }
}

//- (IBAction)hl_onclick:(id)sender {
//    [self performSegueWithIdentifier:@"hledit" sender:nil];
//}
//
//- (IBAction)sw_onclick:(id)sender {
//    [self performSegueWithIdentifier:@"swedit" sender:nil];
//}
//
//- (IBAction)wl_onclick:(id)sender {
//    [self performSegueWithIdentifier:@"chedit" sender:nil];
//}
//
//- (IBAction)zdy_onclick:(id)sender {
//    [self performSegueWithIdentifier:@"" sender:nil];
//}

@end
