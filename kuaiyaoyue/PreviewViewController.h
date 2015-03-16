//
//  PreviewViewController.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeTempView.h"
@protocol PreviewViewControllerDelegate <NSObject>

-(void)didSelectID:(NSString*)index andNefmbdw:(NSString*)nefmbdw;
-(void)didSendType:(int) type;
@optional
-(UIImage *)getimg :(NSString *) str andIndex:(NSString*) index;
@end
@interface PreviewViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate,ChangeTempViewDelegate,UIActionSheetDelegate>
{
    ChangeTempView* tempView;
}
@property (nonatomic) BOOL showTemp;
@property (strong, nonatomic) UIWebView *webview;
@property int type;
@property (nonatomic, strong) NSString* unquieId;
@property (nonatomic, weak) id<PreviewViewControllerDelegate> delegate;
@end
