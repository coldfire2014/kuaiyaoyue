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

@interface SWYQViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate,SDDelegate,MVCDelegate,MVDelegate>{
    BOOL is_yl;
    int count;
    MoreView *moreview;
    
    AssetHelper* assert;
    ShowData *show;
    NSString *hltime;
    NSString *bmendtime;
    BOOL time_type;
    
    UICollectionView *gridview;
    
    UIScrollView *scrollview;
    NSMutableArray *data;
    NSMutableArray *imgdata;
    
    NSString *mp3url;
    NSString *mp3name;
}

@end

@implementation SWYQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"快邀约";
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
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([PhotoCell class]) bundle:nil];
    [gridview registerNib:nib forCellWithReuseIdentifier:@"PhotoCell"];
    [self getHistorical];
    
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
    if ([UDObject getxl_name].length > 0) {
//        _xl_edit.text = [UDObject getxl_name];
//        _xn_edit.text = [UDObject getxn_name];
//        hltime = [UDObject gethltime];
//        bmendtime = [UDObject getbmendtime];
//        _hltime_label.text = [TimeTool getFullTimeStr:[hltime longLongValue]/1000];
//        _bmend_label.text = [TimeTool getFullTimeStr:[bmendtime longLongValue]/1000];
//        _address_edit.text = [UDObject getaddress_name];
//        if ([UDObject gethlmusic].length > 0) {
//            mp3name = [UDObject gethlmusicname];
//            _music_label.text = mp3name;
//            mp3url = [UDObject gethlmusic];
//        }
//        NSArray *arr = [[UDObject gethlimgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
//        for (NSString *name in arr) {
//            
//            NSArray *array = [name componentsSeparatedByString:@"/"];
//            NSString *imgname = [array objectAtIndex:([array count] - 1)];
//            NSString *imgpath = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent: imgname];
//            UIImage *img = [[UIImage alloc]initWithContentsOfFile:imgpath];
//            GridInfo *info = [[GridInfo alloc] initWithDictionary:YES :img];
//            [_data addObject:info];
//        }
//        count -= [arr count];
    }
    [self initImgData];
}


-(void)sethigh{
    long index = [data count];
    long height = 115;
    long addheight = (gridview.frame.size.width - 2*9)/3 + 9;
    
    NSLog(@"%f",moreview.girdview.frame.origin.y);
    
    if (index <= 3) {
        moreview.bottom_view.frame = CGRectMake(0, moreview.bottom_view.frame.origin.y, moreview.bottom_view.frame.size.width, 290);
        gridview.frame = CGRectMake(moreview.girdview.frame.origin.x, moreview.girdview.frame.origin.y, moreview.girdview.frame.size.width, height);
    }else if(index > 3 && index <= 6){
        moreview.bottom_view.frame = CGRectMake(0, moreview.bottom_view.frame.origin.y, moreview.bottom_view.frame.size.width, 290+addheight);
        gridview.frame = CGRectMake(moreview.girdview.frame.origin.x, moreview.girdview.frame.origin.y, moreview.girdview.frame.size.width, height+addheight);
    }else if(index > 6){
        moreview.bottom_view.frame = CGRectMake(0, moreview.bottom_view.frame.origin.y, moreview.bottom_view.frame.size.width, 290+addheight*2);
        gridview.frame = CGRectMake(moreview.girdview.frame.origin.x, moreview.girdview.frame.origin.y, moreview.girdview.frame.size.width, height+addheight*2);
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    is_yl = YES;
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
//    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, -1000)];
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
    }
}

- (void)SDDelegate:(ShowData *)cell didTapAtIndex:(NSString *) timebh{
    if (timebh != nil) {
        if (time_type) {
            hltime = timebh;
            moreview.time_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == moreview.jh_edit || textField == moreview.xlr_edit) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }else if (textField == moreview.address_edit){
        if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
        }
    }else if (textField == moreview.xlfs_edit){
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] applicationFrame];
    if (ISIOS7LATER) {
        mainScreenFrame = [[UIScreen mainScreen] bounds];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [scrollview setContentOffset:CGPointMake(0, 290)];
    }];
    
    return YES;
}

@end
