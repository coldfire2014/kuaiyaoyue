//
//  HLEditViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "HLEditViewController.h"
#import "GridInfo.h"
#import "PhotoCell.h"
#import "picViewAnimate.h"
#import "ImgCollectionViewController.h"
#import "DatetimeInput.h"
#import "TimeTool.h"
#import "FileManage.h"
#import "DataBaseManage.h"
#import "NSInfoImg.h"
#import "Info.h"
#import "Fixeds.h"
#import "UDObject.h"
#import "HttpManage.h"
#import "StatusBar.h"
#import "MusicViewController.h"
#import "HLEditView.h"
#import "PreviewViewController.h"
#import "TalkingData.h"
#import "waitingView.h"
@interface HLEditViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate,datetimeInputDelegate,MVCDelegate,HLEVDelegate>{
    int count;
    NSMutableArray *imgdata;
    //
    NSMutableArray *addimg;
    int row_index;
    
    AssetHelper* assert;
    NSString *hltime;
    NSString *bmendtime;
    BOOL time_type;
    
    UICollectionView *gridview;
    UIScrollView *scrollview;
    HLEditView *hlev;
    
    NSString *xl_name;
    NSString *xn_name;
    NSString *address_name;
    NSString *mp3url;
    NSString *mp3name;
    
    BOOL is_yl;
    
    BOOL is_bcfs;

}

@end

@implementation HLEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"编辑";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setTintColor:color];
    
    imgdata = [[NSMutableArray alloc] init];
    _data = [[NSMutableArray alloc] init];
    assert = ASSETHELPER;
    assert.bReverse = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleBordered target:self action:@selector(RightBarBtnClicked:)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self addview];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([PhotoCell class]) bundle:nil];
    [gridview registerNib:nib forCellWithReuseIdentifier:@"PhotoCell"];
    [self getHistorical];
    
    _send_view.userInteractionEnabled = YES;
    _sendshare_view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(send_onclick:)];
    
    [_send_view addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendandshare_onclick:)];
    
    [_sendshare_view addGestureRecognizer:tap1];
}

-(void)changeHigh{
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

-(void)RightBarBtnClicked:(id)sender{
    //preview
    is_yl = NO;
    [self SendUp];
    [TalkingData trackEvent:@"预览" label:@"婚礼"];
}

-(void)addview{
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 50 - 64)];
    scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollview];
    
    hlev = [[[NSBundle mainBundle] loadNibNamed:@"HLEditView" owner:self options:nil] firstObject];
    hlev.frame = CGRectMake(0, 0, self.view.frame.size.width, hlev.frame.size.height);
    hlev.backgroundColor = [UIColor clearColor];
    hlev.delegate = self;
    hlev.xl_edit.delegate = self;
    hlev.address_edit.delegate = self;
    hlev.xn_edit.delegate = self;
    
    gridview = hlev.gridview;
    gridview.delegate = self;
    gridview.dataSource = self;
    scrollview.delegate = self;
    [scrollview addSubview:hlev];
    
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, 665)];
    
}

-(void)getHistorical{
    mp3name = @"";
    mp3url = @"";
    count = 9;
    if ([UDObject getxl_name].length > 0) {
        hlev.xl_edit.text = [UDObject getxl_name];
        hlev.xn_edit.text = [UDObject getxn_name];
        hltime = [UDObject gethltime];
        bmendtime = [UDObject getbmendtime];
        hlev.hltime_label.text = [TimeTool getFullTimeStr:[hltime doubleValue]/1000.0];
        hlev.bmend_label.text = [TimeTool getFullTimeStr:[bmendtime doubleValue]/1000.0];
        hlev.address_edit.text = [UDObject getaddress_name];
        if ([UDObject gethlmusic].length > 0) {
            mp3name = [UDObject gethlmusicname];
            hlev.music_label.text = mp3name;
            mp3url = [UDObject gethlmusic];
            [hlev.del_music_view setHidden:NO];
        }
        NSArray *arr = [[UDObject gethlimgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
        NSString *name = @"";
        if ([arr count] > 0) {
            name = [arr objectAtIndex:0];
        }
        if (name.length > 0) {
        
        for (NSString *name in arr) {
           
            NSArray *array = [name componentsSeparatedByString:@"/"];
            NSString *imgname = [array objectAtIndex:([array count] - 1)];
            NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: imgname];            
            UIImage *img = [[UIImage alloc]initWithContentsOfFile:imgpath];
            GridInfo *info = [[GridInfo alloc] initWithDictionary:YES :img];
            [_data addObject:info];
        }
        count -= [arr count];
        }
    }
    [self initImgData];
}
-(void)didBack{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    is_yl = YES;
    [self.navigationController.navigationBar setHidden:NO];
    [TalkingData trackPageBegin:@"婚礼编辑"];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"婚礼编辑"];
}

-(void)initImgData{
    GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
    [_data addObject:info];
    [gridview reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"imgSelect"] == NSOrderedSame ) {
//        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
//        des.maxCount = count;
//        des.needAnimation = NO;
//        des.delegate = self;
    }else if ([segue.identifier compare:@"preview"] == NSOrderedSame){
//        PreviewViewController *view = (PreviewViewController*)segue.destinationViewController;
//        view.type = 0;
//        view.delegate = self;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.data count] > 9) {
        return 9;
    }else{
        return [self.data count];
    }
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((gridview.frame.size.width - 2*9)/3, (gridview.frame.size.width - 2*9)/3);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridInfo *info = [self.data objectAtIndex:[indexPath row]];
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.index = [indexPath row];
    cell.delegate = self;
    
//    cell.add_view.backgroundColor = self.nowkColor;
    if (info.is_open) {
        [cell.del_button setHidden:NO];
        cell.show_img.image = info.img;
        cell.show_img.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            cell.show_img.alpha = 1;
        }];
    }else{
        [cell.del_button setHidden:YES];
        cell.show_img.image = nil;
    }
    
    cell.show_img.clipsToBounds = YES;
    cell.show_img.contentMode = UIViewContentModeScaleAspectFill;
    
    hlev.bottomview.clipsToBounds = YES;
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GridInfo *info = [self.data objectAtIndex:[indexPath row]];
    if (!info.is_open) {
        [self.view endEditing:NO];
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 0.0;
        ImgCollectionViewController* des = [[ImgCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        des.maxCount = count;
        des.needAnimation = NO;
        des.delegate = self;
//        des.transitioningDelegate = self;
//        des.modalPresentationStyle = UIModalPresentationCustom;
        des.modalPresentationStyle = UIModalPresentationFormSheet;
        des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:des animated:YES completion:^{
            
        }];
    }else{
    }
}

- (void)PhotoCellDelegate:(PhotoCell *)cell didTapAtIndex:(long ) index{
    GridInfo *info = [self.data objectAtIndex:index];
    [_data removeObject:info];
    [gridview reloadData];
    count ++;
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

-(void)didSelectAssets:(NSArray*)items{
    NSLog(@"%@",items);
    for (int i = 0; i < items.count; i++)
    {
        ALAsset* al = [items objectAtIndex:i];
        UIImage *img = [assert getImageFromAsset:al type:ASSET_PHOTO_SCREEN_SIZE];
        GridInfo *info = [[GridInfo alloc] initWithDictionary:YES :img];
        [self.data addObject:info];
    }
    
    for (int j = 0;j< [self.data count] ; j++) {
        GridInfo *info = [self.data objectAtIndex:j];
        if (!info.is_open) {
            [self.data removeObject:info];
        }
    }
    
    GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
    [self.data addObject:info];
    [gridview reloadData];
    count -= items.count;
    
//   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

-(void)sethigh{
    long index = [_data count];
    long height = 43 + (gridview.frame.size.width - 2*9)/3 + 9 + 10;
    long addheight = (gridview.frame.size.width - 2*9)/3 + 9;
    if (index <= 3) {
        hlev.bottomview.frame = CGRectMake(hlev.bottomview.frame.origin.x, hlev.bottomview.frame.origin.y, hlev.bottomview.frame.size.width, height);
        hlev.gridview.frame = CGRectMake(hlev.gridview.frame.origin.x, hlev.gridview.frame.origin.y, hlev.gridview.frame.size.width, addheight);
        
    }else if(index > 3 && index <= 6){
        hlev.bottomview.frame = CGRectMake(hlev.bottomview.frame.origin.x, hlev.bottomview.frame.origin.y, hlev.bottomview.frame.size.width, height+addheight);
        hlev.gridview.frame = CGRectMake(hlev.gridview.frame.origin.x, hlev.gridview.frame.origin.y, hlev.gridview.frame.size.width, addheight*2);
    }else if(index > 6){
        hlev.bottomview.frame = CGRectMake(hlev.bottomview.frame.origin.x, hlev.bottomview.frame.origin.y, hlev.bottomview.frame.size.width, height+addheight*2);
        hlev.gridview.frame = CGRectMake(hlev.gridview.frame.origin.x, hlev.gridview.frame.origin.y, hlev.gridview.frame.size.width, addheight*3);
    }
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width,hlev.bottomview.frame.origin.y + hlev.bottomview.frame.size.height + 50)];
}

//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    NSRange r = [[dismissed.classForCoder description] rangeOfString:@"ImgCollectionViewController"];
//    if (r.length > 0 ) {
//        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:NO];
//        return ca;
//    } else {
//    }
//    return nil;
//}
//
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    NSString* name = [presented.classForCoder description];
//    NSRange r = [name rangeOfString:@"ImgCollectionViewController"];
//    if (r.length > 0 ) {
//        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:YES];
//        return ca;
//    } else {
//    }
//    return nil;
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:NO];
}

- (void)HLEVDelegate:(HLEditView *)cell didTapAtIndex:(int) type{
    if (type == 0) {
        time_type = YES;
        [self.view endEditing:NO];
        NSDate* itime = [NSDate date];
        if (hltime != nil) {
            itime = [NSDate dateWithTimeIntervalSince1970:[hltime doubleValue]/1000.0];
        }
        [[DatetimeInput sharedDatetimeInput] setTime:itime andMaxTime:nil andMinTime:[NSDate date]];
        [DatetimeInput sharedDatetimeInput].time_delegate = self;
        [[DatetimeInput sharedDatetimeInput] show];
    }else if (type == 1){
        [self.view endEditing:NO];
        NSDate* itime = [NSDate date];
        if (bmendtime != nil) {
            itime = [NSDate dateWithTimeIntervalSince1970:[bmendtime doubleValue]/1000.0];
        }
        if (hltime != nil) {
            time_type = NO;
            NSDate * date=[NSDate dateWithTimeIntervalSince1970:([hltime doubleValue]/1000.0)];
            [[DatetimeInput sharedDatetimeInput] setTime:itime andMaxTime:date andMinTime:[NSDate date]];
            [DatetimeInput sharedDatetimeInput].time_delegate = self;
            [[DatetimeInput sharedDatetimeInput] show];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入婚礼时间。" inTime:0.8];
        }
        
    }else if (type == 2){
        MusicViewController *des = [[MusicViewController alloc] init];
        des.delegate = self;
        des.typeid = @"1";
        des.modalPresentationStyle = UIModalPresentationFormSheet;
        des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:des animated:YES completion:^{
            
        }];
    }else if (type == 3){
        mp3url = @"";
        mp3name = @"";
        hlev.music_label.text = @"";
        [hlev.del_music_view setHidden:YES];
    }
}
- (BOOL)didSelectDateTime:(NSTimeInterval)time{
    if (time_type) {
        if (time*1000.0 > [bmendtime doubleValue]) {
            NSArray* time_s = [[[NSString alloc] initWithFormat:@"%f",time*1000.0] componentsSeparatedByString:@"."];
            hltime = [time_s objectAtIndex:0];
            hlev.hltime_label.text = [TimeTool getFullTimeStr:time];
            return YES;
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"婚礼时间不能小于报名截止时间" inTime:0.8];
            return NO;
        }
    } else {
        NSArray* time_s = [[[NSString alloc] initWithFormat:@"%f",time*1000.0] componentsSeparatedByString:@"."];
        bmendtime = [time_s objectAtIndex:0];
        hlev.bmend_label.text = [TimeTool getFullTimeStr:time];
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
    }
    if (textField == hlev.address_edit) {
        [UIView animateWithDuration:0.3 animations:^{
            [scrollview setContentOffset:CGPointMake(0, 150)];
        }];
    }
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    if (textField == hlev.xl_edit || textField ==hlev.xn_edit) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//    }else if (textField == hlev.address_edit){
//        if (textField.text.length > 30) {
//            textField.text = [textField.text substringToIndex:30];
//        }
//    }
//    return YES;
//}

- (void)send_onclick:(UITapGestureRecognizer *)gr{
    is_bcfs = NO;
    [self SendUp];
}

- (void)sendandshare_onclick:(UITapGestureRecognizer *)gr{
    is_bcfs = YES;
    [self SendUp];
}

- (void)MVCDelegate:(MusicViewController *)cell didTapAtIndex:(NSString *) url :(NSString *)name{
    mp3url = url;
    mp3name = name;
    hlev.music_label.text = name;
    [hlev.del_music_view setHidden:NO];
}


-(void)SendUp{
    
    xl_name = hlev.xl_edit.text;
    xn_name = hlev.xn_edit.text;
    address_name = hlev.address_edit.text;
    
    if (xl_name.length > 0 && xn_name.length > 0 && hltime.length > 0 && bmendtime.length > 0 && address_name.length > 0) {
        if (xl_name.length < 5 && xn_name.length < 5) {
            if (address_name.length < 20) {
                [self setbg];
            }else{
                [[StatusBar sharedStatusBar] talkMsg:@"地址不能超过20个字" inTime:1.5];
            }
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"新娘和新娘名字不能超过5个字" inTime:1.5];
        }
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"内容不能为空" inTime:1.5];
    }
    
}

-(void)setbg{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *urlpath = [documentsDirectory stringByAppendingString:_nefmbdw];
    UIImage *bgimg = [self getimg:urlpath];
    [self upmbdt:bgimg];
}

-(UIImage *)getimg :(NSString *) str{
    NSArray *dataarray = [[DataBaseManage getDataBaseManage] GetInfo:_unquieId];
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
        NSString *rgb = info.neffontcolor;
        NSString *a = [rgb substringToIndex:3];
        a = [a substringFromIndex:1];
        CGFloat b = strtoul([a UTF8String],0,16);
        NSString *c = [rgb substringToIndex:5];
        c = [c substringFromIndex:3];
        CGFloat d = strtoul([c UTF8String],0,16);
        NSString *f = [rgb substringFromIndex:5];
        CGFloat e = strtoul([f UTF8String],0,16);
        CGFloat size = [info.neffontsize floatValue];
        
        red1 = b;
        green1 = d;
        blue1 = e;
        
        if ([parameterName isEqualToString:@"marryName"]) {
            NSString *name = [NSString stringWithFormat:@"%@ & %@",hlev.xl_edit.text,hlev.xn_edit.text];
            [infodata addInfoWithValue:name andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }else if ([parameterName isEqualToString:@"timestamp"]) {
            
            [infodata addInfoWithValue:hlev.hltime_label.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
            
        }else if ([parameterName isEqualToString:@"address"]) {
            
            [infodata addInfoWithValue:hlev.address_edit.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }
    }
    NSArray *fixeds = [[DataBaseManage getDataBaseManage] GetFixeds:_unquieId];
    for (Fixeds *info in fixeds) {
        CGFloat x = info.nefX;
        CGFloat y = info.nefY;
        CGFloat w = info.nefWidth;
        CGFloat h = info.nefHeight;
        CGFloat size = info.nefFontSize;
        [infodata addInfoWithValue:info.nefContent andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
    }
    UIImage *bgimg = [infodata getSaveImg :YES];
    return bgimg;
}

-(void)upmbdt:(UIImage *)img{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    addimg = [[NSMutableArray alloc] init];
    [UDObject setMbimg:[NSString stringWithFormat:@"../Image/%@",uuid]];
    [UIImageJPEGRepresentation(img,C_JPEG_SIZE) writeToFile:imgpath atomically:YES];
    
    if (is_yl) {
        if(is_bcfs){
            [TalkingData trackEvent:@"生成并发送"];
        }else{
            [TalkingData trackEvent:@"生成"];
        }
        [[waitingView sharedwaitingView] waitByMsg:@"正在上传素材，请稍候。" haveCancel:NO];
        [HttpManage uploadTP:img name:uuid cb:^(BOOL isOK, NSString *URL) {
            NSLog(@"%@",URL);
            if (isOK) {
                imgdata = [[NSMutableArray alloc] init];
                if ([_data count] - 1 > 0) {
                    row_index = 0;
                    GridInfo *info = [_data objectAtIndex:row_index];
                    [self postuploadHL:info.img :URL] ;
                }else{
                    NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                    [self marry:_unquieId :xn_name :xl_name :address_name :arr :hltime :URL :mp3url :bmendtime];
                }
            }else{
                [[waitingView sharedwaitingView] stopWait];
                [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.5];
            }
        }];
    }else{
        if ([_data count] - 1 > 0) {
            for (int i = 0; i < [_data count] - 1; i++) {
                GridInfo *info = [_data objectAtIndex:i];
                CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
                NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
                uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
                NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
                [UIImageJPEGRepresentation(info.img,C_JPEG_SIZE) writeToFile:imgpath atomically:YES];
                
                [addimg addObject:[NSString stringWithFormat:@"../Image/%@",uuid]];
            }
        }
        NSArray *arr = [[NSArray alloc] initWithArray:addimg];
        NSString *hlarr = [arr componentsJoinedByString:@","];
        [UDObject setHLContent:xl_name xn_name:xn_name hltime:hltime bmendtime:bmendtime address_name:address_name music:mp3url musicname:mp3name imgarr:hlarr];
        PreviewViewController *view = [[PreviewViewController alloc] init];
        view.type = 0;
        view.delegate = self;
        view.modalPresentationStyle = UIModalPresentationFormSheet;
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:^{
            
        }];
    }
}



-(void)postuploadHL :(UIImage *) img :(NSString *)URL{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    [addimg addObject:[NSString stringWithFormat:@"../Image/%@",uuid]];
    [UIImageJPEGRepresentation(img,C_JPEG_SIZE) writeToFile:imgpath atomically:YES];
    [HttpManage uploadTP:img name:uuid  cb:^(BOOL isOK, NSString *arry) {
        if (isOK) {
            //解析服务器图片名称
            [imgdata addObject:arry];
            row_index ++;
            if (row_index > [_data count] - 2) {
                 NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                [self marry:_unquieId :xn_name :xl_name :address_name :arr :hltime :URL :mp3url :bmendtime];
                
            }else{
                GridInfo *info = [_data objectAtIndex:row_index];
                [self postuploadHL:info.img :URL];
            }
        }else{
            [[waitingView sharedwaitingView] stopWait];
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.5];
        }
    }];
}

-(void)marry:(NSString *) unquieId :(NSString *) bride :(NSString *) groom :(NSString *) address :(NSArray *) images :(NSString *) timestamp :(NSString *)background :(NSString *)musicUrl :(NSString *)closeTimestamp{
    if (musicUrl.length > 0) {}else{
        musicUrl = @"";
    }
    [[waitingView sharedwaitingView] changeWord:@"正在努力制作中……"];
    [HttpManage marry:[UDObject gettoken] bride:bride groom:groom address:address location:nil images:images timestamp:timestamp background:background musicUrl:musicUrl closeTimestamp:closeTimestamp mid:unquieId cb:^(BOOL isOK, NSDictionary *dic) {
        if (isOK) {
            NSArray *arr = [[NSArray alloc] initWithArray:addimg];
            NSString *hlarr = [arr componentsJoinedByString:@","];
            [UDObject setHLContent:xl_name xn_name:xn_name hltime:hltime bmendtime:bmendtime address_name:address_name music:musicUrl musicname:mp3name imgarr:hlarr];
            [self GetRecord];
            [[waitingView sharedwaitingView] stopWait];
            [[StatusBar sharedStatusBar] talkMsg:@"生成成功" inTime:0.3];
        }else{
            [[waitingView sharedwaitingView] stopWait];
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.5];
        }
    }];
}

-(void)GetRecord{
    [HttpManage multiHistory:[UDObject gettoken] timestamp:@"-1" size:@"1" cb:^(BOOL isOK, NSDictionary *array) {
        NSLog(@"%@",array);
        if (isOK) {
            NSArray *customList = [array objectForKey:@"customList"];
            for (NSDictionary *dic in customList) {
                BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                if (!is_bcz) {
                    [[DataBaseManage getDataBaseManage] AddUserdata:dic type:0];
                }
            }
            NSArray *marryList = [array objectForKey:@"marryList"];
            for (NSDictionary *dic in marryList) {
                BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                if (!is_bcz) {
                    [[DataBaseManage getDataBaseManage] AddUserdata:dic type:1];
                }
            }
            NSArray *partyList = [array objectForKey:@"partyList"];
            for (NSDictionary *dic in partyList) {
                BOOL is_bcz = [[DataBaseManage getDataBaseManage] GetUpUserdata:dic];
                if (!is_bcz) {
                    [[DataBaseManage getDataBaseManage] AddUserdata:dic type:2];
                }
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            if (is_bcfs) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_BCFS" object:self userInfo:nil];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_FS" object:self userInfo:nil];
            }
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_FS" object:self userInfo:nil];
        }
    }];
}


-(void)didSelectID:(NSString*)index andNefmbdw:(NSString*)nefmbdw{
    self.unquieId = index;
    self.nefmbdw = nefmbdw;
}

-(void)didSendType:(int) type{
    if (type == 0) {
        is_yl = YES;
        is_bcfs = NO;
        [self SendUp];
    }else{
        is_yl = YES;
        is_bcfs = YES;
        [self SendUp];
    }
}

@end
