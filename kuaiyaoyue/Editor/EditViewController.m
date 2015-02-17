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
@interface EditViewController ()

@end

@implementation EditViewController
-(void)initDate{
    timeDouble = -1;
    endtimeDouble = -1;
    isEndTime = NO;
    musicURL = @"";
    tipCount = 70;
    isHead = NO;
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
        
        UIView* showBg = [[UIView alloc] initWithFrame:CGRectMake(467.0, 21.0, mainScreenFrame.size.width-467.0, mainScreenFrame.size.height-20.0)];
        showBg.backgroundColor = [UIColor clearColor];
        showBg.tag = 141;
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
    [self initOldInput];
    [self initPreView];
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
    if([self.typeid compare:@"4"] == NSOrderedSame) {//自定义
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
        manInput.clearButtonMode = UITextFieldViewModeWhileEditing;
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
        wemanInput.clearButtonMode = UITextFieldViewModeWhileEditing;
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
            tipCount = 50;
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
    if ([self.typeid compare:@"4"] == NSOrderedSame) {
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
        UIView* picsView = [[UIView alloc] initWithFrame:CGRectMake(0, ch, w, 86.0/2.0+180+6.0)];
        [self addItemBg2View:picsView WithType:1 andTap:229 andIcon:@"ic_c_pics@2x"];
        UILabel* andn = [[UILabel alloc] initWithFrame:CGRectMake(iconWidth, 0, w, 86.0/2.0)];
        andn.font = [UIFont systemFontOfSize:14];
        andn.backgroundColor = [UIColor clearColor];
        andn.text=@"页面预览与编辑";
        [picsView addSubview:andn];
        ch += 86.0/2.0+180.0+6.0+12.0;
        UIView* showBg = [[UIView alloc] initWithFrame:CGRectMake(0.0, 86.0/2.0, w, 180)];
        showBg.backgroundColor = [UIColor clearColor];
        showBg.tag = 141;
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
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
        timeDouble = time;
        timeInput.text = [dateFormatter stringFromDate:date];
        if (time < endtimeDouble || endtimeDouble < 0) {
            endtimeDouble = time;
            endtimeInput.text = [dateFormatter stringFromDate:date];
        }
        return YES;
    } else {
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
- (void)textViewDidChange:(UITextView *)textView{
    long max = 70;
    if ([self.typeid compare:@"4"] == NSOrderedSame) {
        max = 50;
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
        //        for (int i = 0; i < items.count; i++)
        //        {
        //            ALAsset* al = [items objectAtIndex:i];
        //            UIImage *img = [assert getImageFromAsset:al type:ASSET_PHOTO_SCREEN_SIZE];
        //            GridInfo *info = [[GridInfo alloc] initWithDictionary:YES :img];
        //            [data addObject:info];
        //        }
        //
        //        for (int j = 0;j< [data count] ; j++) {
        //            GridInfo *info = [data objectAtIndex:j];
        //            if (!info.is_open) {
        //                [data removeObject:info];
        //            }
        //        }
        //
        //        GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
        //        [data addObject:info];
        //        [gridview reloadData];
        //        count -= items.count;
        //
        //        //   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
        //        [UIView animateWithDuration:0.3 animations:^{
        //            [self sethigh];
        //        }];
    }
}
#pragma mark - 录音
#pragma mark - PreviewViewControllerDelegate
-(void)didSelectID:(NSString*)index andNefmbdw:(NSString*)nefmbdw{
    
}
-(void)didSendType:(int) type{
    
}
#pragma mark - ipad 模版
-(void)initPreView{
    //    UIView* showBg = [self.view viewWithTag: 141];
    //    CGRect r = showBg.frame;
    //    CGFloat w = r.size.width;
    //    CGFloat h = r.size.height;
    //    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    //        CGFloat itemW = 120.0;
    //        CGFloat itemH = 180.0;
    //        UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(6.0 + (itemW+6.0)*0.0, 0.0, itemW, itemH)];
    //        bg.backgroundColor = [UIColor blueColor];
    //        [showBg addSubview:bg];
    //        UIView* bg1 = [[UIView alloc] initWithFrame:CGRectMake(6.0 + (itemW+6.0)*1.0, 0.0, itemW, itemH)];
    //        bg1.backgroundColor = [UIColor blueColor];
    //        [showBg addSubview:bg1];
    //        UIView* bg2 = [[UIView alloc] initWithFrame:CGRectMake(6.0 + (itemW+6.0)*2.0, 0.0, itemW, itemH)];
    //        bg2.backgroundColor = [UIColor blueColor];
    //        [showBg addSubview:bg2];
    //    } else {
    //        CGFloat itemW = 200.0;
    //        CGFloat itemH = 200.0/320.0*480.0;
    //        UIView* hbg = [[UIView alloc] initWithFrame:CGRectMake(0, (h-itemH)/2.0, w, itemH)];
    //        hbg.backgroundColor = [UIColor blueColor];
    //        [showBg addSubview:hbg];
    //        UIView* sbg = [[UIView alloc] initWithFrame:CGRectMake(32.0, 0, itemW, h)];
    //        sbg.backgroundColor = [UIColor redColor];
    //        [showBg addSubview:sbg];
    //
    //        UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(32.0 + (itemW+16.0)*0.0, (h-itemH)/2.0, itemW, itemH)];
    //        bg.backgroundColor = [UIColor yellowColor];
    //        [showBg addSubview:bg];
    //        UIView* bg1 = [[UIView alloc] initWithFrame:CGRectMake(32.0 + (itemW+16.0)*1.0, (h-itemH)/2.0, itemW, itemH)];
    //        bg1.backgroundColor = [UIColor yellowColor];
    //        [showBg addSubview:bg1];
    //        UIView* bg2 = [[UIView alloc] initWithFrame:CGRectMake(32.0 + (itemW+16.0)*2.0, (h-itemH)/2.0, itemW, itemH)];
    //        bg2.backgroundColor = [UIColor yellowColor];
    //        [showBg addSubview:bg2];
    //    }
}
#pragma mark - 数据操作
-(void)initOldInput{
    
}
-(void)saveInput{
    
}
-(void)reviewTap{
    
}
-(void)sendTap{
    
}
-(void)saveTap{
    
}

@end