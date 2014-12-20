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

#import "HLEditViewController.h"

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
        bgCover = [[UIColor alloc] initWithWhite:0.9 alpha:0.9];
    }
    [self.view addSubview:bk];
    UIView* bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = bgCover;
    bgView.layer.opacity = 1;
    bgView.tag = 301;
    [self.view addSubview:bgView];
    //    这段兼容ios6
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGFloat subTap = -20;
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];//568,667
        subTap = 0;
    }
    CGFloat titleHeight = 30;
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
    
    MenuBackBtn* backBtn = [[MenuBackBtn alloc] initWithFrame:CGRectMake(0, 20.0, 88.0/2.0, 88.0/2.0) andType:self.type];
    backBtn.tag = 303;
    [self.view addSubview:backBtn];
    UITapGestureRecognizer* pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [backBtn addGestureRecognizer:pan];
    
    EditBtn* btnView = [[EditBtn alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
    btnView.tag = 302;
    btnView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-btnView.frame.size.height/2.0 - 12.0);
//    btnView.layer.transform = CATransform3DMakeRotation(-M_PI*2.0-M_PI_4,0,0,1);
    [self.view addSubview:btnView];
    [self indata];
    loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.view addSubview: loading];
    
    loading.center = _tempList.center;
    [self.view bringSubviewToFront:loading];
    [loading startAnimating];
    isloading = YES;
}
- (void)viewDidAppear:(BOOL)animated{
    //showList加载数据完成后调用
    if (isloading) {
        isloading = NO;
        [_tempList reloadOther];
        [loading stopAnimating];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
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
    [_tempList reloadViews];
    [_tempList showList];//进厂动画
    [self didShowItemAtIndex:0];
    
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)numberOfItems{
    //列表元素个数哈哈
    return [data count];
}

-(UIView*)cellForItemAtIndex:(int)index{
    Template *info = [data objectAtIndex:index];
    NSString *nefmbbg = info.nefmbbg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
    UIImage* imgt = [[UIImage alloc]initWithContentsOfFile:nefmbbg];
    UIImage* img = [[UIImage alloc] initWithCGImage:imgt.CGImage scale:2.0 orientation:UIImageOrientationUp];
    CGRect itemRect = CGRectMake(0, 0, _tempList.itemSize.width, _tempList.itemSize.height);
    
    TemplateCell* mainCell = [[TemplateCell alloc] initWithFrame:itemRect andImage:img];
    return mainCell;
}

-(void)didSelectItemAtIndex:(int)index{
    Template *info = [data objectAtIndex:index];
    unquieId = [NSString stringWithFormat:@"%@",info.nefid];
    nefmbdw = info.nefmbdw;
    
    //选中事件
    int type = [neftypeId intValue];
    switch (type) {
        case 1:
            [self performSegueWithIdentifier:@"hledit" sender:nil];
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}
-(void)didShowItemAtIndex:(int)index{
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
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier compare:@"hledit"] == NSOrderedSame ) {
        HLEditViewController* des = (HLEditViewController*)segue.destinationViewController;
        des.unquieId = unquieId;
        des.nefmbdw = nefmbdw;
    }else if ([segue.identifier compare:@"swedit"] == NSOrderedSame){
        
        
    }else if ([segue.identifier compare:@"chedit"] == NSOrderedSame){
        
        
    }else if ([segue.identifier compare:@"zdedit"] == NSOrderedSame){
        
        
    }

    
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
