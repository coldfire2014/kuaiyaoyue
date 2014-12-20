//
//  ShowData.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/20.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDDelegate;

@interface ShowData : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
- (IBAction)sure_picker:(id)sender;
- (IBAction)qx_picker:(id)sender;
@property (nonatomic, weak) id<SDDelegate> delegate;

@end
@protocol SDDelegate <NSObject>

- (void)SDDelegate:(ShowData *)cell didTapAtIndex:(NSString *) timebh;

@end