//
//  ctView.h
//  edittext
//
//  Created by wu yangbing on 14-7-21.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ctViewDelegate <NSObject>

-(NSInteger)numberOfItems;
-(UIView*)cellForItemAtIndex:(NSInteger)index;
-(void)didSelectItemAtIndex:(NSInteger)index;
-(void)didShowItemAtIndex:(NSInteger)index;

@end
@interface ctView : UIView
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
@property(nonatomic, weak) id<ctViewDelegate> delegate;
-(void)reloadViews;
-(void)reloadOther;
-(void)showList;
-(NSInteger)getIndex;
-(void)left;
-(void)right;
@end