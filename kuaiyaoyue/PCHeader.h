//
//  PCHeader.h
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/18.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#ifndef kuaiyaoyue_PCHeader_h
#define kuaiyaoyue_PCHeader_h

#define ISIOS7LATER [[[UIDevice currentDevice] systemVersion] floatValue]>=7
#define ISIOS8LATER [[[UIDevice currentDevice] systemVersion] floatValue]>=8
#define QNTOKEN @"http://appkyy.kyy121.com/oss/upload/getClientDto"
#define QNPCI @"http://7vili3.com2.z0.glb.qiniucdn.com/"
#define TJ_URL @"http://www.baidu.com/"
#define TJ_TITLE @"推荐"
//#define YINGLOU @"YINGLOU"
#ifdef YINGLOU
    #define YINGLOUURL @"http://appkyy.kyy121.com/studio/"
    #define HTTPURL YINGLOUURL
    #define ChannelId @"Studio"
    #define UZIP @"ZIPS211"
    #define DURL @"http://fir.im/kyyyl"
    #define STOREDIR @"http://appkyy.kyy121.com/static/feedback.html?appId=kuaiyaoyue-snapshot"
    #define PIC_URL @"http://www.kyy121.com/fss/studio/"
#else
    #define YINGLOUURL @""
    #define HTTPURL @"http://appkyy.kyy121.com/invitation/"
//#define HTTPURL @"http://10.142.59.104/invitation/"
    #define ChannelId @"AppStore"
//    #define ChannelId @"test"
    #define UZIP @"ZIP211"
    #define DURL @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=927884233&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
    #define STOREDIR @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=927884233&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
    #define PIC_URL @"http://www.kyy121.com/fss/invitation/"
#endif
//#define version @"5"
#define version @"4"
#define IPAD_FRAME CGRectMake(0, 0, MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width),MIN([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width))
#endif
