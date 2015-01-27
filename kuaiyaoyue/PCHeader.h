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

#define YINGLOU @"YINGLOU"
#ifdef YINGLOU
    #define YINGLOUURL @"http://test.kyy121.com/studio/"
    #define HTTPURL @"http://test.kyy121.com/studio/"
    #define ChannelId @"Studio"
    #define UZIP @"ZIPS201"
#else
    #define YINGLOUURL @""
    #define HTTPURL @"http://appkyy.kyy121.com/invitation/"
//    #define ChannelId @"AppStore"
    #define ChannelId @"inhouse"
    #define UZIP @"ZIP201"
#endif
//#define HTTPURL @"http://test.kyy121.com/"
//#define HTTPURL @"http://10.142.59.103/"
#define version @"4"

#endif
