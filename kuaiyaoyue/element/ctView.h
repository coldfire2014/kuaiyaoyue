//
//  ctView.h
//  edittext
//
//  Created by wu yangbing on 14-7-21.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ctViewDelegate <NSObject>

-(int)numberOfItems;
-(UIView*)cellForItemAtIndex:(int)index;
-(void)didSelectItemAtIndex:(int)index;
-(void)didShowItemAtIndex:(int)index;

@end
@interface ctView : UIView
{
    int itemCount;
    int currentItemIndex;
    float numberOfVisibleItems;
    
    float itemHeight;
    
    float perspective;
    float panTotal;
    CGPoint previousTranslation;
    CGPoint firstTranslation;
    float yt;
}
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat radius;
@property(nonatomic, weak) id<ctViewDelegate> delegate;
-(void)reloadViews;
-(void)showList;
-(int)getIndex;
-(void)left;
-(void)right;
@end
/*
//    这段兼容ios6
CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];

CGFloat subTap = -20;
if (ISIOS7LATER) {
    mainScreenFrame = [[UIScreen mainScreen] bounds];
    subTap = 0;
}

//列表布局
rewiew = [[ctView alloc] initWithFrame:CGRectMake(5,64 + subTap,mainScreenFrame.size.width-10,mainScreenFrame.size.height-64 - subTap)];

rewiew.tag = 404;
rewiew.userInteractionEnabled = YES;
rewiew.backgroundColor = [UIColor clearColor];
[self.view addSubview: rewiew];
rewiew.delegate = self;
CGFloat h =  rewiew.frame.size.height - 90;
CGFloat w =  h * 640.0 / 1136.0;
rewiew.itemSize = CGSizeMake(w,h);//定义cell的显示大小
 
 [rewiew reloadViews];//加载cell
 ctView* ctv = (ctView*)[self.view viewWithTag:404];
 [ctv showList];//进厂动画
 [self didShowItemAtIndex:0];
// 、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
 //列表当前显示元素，目前用于换颜色
 -(void)didShowItemAtIndex:(int)index{
 ROW = index;
 
 }
 
 -(int)numberOfItems{
 return [self.data count];
 }
 
 //每个元素的view
 -(UIView*)cellForItemAtIndex:(int)index{
 Template *info = [self.data objectAtIndex:index];
 imgView* webbg2 = [[imgView alloc] initWithFrame:CGRectMake(0, 0, rewiew.itemSize.width, rewiew.itemSize.height)];
 [webbg2 changeWithImageName:@""];
 //    NSString *fileaddres =  info.nefthumburl;
 //    NSString *imgname = [NSString stringWithFormat:@"dd%d.png",index];
 NSString *nefmbbg = info.nefmbbg;
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
 UIImage *img = [[UIImage alloc]initWithContentsOfFile:nefmbbg];
 webbg2.img.image = img;
 
 //    [webbg2.img setImageWithURL:[NSURL URLWithString:fileaddres] placeholderImage:[UIImage imageNamed:imgname]];
 return webbg2;
 }
 
 //选中事件
 -(void)didSelectItemAtIndex:(int)index{
 [self showImgView:index];
 }
*/