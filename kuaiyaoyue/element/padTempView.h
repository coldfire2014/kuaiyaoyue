//
//  padTempView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/3/14.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol padTempViewDelegate <NSObject>

-(NSInteger)numberOfItems;
-(UIView*)cellForItemAtIndex:(NSInteger)index;
-(void)didShowItemAtIndex:(NSInteger)index;

@end

@interface padTempView : UIView
{
    NSInteger itemCount;
    NSInteger currentItemIndex;
    double numberOfVisibleItems;
    
    double itemHeight;
    
    double perspective;
    double panTotal;
    CGPoint previousTranslation;
    CGPoint firstTranslation;
    double yt;
}
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIImage* image;
@property(nonatomic, weak) id<padTempViewDelegate> delegate;
-(void)reloadViews;
-(void)reloadOther;
-(void)showListAtIndex:(NSInteger)index;
-(NSInteger)getIndex;
-(void)left;
-(void)right;
@end
