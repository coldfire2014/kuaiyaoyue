//
//  WebNavBar.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/1/10.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebNavBar : UIView
-(void)reflashShow:(BOOL)isShow;
-(void)closeShow:(BOOL)isShow;
-(void)setTitle:(NSString*)title;
@end
