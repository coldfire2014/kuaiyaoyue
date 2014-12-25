//
//  ChangeTempView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/25.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Template.h"
@protocol ChangeTempViewDelegate <NSObject>

-(void)didSelectTemplate:(Template*)items;

@end

@interface ChangeTempView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray* data;
}
@property  int type;
@property (nonatomic,weak) id<ChangeTempViewDelegate> delegate;
-(void)loadDate;
@end
