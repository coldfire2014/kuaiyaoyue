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
@interface TemplateViewController ()

@end

@implementation TemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView* bk = [[UIImageView alloc] initWithImage:self.bgimg];
    [self.view addSubview:bk];
    UIView* bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [[UIColor alloc] initWithWhite:0.9 alpha:0.7];
    bgView.layer.opacity = 1;
    bgView.tag = 301;
    [self.view addSubview:bgView];
    
    //    这段兼容ios6
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    
    CGFloat subTap = -20;
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
        subTap = 0;
    }
    CGFloat titleHeight = 30;
    //列表布局
    tempList = [[ctView alloc] initWithFrame:CGRectMake(5,20+44+titleHeight + subTap,mainScreenFrame.size.width-10,mainScreenFrame.size.height-60-20-44-titleHeight- subTap)];
    
    tempList.tag = 404;
    tempList.userInteractionEnabled = YES;
    tempList.backgroundColor = [UIColor clearColor];
    [self.view addSubview: tempList];
    tempList.delegate = self;
    CGFloat h =  tempList.frame.size.height - 20;
    CGFloat w =  h * mainScreenFrame.size.width / mainScreenFrame.size.height;
    tempList.itemSize = CGSizeMake(w,h);//定义cell的显示大小
    
    [tempList reloadViews];//加载cell
    [tempList showList];//进厂动画
    [self didShowItemAtIndex:0];
    
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
    return 9;
}

-(UIView*)cellForItemAtIndex:(int)index{
    
    //得到IMG
    NSString* iName = [[NSString alloc] initWithFormat:@"b%d",index+1];
    UIImage* imgt = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:iName ofType:@"jpg"]];
    UIImage* img = [[UIImage alloc] initWithCGImage:imgt.CGImage scale:2.0 orientation:UIImageOrientationUp];
    
    
    CGRect itemRect = CGRectMake(0, 0, tempList.itemSize.width, tempList.itemSize.height);
    
    TemplateCell* mainCell = [[TemplateCell alloc] initWithFrame:itemRect andImage:img];
    return mainCell;
}

-(void)didSelectItemAtIndex:(int)index{
    //选中事件
    
}
-(void)didShowItemAtIndex:(int)index{
    //列表当前显示元素，目前用于换颜色
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
