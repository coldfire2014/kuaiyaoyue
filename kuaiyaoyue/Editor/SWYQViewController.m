//
//  SWYQViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "SWYQViewController.h"
#import "GridInfo.h"
#import "PhotoCell.h"
#import "picViewAnimate.h"
#import "ImgCollectionViewController.h"
#import "ShowData.h"
#import "TimeTool.h"
#import "FileManage.h"
#import "DataBaseManage.h"
#import "NSInfoImg.h"
#import "Info.h"
#import "Fixeds.h"
#import "UDObject.h"
#import "HttpManage.h"
#import "StatusBar.h"
#import "MoreView.h"
#import "MusicViewController.h"
#import "PreviewViewController.h"
#import "TalkingData.h"

@interface SWYQViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate,SDDelegate,MVCDelegate,MVDelegate>{
    BOOL is_yl;
    int count;
    MoreView *moreview;
    NSMutableArray *addimg;
    int row_index;
    
    AssetHelper* assert;
    ShowData *show;
    NSString *hltime;
    NSString *bmendtime;
    BOOL time_type;
    
    UICollectionView *gridview;
    
    UIScrollView *scrollview;
    NSMutableArray *data;
    NSMutableArray *imgdata;
    
    NSString *jh_name;
    NSString *address_name;
    NSString *xlr_name;
    NSString *xxfs_name;
    NSString *hdjj_name;
    
    NSString *mp3url;
    NSString *mp3name;
    
    BOOL is_bcfs;
    BOOL is_bottom;
}

@end

@implementation SWYQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    is_bottom = YES;
    self.title = @"返回";
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"编辑";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setTintColor:color];
    
    assert = ASSETHELPER;
    assert.bReverse = YES;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleBordered target:self action:@selector(RightBarBtnClicked:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    imgdata = [[NSMutableArray alloc] init];
    data = [[NSMutableArray alloc] init];
    
    [self addview];
    
    moreview.xlr_edit.text = [UDObject getXM];
    moreview.xlfs_edit.text = [UDObject getLXFS];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([PhotoCell class]) bundle:nil];
    [gridview registerNib:nib forCellWithReuseIdentifier:@"PhotoCell"];
    [self getHistorical];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    
    _send_view.userInteractionEnabled = YES;
    _sendshare_view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(send_onclick:)];
    
    [_send_view addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendandshare_onclick:)];
    
    [_sendshare_view addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editviewonclick:)];
    
    [moreview.editview addGestureRecognizer:tap2];
    
}

- (void)editviewonclick:(UITapGestureRecognizer *)gr{
    [self.view endEditing:NO];
    [moreview.editview setHidden:YES];
}

-(void)changeHigh{
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:NO];
}

-(void)addview{
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 50 - 64)];
    scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollview];
    
    moreview = [[[NSBundle mainBundle] loadNibNamed:@"MoreView" owner:self options:nil] firstObject];
    moreview.frame = CGRectMake(0, 0, self.view.frame.size.width, moreview.frame.size.height);
    moreview.backgroundColor = [UIColor clearColor];
    moreview.delegate = self;
    moreview.jh_edit.delegate = self;
    moreview.address_edit.delegate = self;
    moreview.xlr_edit.delegate = self;
    moreview.xlfs_edit.delegate = self;
    moreview.show_summary.delegate = self;
    
    
    gridview = moreview.girdview;
    gridview.delegate = self;
    gridview.dataSource = self;
    scrollview.delegate = self;
    [scrollview addSubview:moreview];
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, 665)];
    
    NSString* name = @"ShowData";
    show = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] firstObject];
    show.delegate = self;
    show.center = CGPointMake( self.view.frame.size.width/2.0,  self.view.frame.size.height*3.0/2.0);
    show.backgroundColor = [UIColor clearColor];
    [self.view addSubview:show];
}

-(void)getHistorical{
    mp3name = @"";
    mp3url = @"";
    count = 9;
    if ([UDObject getjhname].length > 0) {
        moreview.jh_edit.text = [UDObject getjhname];
        hltime = [UDObject getswtime];
        bmendtime = [UDObject getswbmendtime];
        moreview.time_label.text = [TimeTool getFullTimeStr:[hltime longLongValue]/1000];
        moreview.bmtime_label.text = [TimeTool getFullTimeStr:[bmendtime longLongValue]/1000];
        moreview.address_edit.text = [UDObject getswaddress_name];
        moreview.xlr_edit.text = [UDObject getswxlr_name];
        moreview.xlfs_edit.text = [UDObject getswxlfs_name];
        moreview.show_summary.text = [UDObject getswhd_name];
        long num = 70 - moreview.show_summary.text.length;
        moreview.text_label_num.text = [NSString stringWithFormat:@"剩余%ld字",num];
        
        if (num > 0) {
            [moreview.text_label_num setTextColor:[UIColor lightGrayColor]];
        }else{
            [moreview.text_label_num setTextColor:[UIColor redColor]];
        }
        
        if ([UDObject getsw_music].length > 0) {
            mp3name = [UDObject getsw_musicname];
            moreview.show_music.text = mp3name;
            mp3url = [UDObject getsw_music];
            [moreview.del_music_view setHidden:NO];
        }
        NSArray *arr = [[UDObject getsw_imgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
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
            [data addObject:info];
        }
        count -= [arr count];
        }
        
    }
    [self initImgData];
}


-(void)sethigh{
    long index = [data count];
    long height = 130 + 45 + (gridview.frame.size.width - 2*9)/3 + 9;
    long addheight = (gridview.frame.size.width - 2*9)/3 + 9;
    
    NSLog(@"%f",moreview.girdview.frame.origin.y);
    if (index <= 3) {
        moreview.bottom_view.frame = CGRectMake(0, moreview.bottom_view.frame.origin.y, moreview.bottom_view.frame.size.width, height);
        gridview.frame = CGRectMake(moreview.girdview.frame.origin.x, moreview.girdview.frame.origin.y, moreview.girdview.frame.size.width, addheight);
    }else if(index > 3 && index <= 6){
        moreview.bottom_view.frame = CGRectMake(0, moreview.bottom_view.frame.origin.y, moreview.bottom_view.frame.size.width, height+addheight);
        gridview.frame = CGRectMake(moreview.girdview.frame.origin.x, moreview.girdview.frame.origin.y, moreview.girdview.frame.size.width, addheight*2);
    }else if(index > 6){
        moreview.bottom_view.frame = CGRectMake(0, moreview.bottom_view.frame.origin.y, moreview.bottom_view.frame.size.width, height+addheight*2);
        gridview.frame = CGRectMake(moreview.girdview.frame.origin.x, moreview.girdview.frame.origin.y, moreview.girdview.frame.size.width, addheight*3);
    }
    
    moreview.music_view.frame = CGRectMake(moreview.music_view.frame.origin.x,gridview.frame.origin.y+gridview.frame.size.height, moreview.music_view.frame.size.width, moreview.music_view.frame.size.height);
    
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, moreview.bottom_view.frame.origin.y + moreview.bottom_view.frame.size.height+50)];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)RightBarBtnClicked:(id)sender{
    //preview
    is_yl = NO;
    [self SendUp];
    [TalkingData trackEvent:@"预览" label:@"商务"];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
    [TalkingData trackPageBegin:@"商务编辑"];
//    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, -1000)];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"商务编辑"];
}

-(void)initImgData{
    GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
    [data addObject:info];
    [gridview reloadData];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier compare:@"imgSelect"] == NSOrderedSame ) {
        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
        des.maxCount = count;
        des.needAnimation = NO;
        des.delegate = self;
    }else if ([segue.identifier compare:@"music"] == NSOrderedSame){
        MusicViewController *view = (MusicViewController*)segue.destinationViewController;
        view.delegate = self;
        view.typeid = @"2";
        
    }else if ([segue.identifier compare:@"preview"] == NSOrderedSame){
        PreviewViewController *view = (PreviewViewController*)segue.destinationViewController;
        view.delegate = self;
        view.type = 1;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([data count] > 9) {
        return 9;
    }else{
        return [data count];
    }
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((gridview.frame.size.width - 2*9)/3, (gridview.frame.size.width - 2*9)/3);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridInfo *info = [data objectAtIndex:[indexPath row]];
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
    
//    _bottomview.clipsToBounds = YES;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GridInfo *info = [data objectAtIndex:[indexPath row]];
    if (!info.is_open) {
        [self.view endEditing:NO];
        [self performSegueWithIdentifier:@"imgSelect" sender:nil];
    }else{
    }
}

- (void)PhotoCellDelegate:(PhotoCell *)cell didTapAtIndex:(long ) index{
    GridInfo *info = [data objectAtIndex:index];
    [data removeObject:info];
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
        [data addObject:info];
    }
    
    for (int j = 0;j< [data count] ; j++) {
        GridInfo *info = [data objectAtIndex:j];
        if (!info.is_open) {
            [data removeObject:info];
        }
    }
    
    GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
    [data addObject:info];
    [gridview reloadData];
    count -= items.count;
    
    //   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

- (void)MVDelegate:(MoreView *)cell didTapAtIndex:(int) type{
    
    if (type == 0) {
        time_type = YES;
        [self.view endEditing:NO];
        [show.picker setMaximumDate:nil];
        [UIView animateWithDuration:0.4f animations:^{
            show.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else if (type == 1){
        [self.view endEditing:NO];
        if (hltime != nil) {
            time_type = NO;
            NSDate * date=[NSDate dateWithTimeIntervalSince1970:([hltime longLongValue]/1000)];
            [show.picker setMaximumDate:date];
            [UIView animateWithDuration:0.4f animations:^{
                show.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
    }else if (type == 2){
        [self performSegueWithIdentifier:@"music" sender:nil];
    }else if (type == 3){
        mp3url = @"";
        mp3name = @"";
        moreview.show_music.text = @"";
        [moreview.del_music_view setHidden:YES];
    }else if (type == 4){
        //关
        if (is_bottom) {
            [moreview.bottom_view setHidden:NO];
            [UIView animateWithDuration:0.3 animations:^{
                [moreview.bottom_view setAlpha:1.0];
                [moreview.cb_button setImage:[UIImage imageNamed:@"ic_32_close"] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                
            }];
            
        }
        //开
        else{
            [UIView animateWithDuration:0.3 animations:^{
                [moreview.bottom_view setAlpha:0.0];
                [moreview.cb_button setImage:[UIImage imageNamed:@"ic_32_open"] forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                [moreview.bottom_view setHidden:YES];
            }];
            
            
        }
        is_bottom = !is_bottom;
    }
}

- (void)SDDelegate:(ShowData *)cell didTapAtIndex:(NSString *) timebh{
    if (timebh != nil) {
        if (time_type) {
            if ([timebh longLongValue] > [bmendtime longLongValue]) {
                hltime = timebh;
                moreview.time_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
            }else{
                [[StatusBar sharedStatusBar] talkMsg:@"时间不能小于报名截止时间" inTime:0.5];
            }
            
            
        }else{
            bmendtime = timebh;
            moreview.bmtime_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
        }
    }
    [UIView animateWithDuration:0.4f animations:^{
        show.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)MVCDelegate:(MusicViewController *)cell didTapAtIndex:(NSString *) url :(NSString *)name{
    mp3url = url;
    mp3name = name;
    moreview.show_music.text = name;
    [moreview.del_music_view setHidden:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
    }
    if (textField == moreview.xlr_edit || textField == moreview.xlfs_edit) {
        [UIView animateWithDuration:0.3 animations:^{
            [scrollview setContentOffset:CGPointMake(0, 150)];
        }];
    }
    
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    if (textField == moreview.jh_edit || textField == moreview.xlr_edit) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//    }else if (textField == moreview.address_edit){
//        if (textField.text.length > 30) {
//            textField.text = [textField.text substringToIndex:30];
//        }
//    }else if (textField == moreview.xlfs_edit){
//        if (textField.text.length > 11) {
//            textField.text = [textField.text substringToIndex:11];
//        }
//    }
//    return YES;
//}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [scrollview setContentOffset:CGPointMake(0, 290)];
    }];
    
    [moreview.editview setHidden:NO];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSLog(@"%d",textView.text.length);
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
//     if ([lang isEqualToString:@"zh-Hans"]) {
//         if(textView == moreview.show_summary){
//         UITextRange *selectedRange = [textView markedTextRange];
//         //获取高亮部分
//         UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
//         // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//         if (!position) {
//    unsigned long num = 70 - moreview.show_summary.text.length;
//    moreview.text_label_num.text = [NSString stringWithFormat:@"剩余%lu字",num];
//             if (num > 0) {
//                 [moreview.text_label_num setTextColor:[UIColor lightGrayColor]];
//             }else{
//                 [moreview.text_label_num setTextColor:[UIColor redColor]];
//             }
//         }
//        }
//         
//     }else{
//         if(textView == moreview.show_summary){
//             moreview.text_label_num.text = [NSString stringWithFormat:@"剩余%d字",70-textView.text.length];
//             int num = 70 - textView.text.length;
//             if (num > 0) {
//                 [moreview.text_label_num setTextColor:[UIColor lightGrayColor]];
//             }else{
//                 [moreview.text_label_num setTextColor:[UIColor redColor]];
//             }
//         }
//     }
    
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if(textView == moreview.show_summary){
        long num = 70 - textView.text.length;
        moreview.text_label_num.text = [NSString stringWithFormat:@"剩余%ld字",num];
        if (num > 0) {
            [moreview.text_label_num setTextColor:[UIColor lightGrayColor]];
        }else{
            [moreview.text_label_num setTextColor:[UIColor redColor]];
        }
    }

}

- (void)send_onclick:(UITapGestureRecognizer *)gr{
    is_yl = YES;
    is_bcfs = NO;
    [self SendUp];
}

- (void)sendandshare_onclick:(UITapGestureRecognizer *)gr{
    is_yl = YES;
    is_bcfs = YES;
    [self SendUp];
}

-(void)SendUp{
    jh_name = moreview.jh_edit.text;
    address_name = moreview.address_edit.text;
    xlr_name = moreview.xlr_edit.text;
    xxfs_name = moreview.xlfs_edit.text;
    
    if (jh_name.length > 0 && address_name.length > 0 && hltime.length > 0 && bmendtime.length > 0 && xlr_name.length > 0 && xxfs_name.length > 0) {
        if (jh_name.length > 11) {
            [[StatusBar sharedStatusBar] talkMsg:@"活动名称不得超过11个字" inTime:0.5];
            return;
        }
        if (address_name.length > 20) {
            [[StatusBar sharedStatusBar] talkMsg:@"地址不得超过20个字" inTime:0.5];
            return;
        }
        if (xlr_name.length > 5) {
            [[StatusBar sharedStatusBar] talkMsg:@"联系人不得超过5个字" inTime:0.5];
            return;
        }
        if (xxfs_name.length > 17) {
            [[StatusBar sharedStatusBar] talkMsg:@"联系方式不得超过17个字" inTime:0.5];
            return;
        }
        if (moreview.show_summary.text.length > 70) {
            [[StatusBar sharedStatusBar] talkMsg:@"活动简介不得超过70个字" inTime:0.5];
            return;
        }
        [self setbg];
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"内容不能为空" inTime:0.5];
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
        
        if ([parameterName isEqualToString:@"partyName"]) {
            
            [infodata addInfoWithValue:moreview.jh_edit.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
            
        }else if ([parameterName isEqualToString:@"timestamp"]) {
            
            [infodata addInfoWithValue:moreview.time_label.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
            
        }else if ([parameterName isEqualToString:@"address"]) {
            [infodata addInfoWithValue:moreview.address_edit.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }
        
        else if ([parameterName isEqualToString:@"description"]) {
            NSString *content = moreview.show_summary.text;
            if (content.length > 0) {
                [infodata addInfoWithValue:moreview.show_summary.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:NO:YES];
            }
            
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
        [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeBlack];
        [HttpManage uploadTP:img name:uuid cb:^(BOOL isOK, NSString *URL) {
            NSLog(@"%@",URL);
            if (isOK) {
                imgdata = [[NSMutableArray alloc] init];
                if ([data count] - 1 > 0) {
                    row_index = 0;
                    GridInfo *info = [data objectAtIndex:row_index];
                    [self postupload:info.img :URL] ;
                }else{
                    NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                    [self party:moreview.jh_edit.text :moreview.xlr_edit.text :moreview.xlfs_edit.text :moreview.address_edit.text :arr :@"" :hltime :bmendtime :moreview.show_summary.text :URL :_unquieId :mp3url];
                }
            }else{
                [SVProgressHUD dismiss];
                [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
            }
        }];
    }else{
        if ([data count] - 1 > 0) {
            for (int i = 0; i<[data count] - 1; i++) {
                GridInfo *info = [data objectAtIndex:i];
                CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
                NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
                uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
                NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
                [addimg addObject:[NSString stringWithFormat:@"../Image/%@",uuid]];
                [UIImageJPEGRepresentation(info.img,C_JPEG_SIZE) writeToFile:imgpath atomically:YES];
            }
        }
        NSArray *arr = [[NSArray alloc] initWithArray:addimg];
        NSString *hlarr = [arr componentsJoinedByString:@","];
        
        [UDObject setSWContent:moreview.jh_edit.text swtime:hltime swbmendtime:bmendtime address_name:moreview.address_edit.text swxlr_name:moreview.xlr_edit.text swxlfs_name:moreview.xlfs_edit.text swhd_name:moreview.show_summary.text music:mp3url musicname:mp3name imgarr:hlarr];
        
        [self performSegueWithIdentifier:@"preview" sender:nil];
    }
}

-(void)postupload :(UIImage *) img :(NSString *)URL{
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
            if (row_index > [data count] - 2) {
                NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                [self party:moreview.jh_edit.text :moreview.xlr_edit.text :moreview.xlfs_edit.text :moreview.address_edit.text :arr :@"" :hltime :bmendtime :moreview.show_summary.text :URL :_unquieId :mp3url];
                
            }else{
                GridInfo *info = [data objectAtIndex:row_index];
                [self postupload:info.img :URL];
            }
        }else{
            [SVProgressHUD dismiss];
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
        }
    }];
}

-(void)party:(NSString *) partyName :(NSString *)inviter :(NSString *)telephone :(NSString *)address :(NSArray *)images :(NSString *) tape :(NSString *) timestamp :(NSString *) closetime :(NSString *) description :(NSString *) background :(NSString *) unquieId :(NSString *)musicUrl{
    if (musicUrl.length > 0) {}else{
        musicUrl = @"";
    }
    [SVProgressHUD dismiss];
    [HttpManage party:[UDObject gettoken] partyName:partyName inviter:inviter telephone:(NSString *)telephone address:address images:images tape:tape timestamp:timestamp closetime:closetime description:description background:background mid:unquieId cb:^(BOOL isOK, NSDictionary *array) {
        if (isOK) {
            NSArray *arr = [[NSArray alloc] initWithArray:addimg];
            NSString *hlarr = [arr componentsJoinedByString:@","];
            
            [UDObject setSWContent:partyName swtime:timestamp swbmendtime:closetime address_name:address swxlr_name:inviter swxlfs_name:telephone swhd_name:description music:musicUrl musicname:mp3name imgarr:hlarr];
            
            [[StatusBar sharedStatusBar] talkMsg:@"已生成" inTime:0.5];
            [self GetRecord];
            
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
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
