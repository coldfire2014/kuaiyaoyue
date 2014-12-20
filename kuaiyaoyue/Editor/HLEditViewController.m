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
#import "MusicViewController.h"

@interface HLEditViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate,SDDelegate,MVCDelegate>{
    int count;
    NSMutableArray *imgdata;
    int row_index;
    
    AssetHelper* assert;
    ShowData *show;
    NSString *hltime;
    NSString *bmendtime;
    BOOL time_type;
    
    NSString *xl_name;
    NSString *xn_name;
    NSString *address_name;
    NSString *mp3url;
    
}

@end

@implementation HLEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"返回";
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"快邀约";
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    [self.navigationController.navigationBar setTintColor:color];
    
    imgdata = [[NSMutableArray alloc] init];
    
    
    _data = [[NSMutableArray alloc] init];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([PhotoCell class]) bundle:nil];
    [_gridview registerNib:nib forCellWithReuseIdentifier:@"PhotoCell"];
    [self initImgData];
    assert = ASSETHELPER;
    assert.bReverse = YES;
    
    _scrollview.delegate = self;
    _xl_edit.delegate = self;
    _xn_edit.delegate = self;
    _address_edit.delegate = self;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    
    show = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShowData class]) owner:nil options:nil] lastObject];
    show.delegate = self;
    [show setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    show.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:show];
    [self getHistorical];
}

-(void)getHistorical{
    if ([UDObject getxl_name].length > 0) {
        _xl_edit.text = [UDObject getxl_name];
        _xn_edit.text = [UDObject getxn_name];
        hltime = [UDObject gethltime];
        bmendtime = [UDObject getbmendtime];
        _hltime_label.text = [TimeTool getFullTimeStr:[hltime longLongValue]/1000];
        _bmend_label.text = [TimeTool getFullTimeStr:[bmendtime longLongValue]/1000];
        _address_edit.text = [UDObject getaddress_name];
    }
}

-(void)changeHigh{
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initImgData{
    count = 9;
    GridInfo *info = [[GridInfo alloc] initWithDictionary:NO :nil];
    [_data addObject:info];
    [_gridview reloadData];
    
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
        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
        des.maxCount = count;
        des.needAnimation = NO;
        des.delegate = self;
    }else if ([segue.identifier compare:@"music"] == NSOrderedSame){
        MusicViewController *view = (MusicViewController*)segue.destinationViewController;
        view.delegate = self;
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
    return CGSizeMake((_gridview.frame.size.width - 2*9)/3, (_gridview.frame.size.width - 2*9)/3);
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
        NSLog(@"%@",info.alasset);
        UIImage *img = [assert getImageFromAsset:info.alasset type:ASSET_PHOTO_THUMBNAIL];
        cell.show_img.image = img;
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
    
    _bottomview.clipsToBounds = YES;
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GridInfo *info = [self.data objectAtIndex:[indexPath row]];
    if (!info.is_open) {
        [self.view endEditing:NO];
        [self performSegueWithIdentifier:@"imgSelect" sender:nil];
    }else{
    }
}

- (void)PhotoCellDelegate:(PhotoCell *)cell didTapAtIndex:(long ) index{
    GridInfo *info = [self.data objectAtIndex:index];
    [_data removeObject:info];
    [_gridview reloadData];
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
        GridInfo *info = [[GridInfo alloc] initWithDictionary:YES :al];
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
    [self.gridview reloadData];
    count -= items.count;
    
//   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

-(void)sethigh{
    long index = [_data count];
    long height = 161;
    if (index <= 3) {
        _bottomview.frame = CGRectMake(_bottomview.frame.origin.x, _bottomview.frame.origin.y, _bottomview.frame.size.width, height);
    }else if(index > 3 && index <= 6){
        _bottomview.frame = CGRectMake(_bottomview.frame.origin.x, _bottomview.frame.origin.y, _bottomview.frame.size.width, height+115);
        NSLog(@"%f",_gridview.frame.size.height);
    }else if(index > 6){
        _bottomview.frame = CGRectMake(_bottomview.frame.origin.x, _bottomview.frame.origin.y, _bottomview.frame.size.width, height+115*2);
    }
    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, _bottomview.frame.origin.y + _bottomview.frame.size.height + 50)];
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
    
}

- (IBAction)hltime_onclick:(id)sender {
    time_type = YES;
    [self.view endEditing:NO];
    [UIView animateWithDuration:0.4f animations:^{
        [show setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (IBAction)bmend_onclick:(id)sender {
    [self.view endEditing:NO];
    if (hltime != nil) {
        time_type = NO;
        NSDate * date=[NSDate dateWithTimeIntervalSince1970:([hltime longLongValue]/1000)];
        [show.picker setMaximumDate:date];
        [UIView animateWithDuration:0.4f animations:^{
            [show setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }
}

- (IBAction)music_onclick:(id)sender {
    
    //music
    [self performSegueWithIdentifier:@"music" sender:nil];
}

- (IBAction)xl_next:(id)sender {
    
}

- (IBAction)xn_next:(id)sender {
    
}

- (IBAction)address_next:(id)sender {
    
}

- (void)SDDelegate:(ShowData *)cell didTapAtIndex:(NSString *) timebh{
    if (timebh != nil) {
        if (time_type) {
            hltime = timebh;
            _hltime_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
        }else{
            bmendtime = timebh;
            _bmend_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
        }
    }
    [UIView animateWithDuration:0.4f animations:^{
        [show setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
    }
    if (textField == _address_edit) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.scrollview setContentOffset:CGPointMake(0, 150)];
        }];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.xl_edit || textField ==self.xn_edit) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }else if (textField == self.address_edit){
        if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
        }
    }
    return YES;
}

- (IBAction)send_onclick:(id)sender {
    [self SendUp];
}

- (IBAction)sendandshare_onclick:(id)sender {
    
}

- (void)MVCDelegate:(MusicViewController *)cell didTapAtIndex:(NSString *) url{
    
}

-(void)SendUp{
    xl_name = _xl_edit.text;
    xn_name = _xn_edit.text;
    address_name = _address_edit.text;
    
    if (xl_name.length > 0 && xn_name.length > 0 && hltime.length > 0 && bmendtime.length > 0 && address_name.length > 0) {
        [self setbg];
        [UDObject setHLContent:xl_name xn_name:xn_name hltime:hltime bmendtime:bmendtime address_name:address_name];
        
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"内容不能为空" inTime:0.5];
    }
    
}

-(void)setbg{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *urlpath = [documentsDirectory stringByAppendingString:_nefmbdw];
    UIImage *bgimg = [self getimg:urlpath];
//    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
//    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
//   [UIImageJPEGRepresentation(bgimg,0.8) writeToFile:[[FileManage sharedFileManage] getImgFile:uuid] atomically:YES];
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
            NSString *name = [NSString stringWithFormat:@"%@ & %@",_xl_edit.text,_xn_edit.text];
            
            [infodata addInfoWithValue:name andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
        }else if ([parameterName isEqualToString:@"timestamp"]) {
            
            [infodata addInfoWithValue:_hltime_label.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
            
        }else if ([parameterName isEqualToString:@"address"]) {
            
            [infodata addInfoWithValue:_address_edit.text andRect:CGRectMake(x, y, w, h) andSize:size andR:red1 G:green1 B:blue1 andSingle:YES:YES];
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
    [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeBlack];
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    [HttpManage uploadTP:img name:uuid cb:^(BOOL isOK, NSString *URL) {
        NSLog(@"%@",URL);
        if (isOK) {
            imgdata = [[NSMutableArray alloc] init];
            if ([_data count] > 0) {
                row_index = 0;
                GridInfo *info = [_data objectAtIndex:row_index];
                UIImage *img = [assert getImageFromAsset:info.alasset type:ASSET_PHOTO_SCREEN_SIZE];
                [self postuploadHL:img :URL] ;
            }else{
                NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
                [self marry:_unquieId :xn_name :xl_name :address_name :arr :hltime :URL :mp3url :bmendtime];
            }
        }else{
            [SVProgressHUD dismissWithError:@"上传失败"];
        }
    }];
}



-(void)postuploadHL :(UIImage *) img :(NSString *)URL{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
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
                UIImage *img1 = [assert getImageFromAsset:info.alasset type:ASSET_PHOTO_SCREEN_SIZE];
                [self postuploadHL:img1 :URL];
            }
        }else{
            [SVProgressHUD dismissWithError:@"上传失败"];
        }
    }];
}

-(void)marry:(NSString *) unquieId :(NSString *) bride :(NSString *) groom :(NSString *) address :(NSArray *) images :(NSString *) timestamp :(NSString *)background :(NSString *)musicUrl :(NSString *)closeTimestamp{
    if (musicUrl.length > 0) {}else{
        musicUrl = @"";
    }
    
    [HttpManage marry:[UDObject gettoken] bride:bride groom:groom address:address location:nil images:images timestamp:timestamp background:background musicUrl:musicUrl closeTimestamp:closeTimestamp mid:unquieId cb:^(BOOL isOK, NSDictionary *dic) {
        NSLog(@"%@",dic);
        if (isOK) {
            
        }else{
            
        }
    }];
}


@end
