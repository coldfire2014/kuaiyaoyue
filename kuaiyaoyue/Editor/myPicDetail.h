//
//  myPicDetail.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/3/8.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myPicDetailtDelegate <NSObject>
-(NSInteger)showNextPic:(NSInteger)tag withLeft:(BOOL)isLeft;
-(UIImage*)getPic:(NSInteger)tag;
@end
@interface myPicDetail : UIView
{
    NSInteger imgTag;
    UIImageView* picView;
    UIImageView* bkView;
    CGRect maxRect;
}
@property(nonatomic, weak) id<myPicDetailtDelegate> delegate;

-(void) setDetail:(NSInteger)tag withImg:(UIImage*)img;
@end
