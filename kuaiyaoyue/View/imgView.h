//
//  imgView.h
//  edittext
//
//  Created by wu yangbing on 14-7-21.
//  Copyright (c) 2014年 wu yangbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myImageView.h"
@interface imgView : UIView
-(void)changeWithImageName:(NSString*)imageToLoad;
@property (strong) myImageView* img;
@end
