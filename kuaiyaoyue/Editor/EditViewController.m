//
//  EditViewController.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/11.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "EditViewController.h"
#import "PCHeader.h"
#import "ipadbg.h"
#import "myImageView.h"
#import "ipadTabItem.h"
#import "MusicViewController.h"
#import "PECropViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ImgCollectionViewController.h"
#import "DatetimeInput.h"
#import "FileManage.h"
#import "DataBaseManage.h"
#import "NSInfoImg.h"
#import "Info.h"
#import "Fixeds.h"
#import "UDObject.h"
#import "HttpManage.h"
#import "StatusBar.h"
#import "PreviewViewController.h"
#import "TalkingData.h"
#import "waitingView.h"
#import "ZipDown.h"
#import "myPicItem.h"
@interface EditViewController ()

@end

@implementation EditViewController
-(void)initDate{
    uploadFiles = [[NSMutableArray alloc] init];
    timeDouble = -1;
    endtimeDouble = -1;
    isEndTime = NO;
    musicURL = @"";
    tipCount = 70;
    isHead = NO;
    imageCount = 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    assert = ASSETHELPER;
    assert.bReverse = YES;
    [self initDate];
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        mainScreenFrame = IPAD_FRAME;
        ipadbg* allbg = [[ipadbg alloc] init];
        [self.view addSubview:allbg];
        UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 66.0, mainScreenFrame.size.height)];
        tabView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tabView];
        
        ipadTabItem* sendBtn = [[ipadTabItem alloc] initWithFrame:CGRectMake(0.0, tabView.frame.size.height - 160.0, tabView.frame.size.width, 44.0) andIconfile:@"ic_38_send@2x" andName:@"分享"];
        UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendTap)];
        [sendBtn addGestureRecognizer:tap4 ];
        sendBtn.tag = 201;
        [tabView addSubview:sendBtn];
        
        ipadTabItem* saveBtn = [[ipadTabItem alloc] initWithFrame:CGRectMake(0.0, tabView.frame.size.height - 160.0+50, tabView.frame.size.width, 44.0) andIconfile:@"ic_38_save@2x" andName:@"保存"];
        saveBtn.tag = 202;
        UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveTap)];
        [saveBtn addGestureRecognizer:tap3 ];
        [tabView addSubview:saveBtn];
        
        ipadTabItem* reviewBtn = [[ipadTabItem alloc] initWithFrame:CGRectMake(0.0, tabView.frame.size.height - 160.0+100, tabView.frame.size.width, 44.0) andIconfile:@"ic_38_view" andName:@"预览"];
        reviewBtn.tag = 203;
        UITapGestureRecognizer* tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reviewTap)];
        [reviewBtn addGestureRecognizer:tap5 ];
        [tabView addSubview:reviewBtn];
        
        ipadTabItem* closeBtn = [[ipadTabItem alloc] initWithFrame:CGRectMake(0.0, 40.0, tabView.frame.size.width, 44.0) andIconfile:@"ic_54_x@2x" andName:@"取消"];
        closeBtn.tag = 204;
        UITapGestureRecognizer* tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap)];
        [closeBtn addGestureRecognizer:tap6 ];
        [tabView addSubview:closeBtn];
        
        UIView* editItemList = [[UIView alloc] initWithFrame:CGRectMake(67.0, 21.0, 400, mainScreenFrame.size.height-20.0)];
        editItemList.backgroundColor = [[UIColor alloc] initWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        editItemList.tag = 121;
        editItemList.clipsToBounds = YES;
        [self.view addSubview:editItemList];
        UIScrollView* showBg = [[UIScrollView alloc] initWithFrame:CGRectMake(467.0, 21.0, mainScreenFrame.size.width-467.0, mainScreenFrame.size.height-20.0)];
        showBg.backgroundColor = [UIColor clearColor];
        [showBg setContentSize:CGSizeMake(mainScreenFrame.size.width-467.0, mainScreenFrame.size.height-20.0)];
        showBg.tag = 141;
        showBg.showsHorizontalScrollIndicator = NO;
        showBg.showsVerticalScrollIndicator = NO;
        [self.view addSubview:showBg];
        
    }else{
        UIView* mainbk = [[UIView alloc] initWithFrame:CGRectMake(0, 64.0, mainScreenFrame.size.width, mainScreenFrame.size.height - 44.0 - 64.0)];
        //
        mainbk.tag = 121;
        mainbk.backgroundColor = [[UIColor alloc] initWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        [self.view addSubview:mainbk];
        
        UIView* topbk = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, mainScreenFrame.size.width, 64.0)];
        topbk.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
        topbk.tag = 101;
        [self.view addSubview:topbk];
        
        UILabel* lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, mainScreenFrame.size.width, 44.0)];
        lbl_title.font = [UIFont systemFontOfSize:20];
        lbl_title.text = @"编辑";
        lbl_title.textAlignment = NSTextAlignmentCenter;
        lbl_title.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [topbk addSubview:lbl_title];
        
        myImageView* btnLeft = [[myImageView alloc] initWithFrame:CGRectMake(8.0, 20.0, 44.0, 44.0) andImageName:@"T" withScale:2.0 andBundleName:@"imgBar"];
        btnLeft.tag = 102;
        [topbk addSubview:btnLeft];
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap)];
        [btnLeft addGestureRecognizer:tap1 ];
        UILabel* lbl_OK = [[UILabel alloc] initWithFrame:btnLeft.bounds];
        lbl_OK.font = [UIFont systemFontOfSize:18];
        lbl_OK.text = @"返回";
        lbl_OK.textAlignment = NSTextAlignmentCenter;
        lbl_OK.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnLeft addSubview:lbl_OK];
        
        myImageView* btnRight = [[myImageView alloc] initWithFrame:CGRectMake(mainScreenFrame.size.width-44.0-8.0, 20.0, 44.0, 44.0) andImageName:@"T" withScale:2.0 andBundleName:@"imgBar"];
        btnRight.tag = 103;
        [topbk addSubview:btnRight];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reviewTap)];
        [btnRight addGestureRecognizer:tap2 ];
        UILabel* lbl_OKr = [[UILabel alloc] initWithFrame:btnRight.bounds];
        lbl_OKr.tag = 106;
        lbl_OKr.font = [UIFont systemFontOfSize:18];
        lbl_OKr.text = @"预览";
        lbl_OKr.textAlignment = NSTextAlignmentCenter;
        lbl_OKr.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [btnRight addSubview:lbl_OKr];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, topbk.frame.size.height-0.5, topbk.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
        [topbk addSubview:line];
        
        UIView* bottombk = [[UIView alloc] initWithFrame:CGRectMake(0.0, mainScreenFrame.size.height-44.0, mainScreenFrame.size.width, 44.0)];
        bottombk.backgroundColor = [UIColor colorWithWhite:1 alpha:0.95];
        bottombk.tag = 111;
        [self.view addSubview:bottombk];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenFrame.size.width, 0.5)];
        line2.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [bottombk addSubview:line2];
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(mainScreenFrame.size.width/2.0-0.5, 6.0, 1.0, 32.0)];
        line3.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [bottombk addSubview:line3];
        
        UIView* sendBtn = [[UIView alloc] initWithFrame:CGRectMake(mainScreenFrame.size.width/2.0, 0, mainScreenFrame.size.width/2.0, bottombk.frame.size.height)];
        sendBtn.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendTap)];
        [sendBtn addGestureRecognizer:tap4 ];
        sendBtn.backgroundColor = [UIColor clearColor];
        
        myImageView* btnSend = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 88.0/4.0-38.0/4.0, 38.0/2.0, 38.0/2.0) andImageName:@"ic_38_send@2x" withScale:2.0];
        UIView* sendc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38.0/2.0+88.0/2.0, sendBtn.frame.size.height)];
        sendc.center = CGPointMake(sendBtn.frame.size.width/2.0, sendBtn.frame.size.height/2.0);
        [sendBtn addSubview:sendc];
        UILabel* lbl_s = [[UILabel alloc] initWithFrame:CGRectMake(38.0/2.0, 0.0, 88.0/2.0, 88.0/2.0)];
        lbl_s.font = [UIFont systemFontOfSize:15];
        lbl_s.text = @"分享";
        lbl_s.textAlignment = NSTextAlignmentCenter;
        lbl_s.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [sendc addSubview:lbl_s];
        [sendc addSubview:btnSend];
        
        [bottombk addSubview:sendBtn];
        UIView* saveBtn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenFrame.size.width/2.0, bottombk.frame.size.height)];
        saveBtn.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saveTap)];
        [saveBtn addGestureRecognizer:tap3 ];
        
        myImageView* btnSave = [[myImageView alloc] initWithFrame:CGRectMake(0.0, 88.0/4.0-38.0/4.0, 38.0/2.0, 38.0/2.0) andImageName:@"ic_38_save@2x" withScale:2.0];
        UIView* savec = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38.0/2.0+88.0/2.0, saveBtn.frame.size.height)];
        savec.center = CGPointMake(saveBtn.frame.size.width/2.0, saveBtn.frame.size.height/2.0);
        [saveBtn addSubview:savec];
        UILabel* lbl_sa = [[UILabel alloc] initWithFrame:CGRectMake(38.0/2.0, 0.0, 88.0/2.0, 88.0/2.0)];
        lbl_sa.font = [UIFont systemFontOfSize:15];
        lbl_sa.text = @"保存";
        lbl_sa.textAlignment = NSTextAlignmentCenter;
        lbl_sa.textColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        [savec addSubview:lbl_sa];
        [savec addSubview:btnSave];
        
        [bottombk addSubview:saveBtn];
    }
    [self setEditList];
    [self initPreView];
    [self initOldInput];
}

-(void)addItemBg2View:(UIView*)view WithType:(int)type andTap:(NSInteger)tap andIcon:(NSString*)iconname{
    view.tag = tap;
    view.backgroundColor = [UIColor whiteColor];
    myImageView* icon = [[myImageView alloc] initWithFrame:CGRectMake(18.0/2.0, (86.0-48.0)/4.0, 48.0/2.0, 48.0/2.0) andImageName:iconname withScale:2.0];
    [view addSubview:icon];
    if (type == 1) {//全有
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [view addSubview:line];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-0.5, view.frame.size.width, 0.5)];
        line2.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [view addSubview:line2];
    } else if (type == 2) {//上半
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [view addSubview:line];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(9.0, view.frame.size.height-0.5, view.frame.size.width-18.0, 0.5)];
        line2.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [view addSubview:line2];
    } else if (type == 3) {//中
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(9.0, view.frame.size.height-0.5, view.frame.size.width-18.0, 0.5)];
        line2.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [view addSubview:line2];
    } else if (type == 4) {//下半
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, view.frame.size.height-0.5, view.frame.size.width, 0.5)];
        line2.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        [view addSubview:line2];
    }
    [self.editListView addSubview:view];
}
-(void)resetInput:(UITextField*)lbl andTitle:(NSString*)title andPlaceholder:(NSString*)placeholder{
    lbl.borderStyle = UITextBorderStyleNone;
    lbl.placeholder = placeholder;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.delegate = self;
    lbl.leftViewMode = UITextFieldViewModeAlways;
    UILabel* manTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0, lbl.bounds.size.width, 86.0/2.0)];
    manTitle.font = [UIFont systemFontOfSize:14];
    manTitle.backgroundColor = [UIColor clearColor];
    manTitle.text=title;
    [manTitle sizeToFit];
    manTitle.frame = CGRectMake(0.0, 0, manTitle.bounds.size.width, 86.0/2.0);
    lbl.leftView = manTitle;
}
-(void)setEditList{
    tipCount = -1;
    UIView* editItemList = [self.view viewWithTag: 121];
    CGRect r = editItemList.frame;
    CGFloat w = r.size.width;
    CGFloat h = r.size.height;
    CGFloat iconWidth = 18.0/2.0+48.0/2.0+12.0/2.0;
    self.editListView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    self.editListView.backgroundColor = [UIColor clearColor];
    [editItemList addSubview:self.editListView];
    CGFloat ch = 36.0/2.0;
    int nextType = 1;
    imageMax = 9;
    if([self.typeid compare:@"4"] == NSOrderedSame) {//自定义
        imageMax = 15;
        UIView* headview = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 120.0/2.0+12.0)];
        [self addItemBg2View:headview WithType:2 andTap:221 andIcon:@"ic_c_pics@2x"];
        ch += 120.0/2.0+12.0;
        UILabel* andn = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 0, w, 86.0/2.0)];
        andn.font = [UIFont systemFontOfSize:14];
        andn.backgroundColor = [UIColor clearColor];
        andn.text=@"封面图片";
        [headview addSubview:andn];
        UILabel* tip = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 66.0/2.0, w, 66.0/2.0)];
        tip.font = [UIFont systemFontOfSize:12];
        tip.backgroundColor = [UIColor clearColor];
        tip.textColor = [UIColor grayColor];
        tip.numberOfLines = 2;
        tip.text=@"--- 封面图片将与标题和导读一起出现在\n\x20\x20\x20\x20\x20分享快照中。";
        [headview addSubview:tip];
        headImg = [[HeadImgView alloc] init];
        headImg.center = CGPointMake(w-120.0/4.0-12.0/2.0, 120.0/4.0+12.0/2.0);
        [headview addSubview:headImg];
        UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headInput)];
        [headImg addGestureRecognizer:tap4];
        nextType = 3;
    }else{
        nextType = 2;
    }
    UIView* titleview = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0)];
    if ([self.typeid compare:@"1"] == NSOrderedSame) {
        [self addItemBg2View:titleview WithType:1 andTap:222 andIcon:@"ic_c_man@2x"];
        ch += 24.0/2.0;
        manInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w/2.0-18.0/2.0-48.0/2.0 -12.0/2.0, 86.0/2.0)];
        [self resetInput:manInput andTitle:@"新郎:" andPlaceholder:@"新郎姓名"];
        manInput.clearButtonMode = UITextFieldViewModeNever;
        manInput.returnKeyType = UIReturnKeyNext;
        [titleview addSubview:manInput];
        UILabel* andn = [[UILabel alloc] initWithFrame:CGRectMake(manInput.frame.origin.x+manInput.frame.size.width-3.0, 0, 15, 86.0/2.0)];
        andn.font = [UIFont systemFontOfSize:14];
        andn.backgroundColor = [UIColor clearColor];
        andn.text=@"&";
        [titleview addSubview:andn];
        myImageView* icon = [[myImageView alloc] initWithFrame:CGRectMake(andn.frame.origin.x+andn.frame.size.width, (86.0-48.0)/4.0, 48.0/2.0, 48.0/2.0) andImageName:@"ic_c_lady@2x" withScale:2.0];
        [titleview addSubview:icon];
        wemanInput = [[UITextField alloc] initWithFrame:CGRectMake(icon.frame.origin.x+icon.frame.size.width +12.0/2.0, 0, w/2.0-18.0/2.0-48.0/2.0 -12.0/2.0, 86.0/2.0)];
        [self resetInput:wemanInput andTitle:@"新娘:" andPlaceholder:@"新娘姓名"];
        wemanInput.clearButtonMode = UITextFieldViewModeNever;
        wemanInput.returnKeyType = UIReturnKeyDone;
        [titleview addSubview:wemanInput];
    } else {
        [self addItemBg2View:titleview WithType:nextType andTap:222 andIcon:@"ic_c_meeting@2x"];
        titleInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w-iconWidth, 86.0/2.0)];
        if (nextType == 3) {
            [self resetInput:titleInput andTitle:@"标题: " andPlaceholder:@"请输入标题，请不要超过11个字。"];
        } else {
            [self resetInput:titleInput andTitle:@"活动名称: " andPlaceholder:@"请输入名称，请不要超过11个字。"];
        }
        titleInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        titleInput.returnKeyType = UIReturnKeyNext;
        [titleview addSubview:titleInput];
    }
    ch += 86.0/2.0;
    if ([self.typeid compare:@"1"] != NSOrderedSame) {
        UIView* tipView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 80.0+12.0)];
        [self addItemBg2View:tipView WithType:4 andTap:223 andIcon:@"ic_c_tips@2x"];
        ch += 92.0+12.0;
        UILabel* andn = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 0, w, 86.0/2.0)];
        andn.font = [UIFont systemFontOfSize:14];
        andn.backgroundColor = [UIColor clearColor];
        if([self.typeid compare:@"2"] == NSOrderedSame) {//商务
            andn.text=@"活动简介: ";
            tipCount = 70;
        }else if([self.typeid compare:@"3"] == NSOrderedSame) {//玩乐
            andn.text=@"温馨提示: ";
            tipCount = 70;
        }else if([self.typeid compare:@"4"] == NSOrderedSame) {//自定义
            andn.text=@"封面导读: ";
            tipCount = 40;
            UILabel* tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 110.0/2.0, 90.0, 29.0)];
            tipLbl.font = [UIFont systemFontOfSize:10];
            tipLbl.backgroundColor = [UIColor clearColor];
            tipLbl.textColor = [UIColor redColor];
            tipLbl.layer.cornerRadius = 3.0;
            tipLbl.text=@"注:若导读含有换行可能影响完整显示。";
            tipLbl.numberOfLines = 2;
            [tipView addSubview:tipLbl];
        }
        [tipView addSubview:andn];
        tipCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 66.0/2.0, 82, 46.0/2.0)];
        tipCountLbl.font = [UIFont systemFontOfSize:10];
        tipCountLbl.backgroundColor = [UIColor clearColor];
        tipCountLbl.textColor = [UIColor grayColor];
        tipCountLbl.textAlignment = NSTextAlignmentRight;
        tipCountLbl.numberOfLines = 1;
        tipCountLbl.text=[[NSString alloc] initWithFormat:@"剩余%d个字",tipCount];
        [tipView addSubview:tipCountLbl];
        
        tipInput = [[UITextView alloc] initWithFrame:CGRectMake(100.0, 6.0, w-106.0, 80.0)];
        tipInput.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        tipInput.font = [UIFont systemFontOfSize:13];
        tipInput.delegate = self;
        tipInput.text=@"";
        [tipView addSubview:tipInput];
        
        UIView* hideEmi = [[UIView alloc] initWithFrame:CGRectMake(5.0, 110.0/2.0, 90.0, 29.0)];
        hideEmi.tag = 510;
        hideEmi.layer.cornerRadius = 3.0;
        hideEmi.alpha = 0.0;
        UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emiHide)];
        [hideEmi addGestureRecognizer:tap4];
        [tipView addSubview:hideEmi];
        UILabel* hideLbl = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 3.0, 86.0, 23.0)];
        hideLbl.font = [UIFont systemFontOfSize:13];
        hideEmi.backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        hideLbl.backgroundColor = [UIColor clearColor];
        hideLbl.textColor = [UIColor whiteColor];
        hideLbl.layer.cornerRadius = 3.0;
        hideLbl.text=@" 点我隐藏键盘";
        hideLbl.tag = 510;
        [hideEmi addSubview:hideLbl];
    }
    if ([self.typeid compare:@"5"] == NSOrderedSame) {//
//    if ([self.typeid compare:@"4"] == NSOrderedSame) {
        UIView* applyView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 23.0)];
        [self addItemBg2View:applyView WithType:1 andTap:444 andIcon:@""];
        UILabel* andn = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 0, w, 23.0)];
        andn.font = [UIFont systemFontOfSize:13];
        andn.backgroundColor = [UIColor clearColor];
        andn.text=@"需要报名信息";
        [applyView addSubview:andn];
        UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyHide)];
        [applyView addGestureRecognizer:tap4];
        ch += 22.0;
        applyTop = ch;
        UIView *getView = [[UIView alloc] initWithFrame:CGRectMake(8.0, 4.0, 16.0, 16.0)];
        getView.tag = 501;
        getView.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:1.0];
        getView.layer.borderColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0].CGColor;
        getView.layer.borderWidth = 1.5;
        getView.layer.cornerRadius = 5.0;
        UIView *getLab = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16.0, 16.0)];
        getLab.tag = 502;
        getLab.backgroundColor = [UIColor clearColor];
        CGFloat gw = 30.0;
        UIView *gx = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gw/4.0, 2.0)];
        gx.backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        gx.center = CGPointMake(0.5*gw + 0.5, 0.5*gw - 0.5);
        gx.layer.transform = CATransform3DTranslate(gx.layer.transform, -gw/4.0, 1.0, 0);
        gx.layer.transform = CATransform3DRotate(gx.layer.transform, M_PI_2, 0, 0, 1);
        [getLab addSubview:gx];
        
        UIView *gs = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gw/1.7 - 2.0, 2.0)];
        gs.backgroundColor = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1.0];
        gs.center = CGPointMake(0.5*gw + 0.7, 0.5*gw - 0.5);
        gs.layer.transform = CATransform3DTranslate(gs.layer.transform, 0.0, gw/8.0, 0);
        [getLab addSubview:gs];
        getLab.layer.transform = CATransform3DRotate(getLab.layer.transform, -M_PI_4, 0, 0, 1);
        getLab.layer.transform = CATransform3DTranslate(getLab.layer.transform, -2.0, -9.0, 0);
        
        [getView addSubview:getLab];
        [applyView addSubview: getView];
    }
    
    UIView* timeView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0)];
    [self addItemBg2View:timeView WithType:2 andTap:224 andIcon:@"ic_c_clock@2x"];
    timeInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w-iconWidth, 86.0/2.0)];
    if([self.typeid compare:@"1"] == NSOrderedSame) {//婚礼
        [self resetInput:timeInput andTitle:@"婚礼时间: " andPlaceholder:@"请点击选择时间。"];
    }else {//其它
        [self resetInput:timeInput andTitle:@"活动时间: " andPlaceholder:@"请点击选择时间。"];
    }
    timeInput.clearButtonMode = UITextFieldViewModeAlways;
//    timeInput.text = @"2015-02-20 11:14";
    [timeView addSubview:timeInput];
    
    ch += 86.0/2.0;
    if ([self.typeid compare:@"4"] != NSOrderedSame) {
        UIView* locationView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0)];
        [self addItemBg2View:locationView WithType:3 andTap:225 andIcon:@"ic_c_location@2x"];
        ch += 86.0/2.0;
        locInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w-iconWidth, 86.0/2.0)];
        [self resetInput:locInput andTitle:@"地点: " andPlaceholder:@"请输入详细地址，便于地图定位。"];
        locInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        locInput.returnKeyType = UIReturnKeyDone;
        [locationView addSubview:locInput];
    }
    UIView* endtimeView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0)];
    [self addItemBg2View:endtimeView WithType:4 andTap:226 andIcon:@"ic_c_timer@2x"];
    endtimeInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w-iconWidth, 86.0/2.0)];
    [self resetInput:endtimeInput andTitle:@"报名截止时间: " andPlaceholder:@"请点击选择时间。"];
    endtimeInput.clearButtonMode = UITextFieldViewModeAlways;
//    endtimeInput.text = @"2015-02-20 11:14";
    [endtimeView addSubview:endtimeInput];

    ch += 110.0/2.0;
    applyHeight = ch - applyTop - 12.0;//markwyb
    if ([self.typeid compare:@"2"] == NSOrderedSame || [self.typeid compare:@"3"] == NSOrderedSame) {
        UIView* contactmanView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0)];
        [self addItemBg2View:contactmanView WithType:2 andTap:227 andIcon:@"ic_c_name@2x"];
        ch += 86.0/2.0;
        contactmanInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w-iconWidth, 86.0/2.0)];
        [self resetInput:contactmanInput andTitle:@"联系人: " andPlaceholder:@"填写联系人，方便大家联系。"];
        contactmanInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        contactmanInput.returnKeyType = UIReturnKeyNext;
        [contactmanView addSubview:contactmanInput];
        UIView* contactView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0)];
        [self addItemBg2View:contactView WithType:4 andTap:228 andIcon:@"ic_c_contact@2x"];
        ch += 110.0/2.0;
        contactInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w-iconWidth, 86.0/2.0)];
        [self resetInput:contactInput andTitle:@"联系方式: " andPlaceholder:@"填写联系方式，方便大家联系。"];
        contactInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        contactInput.returnKeyType = UIReturnKeyDone;
        [contactView addSubview:contactInput];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIView* picsView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0+165.0+6.0)];
        [self addItemBg2View:picsView WithType:1 andTap:229 andIcon:@"ic_c_pics@2x"];
        UILabel* andn = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 0, w, 86.0/2.0)];
        andn.font = [UIFont systemFontOfSize:14];
        andn.backgroundColor = [UIColor clearColor];
        andn.text=@"页面预览与编辑";
        [picsView addSubview:andn];
        UILabel* ande = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 13, w, 86.0/2.0)];
        ande.font = [UIFont systemFontOfSize:8];
        ande.textColor = [UIColor redColor];
        ande.backgroundColor = [UIColor clearColor];
        ande.text=@"为保证制作效果，建议使用竖版图片。";
        UILabel* andt = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth + 100, 2, w, 86.0/2.0)];
        andt.font = [UIFont systemFontOfSize:11];
        andt.textColor = [UIColor redColor];
        andt.backgroundColor = [UIColor clearColor];
        andt.text=@"（可添加最多9张图片。）";
        if ([self.typeid compare:@"4"] == NSOrderedSame) {
            andt.text=@"（可添加最多15张图片。）";
        }
        [picsView addSubview:ande];
        [picsView addSubview:andt];
        ch += 86.0/2.0+165.0+6.0+12.0;
        UIScrollView* showBg = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 86.0/2.0, w, 166.0)];
        showBg.backgroundColor = [UIColor clearColor];
        [showBg setContentSize:CGSizeMake(w, 166.0)];
        showBg.tag = 141;
        showBg.showsHorizontalScrollIndicator = NO;
        showBg.showsVerticalScrollIndicator = NO;
        [picsView addSubview:showBg];
    }
    UIView* musicView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0)];
    [self addItemBg2View:musicView WithType:2 andTap:230 andIcon:@"ic_c_music@2x"];
    ch += 86.0/2.0;
    musicInput = [[UITextField alloc] initWithFrame:CGRectMake(iconWidth, 0, w-iconWidth, 86.0/2.0)];
    [self resetInput:musicInput andTitle:@"背景音乐: " andPlaceholder:@"请点击选择音乐。"];
    musicInput.clearButtonMode = UITextFieldViewModeAlways;
    UILabel* musicTip = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 86.0/2.0-16.0, w, 16.0)];
    musicTip.font = [UIFont systemFontOfSize:9];
    musicTip.backgroundColor = [UIColor clearColor];
    musicTip.textColor = [UIColor redColor];
    musicTip.text=@"注：背景音乐与录音只能选择一个";
    [musicView addSubview:musicTip];
    [musicView addSubview:musicInput];
    UIView* recordingView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 310.0/2.0)];
    [self addItemBg2View:recordingView WithType:4 andTap:231 andIcon:@"ic_c_recording@2x"];
    ch += 310.0/2.0;
    UILabel* recordingTitle = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 0, w, 86.0/2.0)];
    recordingTitle.font = [UIFont systemFontOfSize:14];
    recordingTitle.backgroundColor = [UIColor clearColor];
    recordingTitle.text=@"录音";
    [recordingView addSubview:recordingTitle];
    recordedInput = [[tapeView alloc] initWithFrame:CGRectMake(0, 0, w, 310.0/2.0)];
    [recordingView addSubview:recordedInput];
    ch+=36.0/2.0;
    [self.editListView setContentSize:CGSizeMake(w, ch)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.typeid compare:@"1"] == NSOrderedSame) {//婚礼
        [TalkingData trackPageEnd:@"婚礼编辑"];
    }else if([self.typeid compare:@"2"] == NSOrderedSame) {//商务
        [TalkingData trackPageEnd:@"商务编辑"];
    }else if([self.typeid compare:@"3"] == NSOrderedSame) {//玩乐
        [TalkingData trackPageEnd:@"吃喝玩乐编辑"];
    }else if([self.typeid compare:@"4"] == NSOrderedSame) {//自定义
        [TalkingData trackPageEnd:@"自定义编辑"];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.typeid compare:@"1"] == NSOrderedSame) {//婚礼
        [TalkingData trackPageBegin:@"婚礼编辑"];
    }else if([self.typeid compare:@"2"] == NSOrderedSame) {//商务
        [TalkingData trackPageBegin:@"商务编辑"];
    }else if([self.typeid compare:@"3"] == NSOrderedSame) {//玩乐
        [TalkingData trackPageBegin:@"吃喝玩乐编辑"];
    }else if([self.typeid compare:@"4"] == NSOrderedSame) {//自定义
        [TalkingData trackPageBegin:@"自定义编辑"];
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_REMOVE_ME" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_ADD_ME" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_SHOW_ME" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_REMOVE_FILE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_ADD_FILE" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowNotify:) name:UIKeyboardDidShowNotification object:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeImage:) name:@"MSG_REMOVE_ME" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addaImage:) name:@"MSG_ADD_ME" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showImage:) name:@"MSG_SHOW_ME" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removefile4list:) name:@"MSG_REMOVE_FILE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addfile2list:) name:@"MSG_ADD_FILE" object:nil];
}
#pragma mark - UITapGesture
-(void)closeTap{
    if (nil != self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}
-(void)emiHide{
    [tipInput resignFirstResponder];
    UIView* getLab = [self.editListView viewWithTag:510];
    [UIView animateWithDuration:0.2 animations:^{
        getLab.alpha = 0;
    }];
}
-(void)applyHide{//是否需要报名
    UIView* getLab = [self.editListView viewWithTag:502];
    if (getLab.alpha == 0) {
        UIView* mark = [self.editListView viewWithTag:503];
        [UIView animateWithDuration:0.2 animations:^{
            getLab.alpha = 1;
            mark.alpha = 0;
        }];
    } else {
        UIView* mark = [self.editListView viewWithTag:503];
        if (nil == mark) {
            CGFloat w = self.editListView.frame.size.width;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                w=w-1.0;
            }
            UIView* mark = [[UIView alloc] initWithFrame:CGRectMake(0.0, applyTop, w, applyHeight)];
            mark.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
            mark.tag = 503;
            [self.editListView addSubview:mark];
        }
        [UIView animateWithDuration:0.2 animations:^{
            getLab.alpha = 0;
            mark.alpha = 1;
        }];
    }
}

-(void)headInput{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (headImg.img != nil) {
            UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"修改头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"修改这张" otherButtonTitles:@"从相册选取",@"照一张", nil ];
            as.tag = 999;
            [as showInView:self.view];
        } else {
            UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"选择头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"照一张", nil ];
            as.tag = 998;
            [as showInView:self.view];
        }
    } else {
        if (headImg.img != nil) {
            UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"修改头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"修改这张" otherButtonTitles:@"从相册选取",@"照一张", nil ];
            as.tag = 999;
            [as showFromRect:CGRectMake(30, 60, 0, 0) inView:headImg animated:YES];
        } else {
            UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"选择一张头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"照一张", nil ];
            as.tag = 998;
            [as showFromRect:CGRectMake(30, 60, 0, 0) inView:headImg animated:YES];
        }
    }
}
#pragma mark - 选择头图
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ((actionSheet.tag == 998 && buttonIndex == 0) || (actionSheet.tag == 999 && buttonIndex == 1)) {
            isHead = YES;
            UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            flowLayout.minimumInteritemSpacing = 0.0;
            ImgCollectionViewController* des = [[ImgCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
            des.maxCount = 1;
            des.needAnimation = NO;
            des.delegate = self;
            des.modalPresentationStyle = UIModalPresentationFormSheet;
            des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:des animated:YES completion:^{
                
            }];
        }else if(actionSheet.tag == 999 && buttonIndex == 0){
            [self SendPECropView:headImg.img];
        }else if ((actionSheet.tag == 998 && buttonIndex == 1) || (actionSheet.tag == 999 && buttonIndex == 2)){
            UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imgPicker setDelegate:self];
            [imgPicker setAllowsEditing:NO];
            [self presentViewController:imgPicker animated:YES completion:^{
                
            }];
        }
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 998) {
        switch (buttonIndex) {
            case 0:
            {
                UIImagePickerController *galleryPickerController = [[UIImagePickerController alloc] init];
                galleryPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                galleryPickerController.delegate = self;
                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    if ([actionSheet isVisible]) {
                        [actionSheet dismissWithClickedButtonIndex:0 animated:NO];
                        
                    }
                }else{
                    [self presentViewController:galleryPickerController animated:YES completion:nil];
                }
            }
                break;
            case 1:
            {
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    if ([actionSheet isVisible]) {
                        [actionSheet dismissWithClickedButtonIndex:1 animated:NO];
                        
                    }
                }else{
                    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
                    [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [imgPicker setDelegate:self];
                    [imgPicker setAllowsEditing:NO];
                    [self presentViewController:imgPicker animated:YES completion:^{
                        
                    }];
                }
                break;
            }
            case 2:
                
                break;
            default:
                break;
        }
    } else {
        switch (buttonIndex) {
            case 0:
            {
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    if ([actionSheet isVisible]) {
                        [actionSheet dismissWithClickedButtonIndex:0 animated:NO];
                    }
                }else{
                    [self SendPECropView:headImg.img];
                }
            }
                break;
            case 1:
            {
                UIImagePickerController *galleryPickerController = [[UIImagePickerController alloc] init];
                galleryPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                galleryPickerController.delegate = self;
                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    if ([actionSheet isVisible]) {
                        [actionSheet dismissWithClickedButtonIndex:0 animated:NO];
                    }
                }else{
                    [self presentViewController:galleryPickerController animated:YES completion:nil];
                }
                
                break;
            }
            case 2:
            {
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    if ([actionSheet isVisible]) {
                        [actionSheet dismissWithClickedButtonIndex:2 animated:NO];
                    }
                }else{
                    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
                    [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [imgPicker setDelegate:self];
                    [imgPicker setAllowsEditing:NO];
                    [self presentViewController:imgPicker animated:YES completion:^{
                        
                    }];
                }
            }
                break;
            default:
                break;
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage  * userHeadImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //    UIImage *midImage = [self imageWithImageSimple:userHeadImage scaledToSize:CGSizeMake(120.0, 120.0)];
    [self dismissViewControllerAnimated:YES completion:^{
        headImg.img = userHeadImage;
        [self SendPECropView:userHeadImage];
    }];
}

-(void)SendPECropView :(UIImage *)image{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = image;
    //    [self.navigationController popToViewController:controller animated:YES];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    headImg.imgContext.image = croppedImage;
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark 图片／时间选择
- (void)MVCDelegate:(MusicViewController *)cell didTapAtIndex:(NSString *) url :(NSString *)name{
    musicURL = url;
    musicInput.text = name;
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:name,@"音乐名称", nil];
    if ([self.typeid compare:@"1"] == NSOrderedSame) {//婚礼
        [TalkingData trackEvent:@"音乐选择" label:@"婚礼" parameters: parameters];
    }else if([self.typeid compare:@"2"] == NSOrderedSame) {//商务
        [TalkingData trackEvent:@"音乐选择" label:@"商务" parameters: parameters];
    }else if([self.typeid compare:@"3"] == NSOrderedSame) {//玩乐
        [TalkingData trackEvent:@"音乐选择" label:@"吃喝玩乐" parameters: parameters];
    }else if([self.typeid compare:@"4"] == NSOrderedSame) {//自定义
        [TalkingData trackEvent:@"音乐选择" label:@"自定义" parameters: parameters];
    }
}

- (BOOL)didSelectDateTime:(NSTimeInterval)time{
    if (!isEndTime) {
        if (time == 0) {
            return NO;
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
        timeDouble = time;
        timeInput.text = [dateFormatter stringFromDate:date];
        [self drowImg];
        if (time < endtimeDouble || endtimeDouble < 0) {
            endtimeDouble = time;
            endtimeInput.text = [dateFormatter stringFromDate:date];
        }
        return YES;
    } else {
        if (time == 0) {
            return NO;
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
        if (time > timeDouble) {
            if ([self.typeid compare:@"1"] == NSOrderedSame) {
                [[StatusBar sharedStatusBar] talkMsg:@"报名截止时间不能大于婚礼时间" inTime:0.8];
            } else {
                [[StatusBar sharedStatusBar] talkMsg:@"报名截止时间不能大于活动时间" inTime:0.8];
            }
            return NO;
        }else{
            endtimeDouble = time;
            endtimeInput.text = [dateFormatter stringFromDate:date];
            return YES;
        }
    }
}
#pragma mark - keyboardNotify

-(void)keyboardShowNotify:(NSNotification*)aNotification{
    //获取触发事件对象
    NSDictionary* info = [aNotification userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    //将视图Y坐标进行移动，移动距离为弹出键盘的高度
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [contactInput isFirstResponder]) {
        if (keyboardRect.size.height>360) {
            self.editListView.frame = CGRectMake(0, -50, self.editListView.frame.size.width, self.editListView.frame.size.height);
        } else {
            self.editListView.frame = CGRectMake(0, 0, self.editListView.frame.size.width, self.editListView.frame.size.height);
        }
    }else{
        self.editListView.frame = CGRectMake(0, 0, self.editListView.frame.size.width, self.editListView.frame.size.height);
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self drowImg];
}
- (void)textViewDidChange:(UITextView *)textView{
    long max = 70;
    if ([self.typeid compare:@"4"] == NSOrderedSame) {
        max = 40;
    }
    long num = max - textView.text.length;
    tipCountLbl.text = [NSString stringWithFormat:@"剩余%ld字",num];
    if (num >= 0) {
        tipCountLbl.textColor = [UIColor grayColor];
    }else{
        tipCountLbl.textColor = [UIColor redColor];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    UIView* getLab = [self.editListView viewWithTag:510];
    [UIView animateWithDuration:0.2 animations:^{
        getLab.alpha = 1;
    }];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    } else {
        if (textField == manInput) {
            [wemanInput becomeFirstResponder];
        } else if (textField == titleInput) {
            [tipInput becomeFirstResponder];
        } else if (textField == contactmanInput) {
            [contactInput becomeFirstResponder];
        } else{
            
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self drowImg];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField == contactInput && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.editListView.frame = CGRectMake(0, 0, self.editListView.frame.size.width, self.editListView.frame.size.height);
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == timeInput || textField == endtimeInput || musicInput == textField) {
        [self.view endEditing:NO];
        if(textField == timeInput){
            isEndTime = NO;
            NSDate* itime = [NSDate date];
            if (timeDouble > 0) {
                itime = [NSDate dateWithTimeIntervalSince1970:timeDouble];
            }
            [[DatetimeInput sharedDatetimeInput] setTime:itime andMaxTime:nil andMinTime:[NSDate date]];
            [DatetimeInput sharedDatetimeInput].time_delegate = self;
            [[DatetimeInput sharedDatetimeInput] show];
        }else if (textField == endtimeInput){
            if (timeDouble > 0) {
                isEndTime = YES;
                NSDate * date=[NSDate dateWithTimeIntervalSince1970:timeDouble];
                NSDate* itime = date;
                if (endtimeDouble > 0) {
                    itime = [NSDate dateWithTimeIntervalSince1970:endtimeDouble];
                }
                [[DatetimeInput sharedDatetimeInput] setTime:itime andMaxTime:date andMinTime:[NSDate date]];
                [DatetimeInput sharedDatetimeInput].time_delegate = self;
                [[DatetimeInput sharedDatetimeInput] show];
            }else{
                if ([self.typeid compare:@"1"] == NSOrderedSame) {
                    [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入婚礼时间" inTime:0.8];
                } else {
                    [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入活动时间" inTime:0.8];
                }
            }
        }else if (musicInput == textField){
            MusicViewController *des = [[MusicViewController alloc] init];
            des.delegate = self;
            if ([self.typeid compare:@"3"] == NSOrderedSame) {
                des.typeid = @"4";
            } else if ([self.typeid compare:@"4"] == NSOrderedSame) {
                des.typeid = @"5";
            } else {
                des.typeid = self.typeid;
            }
            des.modalPresentationStyle = UIModalPresentationFormSheet;
            des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:des animated:YES completion:^{
                
            }];
        }
        return NO;
    } else if (textField == contactInput && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.editListView.frame = CGRectMake(0, -50, self.editListView.frame.size.width, self.editListView.frame.size.height);
    } else {
        return YES;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(textField == timeInput){
        timeDouble = -1;
        timeInput.text = @"";
        return YES;
    }else if (textField == endtimeInput){
        endtimeDouble = -1;
        endtimeInput.text = @"";
        return NO;
    }else if (musicInput == textField){
        musicURL = @"";
        musicInput.text = @"";
        return NO;
    }
    return YES;
}
#pragma mark - 图片处理
-(void)didBack{
    
}
-(void)addImgs{
    isHead = NO;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumInteritemSpacing = 0.0;
    ImgCollectionViewController* des = [[ImgCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    des.maxCount = imageMax - imageCount;
    des.needAnimation = NO;
    des.delegate = self;
    //        des.transitioningDelegate = self;
    //        des.modalPresentationStyle = UIModalPresentationCustom;
    des.modalPresentationStyle = UIModalPresentationFormSheet;
    des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:des animated:YES completion:^{
        
    }];
}
-(void)removefile4list:(NSNotification*)aNotification{
    NSString* info = [aNotification object];
    if ([uploadFiles containsObject:info]) {
        [uploadFiles removeObject:info];
    }
}
-(void)addfile2list:(NSNotification*)aNotification{
    NSString* info = [aNotification object];
    if (![uploadFiles containsObject:info]) {
        [uploadFiles addObject:info];
    }
}
-(void)hideDetail{
    UIView* view = [self.view viewWithTag:800];
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}
-(void)showImg:(NSInteger)tag{
    UIImage* img = [self getPic:tag];
    myPicDetail* show = [[myPicDetail alloc] initWithFrame:self.view.bounds];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDetail)];
    [show addGestureRecognizer:tap];
    show.delegate = self;
    [self.view addSubview:show];
    [show setDetail:tag withImg:img];
}
-(void)showHomePic{
    [self showImg:394];
}
-(void)showDraw{
    [self showImg:395];
}
-(UIImage*)getPic:(NSInteger)tag{
    UIImage* img = nil;
    if (tag == 395) {
        if ([self.typeid compare:@"1"] != NSOrderedSame && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            padTempView* view = (padTempView*)[self.view viewWithTag:tag];
            img = view.image;
        } else {
            UIImageView* view = (UIImageView*)[self.view viewWithTag:tag];
            img = view.image;
        }
    }else if(tag == 394){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            UIImageView* view = (UIImageView*)[self.view viewWithTag:tag];
            img = view.image;
        } else {
            padTempView* view = (padTempView*)[self.view viewWithTag:tag];
            img = view.image;
        }
    }
    else {
        UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
        UIView* item = [showBg viewWithTag:tag];
        myPicItem* pic = (myPicItem*)[item viewWithTag:item.tag-100];
        img = [pic myImage];
    }
    return img;
}
-(NSInteger)showNextPic:(NSInteger)tag withLeft:(BOOL)isLeft{
    if (tag == 394) {
        if (isLeft) {
            return -1;
        } else {
            if (imageCount == 0) {
                return 395;
            }else{
                return 400;
            }
        }
    } else if (tag == 395) {
        if (isLeft) {
            if ([self.typeid compare:@"1"] == NSOrderedSame) {
                if (imageCount == 0) {
                    return 394;
                }else{
                    return 399 + imageCount;
                }
            }
            return -1;
        } else {
            if ([self.typeid compare:@"1"] == NSOrderedSame) {
                return -1;
            }
            if (imageCount == 0) {
                return -1;
            }else{
                return 400;
            }
        }
    } else {
        if (isLeft) {
            if (tag == 400) {
                if ([self.typeid compare:@"4"] == NSOrderedSame) {
                    tag = -1;
                } else if ([self.typeid compare:@"1"] == NSOrderedSame) {
                    tag = 394;
                } else {
                    tag = 395;
                }
            } else {
                tag = tag-1;
            }
        } else {
            if (tag == 399 + imageCount) {
                if ([self.typeid compare:@"1"] == NSOrderedSame) {
                    tag = 395;
                } else {
                    tag = -1;
                }
            } else {
                tag = tag+1;
            }
        }
    }
    return tag;
}
-(void)showImage:(NSNotification*)aNotification{
    NSNumber* info = [aNotification object];
    [self showImg:[info integerValue]];
}
-(void)addaImage:(NSNotification*)aNotification{
    NSNumber* info = [aNotification object];
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    UIView* item = [showBg viewWithTag:[info integerValue]];
    myPicItem* pic = (myPicItem*)[item viewWithTag:item.tag-100];
    if (![uploadFiles containsObject:pic.fileName]) {
        [uploadFiles addObject:pic.fileName];
    }
}
-(void)removeImage:(NSNotification*)aNotification{
    NSNumber* info = [aNotification object];
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    UIView* item = [showBg viewWithTag:[info integerValue]];
    [item removeFromSuperview];
    myPicItem* pic = (myPicItem*)[item viewWithTag:item.tag-100];
    if ([uploadFiles containsObject:pic.fileName]) {
        [uploadFiles removeObject:pic.fileName];
    }
    CGFloat w = 216.0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        w = 116.0;
    }
    for (int i = [info intValue]+1-400; i<imageCount; i++) {
        UIView* item = [showBg viewWithTag:i+400];
        myPicItem* pic = (myPicItem*)[item viewWithTag:item.tag-100];
        pic.tag = 299 + i;
        item.tag = 399 + i;
        item.frame = CGRectOffset(item.frame,-w,0);
    }
    imageCount--;
    UIView* bgEmpty = [showBg viewWithTag: 370];
    bgEmpty.alpha = 1.0;
    int itemCount = firstImgIndex+imageCount+1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGFloat itemW = 110.0;
        CGFloat itemH = 165.0;
        bgEmpty.frame = CGRectMake(6.0 + (itemW+6.0)*(firstImgIndex+imageCount), 0.0, itemW, itemH);
        
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            UIView* bgDrow = [showBg viewWithTag: 390];
            bgDrow.frame = CGRectMake(6.0 + (itemW+6.0)*(firstImgIndex+imageCount+1), 0.0, itemW, itemH);
            itemCount++;
        }
        [showBg setContentSize:CGSizeMake(6.0 + (itemW+6.0)*itemCount, itemH+1.0)];
    }else{
        CGFloat itemW = 200.0;
        CGFloat itemH = 200.0/320.0*480.0;
        CGFloat h = showBg.bounds.size.height;
        bgEmpty.frame = CGRectMake(32.0 + (itemW+16.0)*(firstImgIndex+imageCount), (h-itemH)/2.0, itemW, itemH);
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            UIView* bgDrow = [showBg viewWithTag: 390];
            bgDrow.frame = CGRectMake(32.0 + (itemW+16.0)*(firstImgIndex+imageCount+1), (h-itemH)/2.0, itemW, itemH);
            itemCount++;
        }
        [showBg setContentSize:CGSizeMake(32.0 + (itemW+16.0)*itemCount, itemH+1.0)];
    }
}
-(void)didSelectAssets:(NSArray*)items{
    if(isHead){
        if (items.count>0) {
            ALAsset* al = [items objectAtIndex:0];
            UIImage* userHeadImage = [assert getImageFromAsset:al type:ASSET_PHOTO_SCREEN_SIZE];
            headImg.img = userHeadImage;
            [self SendPECropView:userHeadImage];
        }
    }else{
        NSLog(@"%@",items);
        for (int i = 0; i < items.count; i++)
        {
            ALAsset* al = [items objectAtIndex:i];
            UIImage *img = [assert getImageFromAsset:al type:ASSET_PHOTO_THUMBNAIL];
            [self addImgfromAsset:al andThumb:img  orFile:@"" atIndex:imageCount];
            imageCount++;
        }
    }
}

#pragma mark - PreviewViewControllerDelegate
-(void)didSelectID:(NSString*)index andNefmbdw:(NSString*)nefmbdw{
    self.tempId = index;
    self.tempLoc = nefmbdw;
    [self drowImg];
}
-(void)didSendType:(int) type{
    if (type == 0) {
        [self sendTap];
    } else {
        [self saveTap];
    }
}
#pragma mark - ipad 模版
-(void)addImgfromAsset:(ALAsset*)al andThumb:(UIImage*)img orFile:(NSString*)fileName atIndex:(int)index{
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        CGFloat itemW = 110.0;
        CGFloat itemH = 165.0;
        UIView* bg1 = [[UIView alloc] initWithFrame:CGRectMake(6.0 + (itemW+6.0)*(firstImgIndex+index), 0.0, itemW, itemH)];
        bg1.backgroundColor = [[UIColor alloc] initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
        [showBg addSubview:bg1];
        bg1.layer.shadowRadius = 2;
        bg1.layer.shadowOpacity = 1.0;
        bg1.layer.shadowColor = [UIColor grayColor].CGColor;
        bg1.layer.shadowOffset = CGSizeMake(1, 1);
        
        myPicItem *item = [[myPicItem alloc] initWithFrame:bg1.bounds fromAsset:al andThumb:img orFile:fileName];
        item.tag = 300 + index;
        [bg1 addSubview: item];
        bg1.tag = 400 + index;
        UIView* bgEmpty = [showBg viewWithTag: 370];
        int itemCount = firstImgIndex + 2 + index;
        if (index == imageMax - 1) {
            bgEmpty.alpha = 0.0;
            itemCount--;
        } else {
            bgEmpty.alpha = 1.0;
            bgEmpty.frame = CGRectMake(6.0 + (itemW+6.0)*(firstImgIndex+index+1), 0.0, itemW, itemH);
        }
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            UIView* bgDrow = [showBg viewWithTag: 390];
            bgDrow.frame = CGRectMake(6.0 + (itemW+6.0)*itemCount, 0, itemW, itemH);
            itemCount++;
        }
        [showBg setContentSize:CGSizeMake(6.0 + (itemW+6.0)*itemCount, itemH+1.0)];
    }else{
        CGFloat itemW = 200.0;
        CGFloat itemH = 200.0/320.0*480.0;
        CGFloat h = showBg.bounds.size.height;
        UIView* bg1 = [[UIView alloc] initWithFrame:CGRectMake(32.0 + (itemW+16.0)*(firstImgIndex+index), (h-itemH)/2.0, itemW, itemH)];
        bg1.backgroundColor = [[UIColor alloc] initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
        [showBg addSubview:bg1];
        bg1.layer.shadowRadius = 2;
        bg1.layer.shadowOpacity = 1.0;
        bg1.layer.shadowColor = [UIColor grayColor].CGColor;
        bg1.layer.shadowOffset = CGSizeMake(1, 1);
        
        myPicItem *item = [[myPicItem alloc] initWithFrame:bg1.bounds fromAsset:al andThumb:img orFile:fileName];
        item.tag = 300 + index;
        [bg1 addSubview: item];
        bg1.tag = 400 + index;
        UIView* bgEmpty = [showBg viewWithTag: 370];
        int itemCount = firstImgIndex + 2 + index;
        if (index == imageMax - 1) {
            bgEmpty.alpha = 0.0;
            itemCount--;
        } else {
            bgEmpty.alpha = 1.0;
            bgEmpty.frame = CGRectMake(32.0 + (itemW+16.0)*(firstImgIndex+index+1), (h-itemH)/2.0, itemW, itemH);
        }
        
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            UIView* bgDrow = [showBg viewWithTag: 390];
            bgDrow.frame = CGRectMake(32.0 + (itemW+16.0)*itemCount, (h-itemH)/2.0, itemW, itemH);
            itemCount++;
        }
        [showBg setContentSize:CGSizeMake(32.0 + (itemW+16.0)*itemCount, h)];
    }
}
-(void)initPreView{
        UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
        CGRect r = showBg.frame;
//        CGFloat w = r.size.width;
        CGFloat h = r.size.height;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            CGFloat itemW = 110.0;
            CGFloat itemH = 165.0;
            [self setPreviewImg];
            UIView* bg1 = [[UIView alloc] initWithFrame:CGRectMake(6.0 + (itemW+6.0)*firstImgIndex, 0.0, itemW, itemH)];
            bg1.backgroundColor = [[UIColor alloc] initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
            bg1.layer.shadowRadius = 2;
            bg1.layer.shadowOpacity = 1.0;
            bg1.layer.shadowColor = [UIColor grayColor].CGColor;
            bg1.layer.shadowOffset = CGSizeMake(1, 1);
            [showBg addSubview:bg1];
            bg1.tag = 370;
            [self addEmptyImg2view:bg1];
            int itemCount = firstImgIndex + 1;
            if ([self.typeid compare:@"1"] == NSOrderedSame) {
                itemCount++;
            }
            [showBg setContentSize:CGSizeMake(6.0 + (itemW+6.0)*itemCount, itemH+1.0)];
        } else {
            CGFloat itemW = 200.0;
            CGFloat itemH = 200.0/320.0*480.0;
            [self setPreviewImg];
            UIView* bg1 = [[UIView alloc] initWithFrame:CGRectMake(32.0 + (itemW+16.0)*firstImgIndex, (h-itemH)/2.0, itemW, itemH)];
            bg1.backgroundColor = [[UIColor alloc] initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
            [showBg addSubview:bg1];
            bg1.layer.shadowRadius = 2;
            bg1.layer.shadowOpacity = 1.0;
            bg1.layer.shadowColor = [UIColor grayColor].CGColor;
            bg1.layer.shadowOffset = CGSizeMake(1, 1);
            bg1.tag = 370;
            [self addEmptyImg2view:bg1];
            int itemCount = firstImgIndex + 1;
            if ([self.typeid compare:@"1"] == NSOrderedSame) {
                itemCount++;
            }
            [showBg setContentSize:CGSizeMake(32.0 + (itemW+16.0)*itemCount, h)];
        }
}
-(void) addEmptyImg2view:(UIView*)bg1{
    UIView * emptyView = [[UIView alloc] initWithFrame:bg1.bounds];
    emptyView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImgs)];
    [emptyView addGestureRecognizer:tap4 ];
    CGFloat h = bg1.bounds.size.width*0.618;
    CGFloat w = 3.0;
    UIView *hen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, h, w)];
    hen.backgroundColor = [UIColor whiteColor];
    hen.layer.cornerRadius = 1.0;
    hen.center = CGPointMake(emptyView.bounds.size.width/2.0, emptyView.bounds.size.height/2.0);
    [emptyView addSubview:hen];
    UIView *shu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    shu.backgroundColor = [UIColor whiteColor];
    shu.layer.cornerRadius = 1.0;
    shu.center = CGPointMake(emptyView.bounds.size.width/2.0, emptyView.bounds.size.height/2.0);
    [emptyView addSubview:shu];
    [bg1 addSubview: emptyView];
}

-(void)setPreviewImg{
    
    if ([self.typeid compare:@"4"] == NSOrderedSame) {
        self.tempLoc = @"";
        firstImgIndex = 0;
        return;
    }//markwyb
    else{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            //markwyb
        self.tempId = @"1";
        self.tempLoc = @"/sdyy/huayang/assets/images/base";
        }
    }
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    firstImgIndex = 1;
    CGFloat itemW = 110.0;
    CGFloat itemH = 165.0;
    UIView* bg = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        itemW = 110.0;
        itemH = 165.0;
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(6.0, 0, itemW, itemH)];
            img.tag = 394;
            img.layer.shadowRadius = 2;
            img.layer.shadowOpacity = 1.0;
            img.layer.shadowColor = [UIColor grayColor].CGColor;
            img.layer.shadowOffset = CGSizeMake(1, 1);
            [showBg addSubview:img];
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHomePic)];
            [img addGestureRecognizer:tap];
            bg = [[UIView alloc] initWithFrame:CGRectMake(6.0 + (itemW+6.0)*2.0, 0.0, itemW, itemH)];
        }else{
            bg = [[UIView alloc] initWithFrame:CGRectMake(6.0 + (itemW+6.0)*0.0, 0.0, itemW, itemH)];
        }
        bg.backgroundColor = [UIColor clearColor];
        [showBg addSubview:bg];
        bg.layer.shadowRadius = 2;
        bg.layer.shadowOpacity = 1.0;
        bg.layer.shadowColor = [UIColor grayColor].CGColor;
        bg.layer.shadowOffset = CGSizeMake(1, 1);
        bg.tag = 390;
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemW, itemH)];
        img.tag = 395;
        img.center = CGPointMake(bg.frame.size.width/2.0, bg.frame.size.height/2.0);
        [bg addSubview:img];
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDraw)];
        [img addGestureRecognizer:tap];
    } else {
        itemW = 200.0;
        itemH = 200.0/320.0*480.0;
        CGFloat h = showBg.frame.size.height;
        UIView * padK = [[UIView alloc] initWithFrame:CGRectMake(32.0, (h-itemH)/2.0, itemW, itemH)];
        [showBg addSubview:padK];
        padK.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.95];
        padK.layer.shadowRadius = 2;
        padK.layer.shadowOpacity = 1.0;
        padK.layer.shadowColor = [UIColor grayColor].CGColor;
        padK.layer.shadowOffset = CGSizeMake(1, 1);
        tempView = [[padTempView alloc] initWithFrame:CGRectMake(32.0, 0, itemW, h)];
        tempView.backgroundColor = [UIColor clearColor];
        [showBg addSubview:tempView];
        tempView.delegate = self;
        tempView.itemSize = CGSizeMake(itemW,itemH);
//        markwyb
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            tempView.tag = 394;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHomePic)];
            [tempView addGestureRecognizer:tap];
            bg = [[UIView alloc] initWithFrame:CGRectMake(32.0 + (itemW+16.0)*2.0, (h-itemH)/2.0, itemW, itemH)];
            [showBg addSubview:bg];
            bg.backgroundColor = [UIColor clearColor];
            bg.layer.shadowRadius = 2;
            bg.layer.shadowOpacity = 1.0;
            bg.layer.shadowColor = [UIColor grayColor].CGColor;
            bg.layer.shadowOffset = CGSizeMake(1, 1);
            bg.tag = 390;
            UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemW, itemH)];
            img.tag = 395;
            img.center = CGPointMake(bg.frame.size.width/2.0, bg.frame.size.height/2.0);
            [bg addSubview:img];
            img.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDraw)];
            [img addGestureRecognizer:tap2];
        }else{
            tempView.tag = 395;
            UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDraw)];
            [tempView addGestureRecognizer:tap2];
        }
        tempData = [[DataBaseManage getDataBaseManage] GetTemplate:self.typeid];
        [tempView reloadViews];
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            [tempView showListAtIndex:[UDObject gethltempIndex]];
            [self didShowItemAtIndex:[UDObject gethltempIndex]];
        } else if ([self.typeid compare:@"2"] == NSOrderedSame){
            [tempView showListAtIndex:[UDObject getswtempIndex]];
            [self didShowItemAtIndex:[UDObject getswtempIndex]];
        }else if ([self.typeid compare:@"3"] == NSOrderedSame){
            [tempView showListAtIndex:[UDObject gethdtempIndex]];
            [self didShowItemAtIndex:[UDObject gethdtempIndex]];
        }
    }
    [self drowImg];
}
-(NSInteger)numberOfItems{
    //列表元素个数哈哈
    return [tempData count];
}
-(UIView*)cellForItemAtIndex:(NSInteger)index{
    Template *info = [tempData objectAtIndex:index];
    NSString *nefmbbg = [[NSString alloc] initWithFormat:@"%@",info.nefmbdw];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
    if (![[NSFileManager defaultManager] fileExistsAtPath:nefmbbg]) {
        NSArray* names = [info.nefmbbg componentsSeparatedByString:@"/"];
        NSString *name = [names objectAtIndex:2];
        [ZipDown UnzipSingle:name];
    }
    CGFloat itemW = 200.0;
    CGFloat itemH = 200.0/320.0*480.0;
    if ([self.typeid compare:@"1"] == NSOrderedSame) {
        nefmbbg = [nefmbbg stringByReplacingOccurrencesOfString:@"base" withString:@"home"];
    }
    UIImage* imgt = [[UIImage alloc]initWithContentsOfFile:nefmbbg];
    UIImage* img2 = [[UIImage alloc] initWithCGImage:imgt.CGImage scale:2.0 orientation:UIImageOrientationUp];
    UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0, itemW, itemH)];
    img.image = img2;
    return img;
}

-(void)didShowItemAtIndex:(NSInteger)index{
    Template *info = [tempData objectAtIndex:index];
    self.tempLoc = [[NSString alloc] initWithFormat:@"%@",info.nefmbdw];
    self.tempId = [[NSString alloc] initWithFormat:@"%@",info.nefid];
    [self drowImg];
}
-(void)drowImg{
    isBgsend = NO;
    if ([self.typeid compare:@"4"] == NSOrderedSame) {
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *nefmbbg = [documentsDirectory stringByAppendingString:self.tempLoc];
    if (![[NSFileManager defaultManager] fileExistsAtPath:nefmbbg]) {
        NSArray* names = [self.tempLoc componentsSeparatedByString:@"/"];
        NSString *name = [names objectAtIndex:2];
        [ZipDown UnzipSingle:name];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIImageView* view = (UIImageView*)[self.view viewWithTag:395];
        view.image = [self getimg:nefmbbg andIndex:self.tempId];
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            UIImageView* img = (UIImageView*)[self.view viewWithTag:394];
            NSString *homeLoc = [self.tempLoc stringByReplacingOccurrencesOfString:@"base" withString:@"home"];
            NSString *nefmbbg = [documentsDirectory stringByAppendingString:homeLoc];
            UIImage* ti = [[UIImage alloc] initWithContentsOfFile:nefmbbg];
            img.image = [[UIImage alloc] initWithCGImage:ti.CGImage scale:2.0 orientation:UIImageOrientationUp];
        }
    } else {
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            UIImageView* view = (UIImageView*)[self.view viewWithTag:395];
            view.image = [self getimg:nefmbbg andIndex:self.tempId];
        } else {
            NSInteger cid = [tempView getIndex];
            UIImageView* view = (UIImageView*)[tempView viewWithTag:990+cid];
            view.image = [self getimg:nefmbbg andIndex:self.tempId];
            NSInteger up = cid - 1;
            if (up < 0) {
                up = tempData.count - 1;
            }
            Template *info = [tempData objectAtIndex:up];
            nefmbbg = [documentsDirectory stringByAppendingString:info.nefmbdw];
            view = (UIImageView*)[tempView viewWithTag:990+up];
            view.image = [self getimg:nefmbbg andIndex:[[NSString alloc] initWithFormat:@"%@",info.nefid]];
            NSInteger down = cid + 1;
            if (down >= tempData.count) {
                down = 0;
            }
            info = [tempData objectAtIndex:down];
            nefmbbg = [documentsDirectory stringByAppendingString:info.nefmbdw];
            view = (UIImageView*)[tempView viewWithTag:990+down];
            view.image = [self getimg:nefmbbg andIndex:[[NSString alloc] initWithFormat:@"%@",info.nefid]];
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIImageView*view = (UIImageView*)[tempView viewWithTag:990+[tempView getIndex]];
            tempView.image = view.image;
        }
    }
}
-(UIImage *)getimg:(NSString *) str andIndex:(NSString*) index{
    NSArray *dataarray = [[DataBaseManage getDataBaseManage] GetInfo:index];
    NSInfoImg* infodata = [[NSInfoImg alloc] initWithbgImagePath:str];//背景图文件路径
    CGFloat red1 = 0.0;
    CGFloat green1 = 0.0;
    CGFloat blue1 = 0.0;
    for (int i = 0; i < [dataarray count]; i++) {
        Info *info = [dataarray objectAtIndex:i];
        NSString *parameterName = info.nefparametername;
        CGFloat x = [info.nefx floatValue];
        CGFloat y = [info.nefy floatValue];
        CGFloat w = [info.nefwidth floatValue];
        CGFloat h = [info.nefheight floatValue];
        CGFloat size = [info.neffontsize floatValue];
        NSString *rgb = info.neffontcolor;
        red1 = strtoul([[rgb substringWithRange:NSMakeRange(1,2)] UTF8String],0,16);
        green1 = strtoul([[rgb substringWithRange:NSMakeRange(3,2)] UTF8String],0,16);
        blue1 = strtoul([[rgb substringFromIndex:5] UTF8String],0,16);
        if ([parameterName isEqualToString:@"marryName"]) {
            NSString *name = [NSString stringWithFormat:@"%@ & %@",manInput.text,wemanInput.text];
            [infodata addInfoWithValue:name andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }else if ([parameterName isEqualToString:@"partyName"]) {
            [infodata addInfoWithValue:titleInput.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }else if ([parameterName isEqualToString:@"timestamp"]) {
            [infodata addInfoWithValue:timeInput.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }else if ([parameterName isEqualToString:@"address"]) {
            [infodata addInfoWithValue:locInput.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }
        else if ([parameterName isEqualToString:@"description"]) {
            NSString *content = tipInput.text;
            if (content.length > 0) {
                [infodata addInfoWithValue:tipInput.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:NO:YES];
            }
        }
    }
    NSArray *fixeds = [[DataBaseManage getDataBaseManage] GetFixeds:self.tempId];
    for (Fixeds *info in fixeds) {
        CGFloat x = info.nefX;
        CGFloat y = info.nefY;
        CGFloat w = info.nefWidth;
        CGFloat h = info.nefHeight;
        CGFloat size = info.nefFontSize;
        [infodata addInfoWithValue:info.nefContent andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
    }
    drowImage = [infodata getSaveImg :YES];
    return drowImage;
}
#pragma mark - 数据操作
-(void)initOldInput{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    if ([self.typeid compare:@"1"] == NSOrderedSame && [UDObject getxl_name].length > 0) {//婚礼
        NSString* uploads = [UDObject getHLupload];
        manInput.text = [UDObject getxl_name];
        wemanInput.text = [UDObject getxn_name];
        timeDouble = [[UDObject gethltime] doubleValue]/1000.0;
        endtimeDouble = [[UDObject getbmendtime] doubleValue]/1000.0;
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeDouble];
        timeInput.text = [dateFormatter stringFromDate:date];
        date = [[NSDate alloc] initWithTimeIntervalSince1970:endtimeDouble];
        endtimeInput.text = [dateFormatter stringFromDate:date];
        locInput.text = [UDObject getaddress_name];
        if ([UDObject gethlmusic].length > 0) {
            if ([UDObject gethlmusicname].length > 0) {
                musicInput.text = [UDObject gethlmusicname];
                musicURL = [UDObject gethlmusic];
            } else {
                NSArray *array = [[UDObject gethlmusic] componentsSeparatedByString:@"/"];
                NSString* fileTape = [[FileManage sharedFileManage].audioDirectory stringByAppendingPathComponent: [array lastObject]];
                NSFileManager* fm = [NSFileManager defaultManager];
                if([fm fileExistsAtPath:fileTape]){
                    [recordedInput showFile:fileTape];
                    if (uploads.length > 0) {
                        NSString* name = [array lastObject];
                        NSRange r = [uploads rangeOfString:name];
                        if (r.length != name.length) {
                            if (![uploadFiles containsObject:fileTape]) {
                                [uploadFiles addObject:fileTape];
                            }
                        }
                    }
                }
            }
        }
        if ([UDObject gethlimgarr].length > 2) {
            NSArray *arr = [[UDObject gethlimgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            for (NSString *name in arr) {
                NSArray *array = [name componentsSeparatedByString:@"/"];
                NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: [array lastObject]];
                [self addImgfromAsset:nil andThumb:nil  orFile:imgpath atIndex:imageCount];
                imageCount++;
                if (uploads.length > 0) {
                    NSRange r = [uploads rangeOfString:imgpath];
                    if (r.length == imgpath.length) {
//                        recordedFile = [[NSString alloc] initWithFormat:@"%@",fileTape];
                    }else{
                        if (![uploadFiles containsObject:imgpath]) {
                            [uploadFiles addObject:imgpath];
                        }
                    }
                }else{
                    if (![uploadFiles containsObject:imgpath]) {
                        [uploadFiles addObject:imgpath];
                    }
                }
            }
        }
        [self drowImg];
    }
    else if ([self.typeid compare:@"2"] == NSOrderedSame && [UDObject getjhname].length == 0) {
        contactmanInput.text = [UDObject getXM];
        contactInput.text = [UDObject getLXFS];
    }
    else if ([self.typeid compare:@"2"] == NSOrderedSame && [UDObject getjhname].length > 0) {//商务
        NSString* uploads = [UDObject getSWupload];
        titleInput.text = [UDObject getjhname];
        timeDouble = [[UDObject getswtime] doubleValue]/1000.0;
        endtimeDouble = [[UDObject getswbmendtime] doubleValue]/1000.0;
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeDouble];
        timeInput.text = [dateFormatter stringFromDate:date];
        date = [[NSDate alloc] initWithTimeIntervalSince1970:endtimeDouble];
        endtimeInput.text = [dateFormatter stringFromDate:date];
        locInput.text = [UDObject getswaddress_name];
        contactmanInput.text = [UDObject getswxlr_name];
        contactInput.text = [UDObject getswxlfs_name];
        if ([contactmanInput.text length] == 0) {
            contactmanInput.text = [UDObject getXM];
        }
        if ([contactInput.text length] == 0) {
            contactInput.text = [UDObject getLXFS];
        }
        tipInput.text = [UDObject getswhd_name];
        long num = tipCount - tipInput.text.length;
        tipCountLbl.text = [NSString stringWithFormat:@"剩余%ld字",num];
        if (num >= 0) {
            tipCountLbl.textColor = [UIColor grayColor];
        }else{
            tipCountLbl.textColor = [UIColor redColor];
        }
        if ([UDObject getsw_music].length > 0) {
            if ([UDObject getsw_musicname].length > 0) {
                musicInput.text = [UDObject getsw_musicname];
                musicURL = [UDObject getsw_music];
            } else {
                NSArray *array = [[UDObject getsw_music] componentsSeparatedByString:@"/"];
                NSString* fileTape = [[FileManage sharedFileManage].audioDirectory stringByAppendingPathComponent: [array lastObject]];
                NSFileManager* fm = [NSFileManager defaultManager];
                if([fm fileExistsAtPath:fileTape]){
                    [recordedInput showFile:fileTape];
                    if (uploads.length > 0) {
                        NSString* name = [array lastObject];
                        NSRange r = [uploads rangeOfString:name];
                        if (r.length != name.length) {
                            if (![uploadFiles containsObject:fileTape]) {
                                [uploadFiles addObject:fileTape];
                            }
                        }
                    }
                }
            }
        }
        if ([UDObject getsw_imgarr].length > 2) {
            NSArray *arr = [[UDObject getsw_imgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            for (NSString *name in arr) {
                NSArray *array = [name componentsSeparatedByString:@"/"];
                NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: [array lastObject]];
                [self addImgfromAsset:nil andThumb:nil  orFile:imgpath atIndex:imageCount];
                imageCount++;
                if (uploads.length > 0) {
                    NSRange r = [uploads rangeOfString:imgpath];
                    if (r.length == imgpath.length) {
                        //                        recordedFile = [[NSString alloc] initWithFormat:@"%@",fileTape];
                    }else{
                        if (![uploadFiles containsObject:imgpath]) {
                            [uploadFiles addObject:imgpath];
                        }
                    }
                }else{
                    if (![uploadFiles containsObject:imgpath]) {
                        [uploadFiles addObject:imgpath];
                    }
                }
            }
        }
        [self drowImg];
    }
    else if ([self.typeid compare:@"3"] == NSOrderedSame && [UDObject getwljh_name].length == 0) {
        contactmanInput.text = [UDObject getXM];
        contactInput.text = [UDObject getLXFS];
    }
    else if ([self.typeid compare:@"3"] == NSOrderedSame && [UDObject getwljh_name].length > 0) {//娱乐
        NSString* uploads = [UDObject getWLupload];
        titleInput.text = [UDObject getwljh_name];
        timeDouble = [[UDObject gewltime] doubleValue]/1000.0;
        endtimeDouble = [[UDObject getwlbmendtime] doubleValue]/1000.0;
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeDouble];
        timeInput.text = [dateFormatter stringFromDate:date];
        date = [[NSDate alloc] initWithTimeIntervalSince1970:endtimeDouble];
        endtimeInput.text = [dateFormatter stringFromDate:date];
        locInput.text = [UDObject getwladdress_name];
        contactmanInput.text = [UDObject getwllxr_name];
        contactInput.text = [UDObject getwllxfs_name];
        if ([contactmanInput.text length] == 0) {
            contactmanInput.text = [UDObject getXM];
        }
        if ([contactInput.text length] == 0) {
            contactInput.text = [UDObject getLXFS];
        }
        tipInput.text = [UDObject getwlts_name];
        long num = tipCount - tipInput.text.length;
        tipCountLbl.text = [NSString stringWithFormat:@"剩余%ld字",num];
        if (num >= 0) {
            tipCountLbl.textColor = [UIColor grayColor];
        }else{
            tipCountLbl.textColor = [UIColor redColor];
        }
        if ([UDObject getwlmusic].length > 0) {
            if ([UDObject getwlmusicname].length > 0) {
                musicInput.text = [UDObject getwlmusicname];
                musicURL = [UDObject getwlmusic];
            } else {
                NSArray *array = [[UDObject getwlmusic] componentsSeparatedByString:@"/"];
                NSString* fileTape = [[FileManage sharedFileManage].audioDirectory stringByAppendingPathComponent: [array lastObject]];
                NSFileManager* fm = [NSFileManager defaultManager];
                if([fm fileExistsAtPath:fileTape]){
                    [recordedInput showFile:fileTape];
                    if (uploads.length > 0) {
                        NSString* name = [array lastObject];
                        NSRange r = [uploads rangeOfString:name];
                        if (r.length != name.length) {
                            if (![uploadFiles containsObject:fileTape]) {
                                [uploadFiles addObject:fileTape];
                            }
                        }
                    }
                }
            }
        }
        if ([UDObject getwlimgarr].length > 2) {
            NSArray *arr = [[UDObject getwlimgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            for (NSString *name in arr) {
                NSArray *array = [name componentsSeparatedByString:@"/"];
                NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: [array lastObject]];
                [self addImgfromAsset:nil andThumb:nil  orFile:imgpath atIndex:imageCount];
                imageCount++;
                if (uploads.length > 0) {
                    NSRange r = [uploads rangeOfString:imgpath];
                    if (r.length == imgpath.length) {
                        //                        recordedFile = [[NSString alloc] initWithFormat:@"%@",fileTape];
                    }else{
                        if (![uploadFiles containsObject:imgpath]) {
                            [uploadFiles addObject:imgpath];
                        }
                    }
                }else{
                    if (![uploadFiles containsObject:imgpath]) {
                        [uploadFiles addObject:imgpath];
                    }
                }
            }
        }
        [self drowImg];
    } else if ([self.typeid compare:@"4"] == NSOrderedSame && [UDObject getzdytopimg].length > 0) {//自定义
        NSString* uploads = [UDObject getZDYupload];
        NSArray *array = [[UDObject getzdytopimg] componentsSeparatedByString:@"/"];
        NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: [array lastObject]];
        UIImage* img = [[UIImage alloc] initWithContentsOfFile:imgpath];
        headImg.img = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        headImg.imgContext.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
        
        titleInput.text = [UDObject getzdytitle];
        timeDouble = [[UDObject getzdytime] doubleValue]/1000.0;
        endtimeDouble = [[UDObject getzdyendtime] doubleValue]/1000.0;
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeDouble];
        timeInput.text = [dateFormatter stringFromDate:date];
        date = [[NSDate alloc] initWithTimeIntervalSince1970:endtimeDouble];
        endtimeInput.text = [dateFormatter stringFromDate:date];
        tipInput.text = [UDObject getzdydd];
        long num = tipCount - tipInput.text.length;
        tipCountLbl.text = [NSString stringWithFormat:@"剩余%ld字",num];
        if (num >= 0) {
            tipCountLbl.textColor = [UIColor grayColor];
        }else{
            tipCountLbl.textColor = [UIColor redColor];
        }
        if ([UDObject getzdymusic].length > 0) {
            if ([UDObject getzdymusicname].length > 0) {
                musicInput.text = [UDObject getzdymusicname];
                musicURL = [UDObject getzdymusic];
            } else {
                NSArray *array = [[UDObject getzdymusic] componentsSeparatedByString:@"/"];
                NSString* fileTape = [[FileManage sharedFileManage].audioDirectory stringByAppendingPathComponent: [array lastObject]];
                NSFileManager* fm = [NSFileManager defaultManager];
                if([fm fileExistsAtPath:fileTape]){
                    [recordedInput showFile:fileTape];
                    if (uploads.length > 0) {
                        NSString* name = [array lastObject];
                        NSRange r = [uploads rangeOfString:name];
                        if (r.length != name.length) {
                            if (![uploadFiles containsObject:fileTape]) {
                                [uploadFiles addObject:fileTape];
                            }
                        }
                    }
                }
            }
        }
        if ([UDObject getzdyimgarr].length > 2) {
            NSArray *arr = [[UDObject getzdyimgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
            for (NSString *name in arr) {
                NSArray *array = [name componentsSeparatedByString:@"/"];
                NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: [array lastObject]];
                [self addImgfromAsset:nil andThumb:nil  orFile:imgpath atIndex:imageCount];
                imageCount++;
                if (uploads.length > 0) {
                    NSRange r = [uploads rangeOfString:imgpath];
                    if (r.length == imgpath.length) {
                        //                        recordedFile = [[NSString alloc] initWithFormat:@"%@",fileTape];
                    }else{
                        if (![uploadFiles containsObject:imgpath]) {
                            [uploadFiles addObject:imgpath];
                        }
                    }
                }else{
                    if (![uploadFiles containsObject:imgpath]) {
                        [uploadFiles addObject:imgpath];
                    }
                }
            }
        }
    }
}
-(BOOL)isEmpty:(NSString*)txt{
    if (txt == nil || [txt compare:@""] == NSOrderedSame) {
        return YES;
    }
    return NO;
}
-(BOOL)checkAndsaveInput{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ([self.typeid compare:@"1"] == NSOrderedSame) {
            [UDObject sethltempIndex:[tempView getIndex]];
        } else if ([self.typeid compare:@"2"] == NSOrderedSame){
            [UDObject setswtempIndex:[tempView getIndex]];
        }else if ([self.typeid compare:@"3"] == NSOrderedSame){
            [UDObject sethdtempIndex:[tempView getIndex]];
        }
        if ([self.typeid compare:@"4"] != NSOrderedSame) {
            Template *items = [tempData objectAtIndex:[tempView getIndex]];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *zipurl = [documentsDirectory stringByAppendingPathComponent:items.nefzipurl];
            [UDObject setWebUrl:zipurl];
        }
    }
    [self.view endEditing:YES];
    if ([self.typeid compare:@"1"] == NSOrderedSame) {//婚礼
        if ([self isEmpty:manInput.text] || [self isEmpty:wemanInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入新人姓名。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:locInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入婚宴地点。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:timeInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有选择婚礼时间。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:endtimeInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有选择报名截止时间。" inTime:1.0];
            return NO;
        }
        if (manInput.text.length > 5 || wemanInput.text.length > 5) {
            [[StatusBar sharedStatusBar] talkMsg:@"您填写的新郎或新娘姓名超过了5个字。" inTime:1.0];
            return NO;
        }
        if (locInput.text.length > 20) {
            NSString* tip = [[NSString alloc] initWithFormat:@"您填写的地址信息有%lu字超过了20个。",(unsigned long)locInput.text.length];
            [[StatusBar sharedStatusBar] talkMsg:tip inTime:1.0];
            return NO;
        }
        if (![self isEmpty:musicInput.text] && ![self isEmpty:recordedInput.fileName]) {
            [[StatusBar sharedStatusBar] talkMsg:@"背景音乐和录音仅能选择一个。" inTime:1.0];
            return NO;
        }
        [self saveMarry];
    } else if ([self.typeid compare:@"2"] == NSOrderedSame || [self.typeid compare:@"3"] == NSOrderedSame) {//商务,娱乐
        if ([self isEmpty:titleInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入活动名称。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:locInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入地点。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:timeInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有选择活动时间。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:endtimeInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有选择报名截止时间。" inTime:1.0];
            return NO;
        }
        if (titleInput.text.length > 13) {
            [[StatusBar sharedStatusBar] talkMsg:@"您填写的活动名称超过了13个字,将无法完整显示。" inTime:1.0];
            return NO;
        }
        if (locInput.text.length > 20) {
            NSString* tip = [[NSString alloc] initWithFormat:@"您填写的地址信息有%lu字超过了20个。",(unsigned long)locInput.text.length];
            [[StatusBar sharedStatusBar] talkMsg:tip inTime:1.0];
            return NO;
        }
        if (tipInput.text != nil && tipInput.text.length > 70) {
            if ([self.typeid compare:@"3"] == NSOrderedSame) {
                [[StatusBar sharedStatusBar] talkMsg:@"您填写的温馨提示超过了70个字。" inTime:1.0];
            } else {
                [[StatusBar sharedStatusBar] talkMsg:@"您填写的活动简介超过了70个字。" inTime:1.0];
            }
            return NO;
        }
        if (contactmanInput.text != nil && contactmanInput.text.length > 20) {
            NSString* tip = [[NSString alloc] initWithFormat:@"您填写的联系人有%lu字超过了20个。",(unsigned long)contactmanInput.text.length];
            [[StatusBar sharedStatusBar] talkMsg:tip inTime:1.0];
            return NO;
        }
        if (contactInput.text != nil && contactInput.text.length > 40) {
            NSString* tip = [[NSString alloc] initWithFormat:@"您填写的联系方式有%lu字超过了40个。",(unsigned long)contactInput.text.length];
            [[StatusBar sharedStatusBar] talkMsg:tip inTime:1.0];
            return NO;
        }
        if (![self isEmpty:musicInput.text] && ![self isEmpty:recordedInput.fileName]) {
            [[StatusBar sharedStatusBar] talkMsg:@"背景音乐和录音仅能选择一个。" inTime:1.0];
            return NO;
        }
        if ([self.typeid compare:@"3"] == NSOrderedSame) {
            [self savePlay];
        } else {
            [self saveBuss];
        }
    } else if ([self.typeid compare:@"4"] == NSOrderedSame) {//自定义
        if (headImg.img == nil) {
            [[StatusBar sharedStatusBar] talkMsg:@"请选择一张封面图片。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:titleInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入标题。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:tipInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入封面导读。" inTime:1.0];
            return NO;
        }
        if (titleInput.text.length > 20) {
            [[StatusBar sharedStatusBar] talkMsg:@"您填写的标题超过了20个字,将无法完整显示。" inTime:1.0];
            return NO;
        }
        if (tipInput.text != nil && tipInput.text.length > 40) {
            [[StatusBar sharedStatusBar] talkMsg:@"您填写的封面导读超过了40个字。" inTime:1.0];
            return NO;
        }
        if (imageCount <= 0) {
            [[StatusBar sharedStatusBar] talkMsg:@"请至少选择一张图片。" inTime:1.0];
            return NO;
        }
        if (![self isEmpty:musicInput.text] && ![self isEmpty:recordedInput.fileName]) {
            [[StatusBar sharedStatusBar] talkMsg:@"背景音乐和录音仅能选择一个。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:timeInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有选择活动时间。" inTime:1.0];
            return NO;
        }
        if ([self isEmpty:endtimeInput.text]) {
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有选择报名截止时间。" inTime:1.0];
            return NO;
        }
        [self saveDIY];
    }
    return YES;
}
-(void)saveMadePic{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    madeFile = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    [UDObject setMbimg:[NSString stringWithFormat:@"../Image/%@",uuid]];
    [UIImageJPEGRepresentation(drowImage,C_JPEG_SIZE) writeToFile:madeFile atomically:YES];
}
-(void)saveMarry{
    [self saveMadePic];
    NSMutableArray* webPics = [[NSMutableArray alloc] init];
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    for (int i = 0; i<imageCount; i++) {
        myPicItem* itemPic = (myPicItem*)[showBg viewWithTag:300+i];
        [webPics addObject:itemPic.localName];
    }
    NSString *hlarr = [webPics componentsJoinedByString:@","];
    if(webPics.count == 0){
        hlarr = @"";
    }
    NSString *music_u = musicURL;
    NSString *music_n = musicInput.text;
    if (musicInput.text.length == 0 && recordedInput.fileName.length == 0) {
        music_u = @"";
        music_n = @"";
    } else if (musicInput.text.length == 0 && recordedInput.fileName.length != 0){
        NSArray *sa= [recordedInput.fileName componentsSeparatedByString:@"/"];
        music_u = [NSString stringWithFormat:@"../Audio/%@",[sa lastObject]];//recordedInput.fileName;
        music_n = @"";
    }
    [UDObject setHLContent:manInput.text xn_name:wemanInput.text hltime:[self time2str:timeDouble] bmendtime:[self time2str:endtimeDouble] address_name:locInput.text music:music_u musicname:music_n imgarr:hlarr];
}
-(NSString*)time2str:(NSTimeInterval)time{
    NSArray* time_s = [[[NSString alloc] initWithFormat:@"%f",time*1000.0] componentsSeparatedByString:@"."];
    return [time_s objectAtIndex:0];
}
-(void)savePlay{
    [self saveMadePic];
    NSMutableArray* webPics = [[NSMutableArray alloc] init];
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    for (int i = 0; i<imageCount; i++) {
        myPicItem* itemPic = (myPicItem*)[showBg viewWithTag:300+i];
        [webPics addObject:itemPic.localName];
    }
    NSString *hlarr = [webPics componentsJoinedByString:@","];
    if(webPics.count == 0){
        hlarr = @"";
    }
    NSString *music_u = musicURL;
    NSString *music_n = musicInput.text;
    if (musicInput.text.length == 0 && recordedInput.fileName.length == 0) {
        music_u = @"";
        music_n = @"";
    } else if (musicInput.text.length == 0 && recordedInput.fileName.length != 0){
        NSArray *sa= [recordedInput.fileName componentsSeparatedByString:@"/"];
        music_u = [NSString stringWithFormat:@"../Audio/%@",[sa lastObject]];
        music_n = @"";
    }
    
    [UDObject setWLContent:titleInput.text wltime:[self time2str:timeDouble] wlbmendtime:[self time2str:endtimeDouble] wladdress_name:locInput.text wllxr_name:contactmanInput.text wllxfs_name:contactInput.text wlts_name:tipInput.text wlmusicname:music_n wlmusic:music_u wlimgarr:hlarr];
}
-(void)saveBuss{
    [self saveMadePic];
    NSMutableArray* webPics = [[NSMutableArray alloc] init];
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    for (int i = 0; i<imageCount; i++) {
        myPicItem* itemPic = (myPicItem*)[showBg viewWithTag:300+i];
        [webPics addObject:itemPic.localName];
    }
    NSString *hlarr = [webPics componentsJoinedByString:@","];
    if(webPics.count == 0){
        hlarr = @"";
    }
    NSString *music_u = musicURL;
    NSString *music_n = musicInput.text;
    if (musicInput.text.length == 0 && recordedInput.fileName.length == 0) {
        music_u = @"";
        music_n = @"";
    } else if (musicInput.text.length == 0 && recordedInput.fileName.length != 0){
        NSArray *sa= [recordedInput.fileName componentsSeparatedByString:@"/"];
        music_u = [NSString stringWithFormat:@"../Audio/%@",[sa lastObject]];
        music_n = @"";
    }
    [UDObject setSWContent:titleInput.text swtime:[self time2str:timeDouble] swbmendtime:[self time2str:endtimeDouble] address_name:locInput.text swxlr_name:contactmanInput.text swxlfs_name:contactInput.text swhd_name:tipInput.text music:music_u musicname:music_n imgarr:hlarr];
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
-(void)saveDIY{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    headFile = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    NSString* headName = [NSString stringWithFormat:@"../Image/%@",uuid];
    [UIImageJPEGRepresentation([self imageWithImageSimple:headImg.imgContext.image scaledToSize:CGSizeMake(120, 120)],C_JPEG_SIZE) writeToFile:headFile atomically:YES];
    //markwyb 这个一定要按尺寸压缩处理
    NSMutableArray* webPics = [[NSMutableArray alloc] init];
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    for (int i = 0; i<imageCount; i++) {
        myPicItem* itemPic = (myPicItem*)[showBg viewWithTag:300+i];
        [webPics addObject:itemPic.localName];
    }
    NSString *hlarr = [webPics componentsJoinedByString:@","];
    if(webPics.count == 0){
        hlarr = @"";
    }
    NSString *music_u = musicURL;
    NSString *music_n = musicInput.text;
    if (musicInput.text.length == 0 && recordedInput.fileName.length == 0) {
        music_u = @"";
        music_n = @"";
    } else if (musicInput.text.length == 0 && recordedInput.fileName.length != 0){
        NSArray *sa= [recordedInput.fileName componentsSeparatedByString:@"/"];
        music_u = [NSString stringWithFormat:@"../Audio/%@",[sa lastObject]];
        music_n = @"";
    }
    [UDObject setZDYContent:headName zdytitle:titleInput.text zdydd:tipInput.text zdytime:[self time2str:timeDouble] zdyendtime:[self time2str:endtimeDouble] zdymusic:music_u zdymusicname:music_n zdyimgarr:hlarr];
}
-(void)reviewTap{
    if ([self checkAndsaveInput]) {
        [TalkingData trackEvent:@"预览"];
        PreviewViewController *view = [[PreviewViewController alloc] init];
        view.type = [self.typeid intValue]-1;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            view.showTemp = YES;
        }else{
            view.showTemp = NO;
        }
        view.delegate = self;
        view.modalPresentationStyle = UIModalPresentationFormSheet;
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:^{
            
        }];
    }
}
-(void)save2web{
    [[waitingView sharedwaitingView] changeWord:@"正在努力制作中……"];
    NSString* tapeFile = @"";
    NSMutableString* upfile = [[NSMutableString alloc] init];
    if (recordedInput.fileName.length != 0) {
        tapeFile = [HttpManage getWebLoc:recordedInput.fileName];
        [upfile appendFormat:@",%@",tapeFile];
        [TalkingData trackEvent:@"添加录音"];
    }else if(musicInput.text.length != 0){
        tapeFile = musicURL;
        [TalkingData trackEvent:@"添加音乐" label:musicInput.text];
    }
    NSMutableArray* webImgs = [[NSMutableArray alloc] init];
    UIScrollView* showBg = (UIScrollView*)[self.view viewWithTag: 141];
    for (int i = 0; i<imageCount; i++) {
        myPicItem* itemPic = (myPicItem*)[showBg viewWithTag:300+i];
        [upfile appendFormat:@",%@",itemPic.fileName];
        [webImgs addObject:[HttpManage getWebLoc:itemPic.fileName ]];
    }
    if ([self.typeid compare:@"1"] == NSOrderedSame) {//hl
        [UDObject setHLupload:upfile];
        [HttpManage marry:[UDObject gettoken] bride:wemanInput.text groom:manInput.text address:locInput.text location:nil images:webImgs timestamp:[self time2str:timeDouble] background:[HttpManage getWebLoc:madeFile] musicUrl:tapeFile closeTimestamp:[self time2str:endtimeDouble] mid:self.tempId cb:^(BOOL isOK, NSDictionary *dic){
            if (isOK) {
                [[waitingView sharedwaitingView] stopWait];
                [[StatusBar sharedStatusBar] talkMsg:@"生成成功" inTime:0.3];
                NSString* url_str = [dic objectForKey:@"url"];
                NSString* rid = [[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"recordId"] ];
                NSRange r = [url_str rangeOfString:rid];
                NSString* urlhead = [url_str substringToIndex:r.location];
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                        locInput.text,@"address",
                                        [HttpManage getWebLoc:madeFile],@"background",
                                        wemanInput.text,@"bride",
                                        manInput.text,@"groom",
                                        tapeFile,@"musicUrl",[self time2str:timeDouble],@"timestamp",[self time2str:endtimeDouble],@"closeTimestamp",
                                        webImgs,@"images",
                                        [[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"timestamp"]],
                                        @"date",@"0",@"number",@"0",@"total",self.tempId,@"typeId",
                                        [[NSString alloc] initWithFormat:@"%@index.html",urlhead],@"templateUrl",
                                        [[NSString alloc] initWithFormat:@"%@assets/images/preview.jpg",urlhead],@"thumb",rid,@"unquieId",url_str,@"url",
                                        nil];
                [[DataBaseManage getDataBaseManage] AddUserdata:params type:1];
                [self dismissViewControllerAnimated:NO completion:^{}];
                if (sendtaped) {
                    [TalkingData trackEvent:@"生成并发送"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BCFS" object:self userInfo:nil];
                }else{
                    [TalkingData trackEvent:@"生成"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_FS" object:self userInfo:nil];
                }
            }else{
                [[waitingView sharedwaitingView] stopWait];
                [TalkingData trackEvent:@"保存数据失败"];
                [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.8];
            }
        }];
    } else if ([self.typeid compare:@"2"] == NSOrderedSame || [self.typeid compare:@"3"] == NSOrderedSame) {//sw//pl
        if ([self.typeid compare:@"2"] == NSOrderedSame) {
            [UDObject setSWupload:upfile];
        } else {
            [UDObject setWLupload:upfile];
        }
        [HttpManage party:[UDObject gettoken] partyName:titleInput.text inviter:contactmanInput.text telephone:contactInput.text address:locInput.text images:webImgs tape:tapeFile timestamp:[self time2str:timeDouble] closetime:[self time2str:endtimeDouble] description:tipInput.text background:[HttpManage getWebLoc:madeFile] mid:self.tempId cb:^(BOOL isOK, NSDictionary *dic) {
            if (isOK) {
                [[waitingView sharedwaitingView] stopWait];
                [[StatusBar sharedStatusBar] talkMsg:@"生成成功" inTime:0.3];
                NSString* url_str = [dic objectForKey:@"url"];
                NSString* rid = [[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"recordId"] ];
                NSRange r = [url_str rangeOfString:rid];
                NSString* urlhead = [url_str substringToIndex:r.location];
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                        locInput.text,@"address",
                                        [HttpManage getWebLoc:madeFile],@"background",
                                        [[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"cardTypeId"]],@"cardTypeId",
                                        contactInput.text,@"telephone",
                                        contactmanInput.text,@"contact",
                                        titleInput.text,@"partyName",tipInput.text,@"description",
                                        tapeFile,@"tape",[self time2str:timeDouble],@"timestamp",[self time2str:endtimeDouble],@"closeTimestamp",
                                        webImgs,@"images",
                                        [[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"timestamp"]],
                                        @"date",@"0",@"number",@"0",@"total",self.tempId,@"typeId",
                                        [[NSString alloc] initWithFormat:@"%@index.html",urlhead],@"templateUrl",
                                        [[NSString alloc] initWithFormat:@"%@assets/images/preview.jpg",urlhead],@"thumb",rid,@"unquieId",url_str,@"url",
                                        nil];
                [[DataBaseManage getDataBaseManage] AddUserdata:params type:2];
                [self dismissViewControllerAnimated:NO completion:^{}];
                if (sendtaped) {
                    [TalkingData trackEvent:@"生成并发送"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BCFS" object:self userInfo:nil];
                }else{
                    [TalkingData trackEvent:@"生成"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_FS" object:self userInfo:nil];
                }
            }else{
                [[waitingView sharedwaitingView] stopWait];
                [TalkingData trackEvent:@"保存数据失败"];
                [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.8];
            }
        }];
    } else if ([self.typeid compare:@"4"] == NSOrderedSame) {//zdy
        [upfile appendFormat:@",%@",headFile];
        [UDObject setZDYupload:upfile];
        [HttpManage custom:[UDObject gettoken] title:titleInput.text content:tipInput.text logo:[HttpManage getWebLoc:headFile] music:tapeFile timestamp:[self time2str:timeDouble] closeTimestamp:[self time2str:endtimeDouble] images:webImgs mid:self.tempId cb:^(BOOL isOK, NSDictionary *dic) {
            if (isOK) {
                [[waitingView sharedwaitingView] stopWait];
                [[StatusBar sharedStatusBar] talkMsg:@"生成成功" inTime:0.3];
                NSString* url_str = [dic objectForKey:@"url"];
                NSString* rid = [[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"recordId"] ];
                NSRange r = [url_str rangeOfString:rid];
                NSString* urlhead = [url_str substringToIndex:r.location];
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                        titleInput.text,@"title",tipInput.text,@"content",
                                        [HttpManage getWebLoc:headFile],@"logo",tapeFile,@"music",[self time2str:timeDouble],@"timestamp",[self time2str:endtimeDouble],@"closeTimestamp",
                                        webImgs,@"images",
                                        [[NSString alloc] initWithFormat:@"%@",[dic objectForKey:@"timestamp"]],
                                        @"date",@"0",@"number",@"0",@"total",self.tempId,@"typeId",
                                        [[NSString alloc] initWithFormat:@"%@index.html",urlhead],@"templateUrl",
                                        [[NSString alloc] initWithFormat:@"%@assets/images/preview.jpg",urlhead],@"thumb",rid,@"unquieId",url_str,@"url",
                                        nil];
                [[DataBaseManage getDataBaseManage] AddUserdata:params type:0];
                [self dismissViewControllerAnimated:NO completion:^{}];
                if (sendtaped) {
                    [TalkingData trackEvent:@"生成并发送"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BCFS" object:self userInfo:nil];
                }else{
                    [TalkingData trackEvent:@"生成"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_FS" object:self userInfo:nil];
                }
            }else{
                [[waitingView sharedwaitingView] stopWait];
                [TalkingData trackEvent:@"保存数据失败"];
                [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.8];
            }
        }];
    }
}
-(void)uploadFile{
    if ([uploadFiles count] > 0) {
        NSString* file = [uploadFiles lastObject];
        NSArray *names = [file componentsSeparatedByString:@"/"];
        [HttpManage uploadfile:file name:[names lastObject] cb:^(BOOL isOK, NSString *URL) {
            if (isOK) {
                [uploadFiles removeLastObject];
                [self uploadFile];
            } else {
                [[waitingView sharedwaitingView] stopWait];
                [TalkingData trackEvent:@"上传素材失败"];
                [[StatusBar sharedStatusBar] talkMsg:@"上传素材失败了，再试一次吧" inTime:0.8];
            }
        }];
    } else {
        [self save2web];
    }
}
-(void)uploadMade{
    if (isBgsend) {
        [self uploadFile];
    } else {
        NSArray *names = [madeFile componentsSeparatedByString:@"/"];
        [HttpManage uploadfile:madeFile name:[names lastObject] cb:^(BOOL isOK, NSString *URL) {
            if (isOK) {
                isBgsend = YES;
                [self uploadFile];
            } else {
                [[waitingView sharedwaitingView] stopWait];
                [TalkingData trackEvent:@"上传素材失败"];
                [[StatusBar sharedStatusBar] talkMsg:@"上传模板图片失败了，再试一次吧" inTime:0.8];
            }
        }];
    }
}
-(void)uploadHead{
    if ([self.typeid compare:@"4"] == NSOrderedSame) {
        NSArray *names = [headFile componentsSeparatedByString:@"/"];
        [HttpManage uploadfile:headFile name:[names lastObject] cb:^(BOOL isOK, NSString *URL) {
            if (isOK) {
                [self uploadFile];
            } else {
                [[waitingView sharedwaitingView] stopWait];
                [TalkingData trackEvent:@"上传素材失败"];
                [[StatusBar sharedStatusBar] talkMsg:@"上传封面图片失败了，再试一次吧" inTime:0.8];
            }
        }];
    } else {
        [self uploadMade];
    }
}
-(void)sendTap{
    if ([self checkAndsaveInput]) {
        sendtaped = YES;
        [[waitingView sharedwaitingView] waitByMsg:@"正在上传素材，请稍候。" haveCancel:NO];
        [self uploadHead];
    }
}
-(void)saveTap{
    if ([self checkAndsaveInput]) {
        sendtaped = NO;
        [[waitingView sharedwaitingView] waitByMsg:@"正在上传素材，请稍候。" haveCancel:NO];
        [self uploadHead];
    }
}

@end
