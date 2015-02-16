//
//  tapeView.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/16.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myImageView.h"
@interface tapeView : UIView{
    myImageView* recordBtn;
    myImageView* playBk;
    myImageView* removeBtn;
    UILabel* tapLbl;
}
@property (nonatomic ,strong) NSString* fileName;

@end
