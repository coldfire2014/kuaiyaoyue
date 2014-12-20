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
-(void)reloadOther;
-(void)showList;
-(int)getIndex;
-(void)left;
-(void)right;
@end