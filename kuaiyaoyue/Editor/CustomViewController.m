//
//  CustomViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/5.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "CustomViewController.h"
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
#import "CustomView.h"
#import "PECropViewController.h"
#import "PreviewViewController.h"
#import "TalkingData.h"
#import "waitingView.h"
@interface CustomViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate,datetimeInputDelegate,MVCDelegate,CVDelegate,PECropViewControllerDelegate,PreviewViewControllerDelegate>{
    BOOL is_yl;
    int count;
    CustomView *custom;
    
    NSMutableArray *addimg;
    int row_index;
    
    AssetHelper* assert;
    NSString *hltime;
    NSString *bmendtime;
    BOOL time_type;
    
    UICollectionView *gridview;
    
    UIScrollView *scrollview;
    NSMutableArray *data;
    NSMutableArray *imgdata;
    
    NSString *mp3url;
    NSString *mp3name;
    
    NSString *topimgname;
    
    BOOL is_bcfs;
}

@end

@implementation CustomViewController
-(void)didSelectID:(NSString *)index andNefmbdw:(NSString *)nefmbdw{
    
}
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
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeHigh) userInfo:nil repeats:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(send_onclick:)];
    
    [_send_view addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendandshare_onclick:)];
    
    [_sendshare_view addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editviewonclick:)];
    [custom.editview addGestureRecognizer:tap2];
}

- (void)editviewonclick:(UITapGestureRecognizer *)gr{
    [self.view endEditing:NO];
    [custom.editview setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeHigh{
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
}

-(void)addview{
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 50 - 64)];
    scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollview];
    
    custom = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] firstObject];
    custom.frame = CGRectMake(0, 0, self.view.frame.size.width, custom.frame.size.height);
    custom.backgroundColor = [UIColor clearColor];
    custom.delegate = self;
    custom.title_edit.delegate = self;
    custom.content_edit.delegate = self;
    
    gridview = custom.gridview;
    gridview.delegate = self;
    gridview.dataSource = self;
    scrollview.delegate = self;
    [scrollview addSubview:custom];
    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, 900)];

}

-(void)getHistorical{
    mp3name = @"";
    mp3url = @"";
    count = 15;
    if ([UDObject getzdytopimg].length > 0) {
        topimgname = [UDObject getzdytopimg];
        NSArray *array = [[UDObject getzdytopimg] componentsSeparatedByString:@"/"];
        NSString *topimg = [array objectAtIndex:([array count] - 1)];
        topimg = [[FileManage sharedFileManage].imgDirectory stringByAppendingPathComponent:topimg];
        UIImage *img = [[UIImage alloc]initWithContentsOfFile:topimg];
        custom.show_top_img.image = img;
        hltime = [UDObject getzdytime];
        bmendtime = [UDObject getzdyendtime];
        custom.time_label.text = [TimeTool getFullTimeStr:[hltime doubleValue]/1000.0];
        custom.endtime_label.text = [TimeTool getFullTimeStr:[bmendtime doubleValue]/1000.0];
        custom.title_edit.text = [UDObject getzdytitle];
        custom.content_edit.text = [UDObject getzdydd];
        long tc = 50-custom.content_edit.text.length;
        custom.text_label_num.text = [NSString stringWithFormat:@"剩余%ld字",tc];
        if ([UDObject getzdymusic].length > 0) {
            mp3name = [UDObject getzdymusicname];
            custom.music_label.text = mp3name;
            mp3url = [UDObject getzdymusic];
            [custom.del_music_view setHidden:NO];
        }
        NSArray *arr = [[UDObject getzdyimgarr] componentsSeparatedByString:NSLocalizedString(@",", nil)];
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
    long height = 43 + 12 + (gridview.frame.size.width - 2*9)/3;
    long addheight = (gridview.frame.size.width - 2*9)/3 + 9;
    
    NSLog(@"%f",custom.gridview.frame.origin.y);
    if (index <= 3) {
        custom.bottom_view.frame = CGRectMake(0, custom.bottom_view.frame.origin.y, custom.bottom_view.frame.size.width, height);
        gridview.frame = CGRectMake(custom.gridview.frame.origin.x, custom.gridview.frame.origin.y, custom.gridview.frame.size.width, addheight);
    }else if(index > 3 && index <= 6){
        custom.bottom_view.frame = CGRectMake(0, custom.bottom_view.frame.origin.y, custom.bottom_view.frame.size.width, height+addheight);
        gridview.frame = CGRectMake(custom.gridview.frame.origin.x, custom.gridview.frame.origin.y, custom.gridview.frame.size.width, addheight*2);
    }else if(index > 6 && index <= 9){
        custom.bottom_view.frame = CGRectMake(0, custom.bottom_view.frame.origin.y, custom.bottom_view.frame.size.width, height+addheight*2);
        gridview.frame = CGRectMake(custom.gridview.frame.origin.x, custom.gridview.frame.origin.y, custom.gridview.frame.size.width, addheight*3);
    }else if(index > 9 && index <= 12){
        custom.bottom_view.frame = CGRectMake(0, custom.bottom_view.frame.origin.y, custom.bottom_view.frame.size.width, height+addheight*3);
        gridview.frame = CGRectMake(custom.gridview.frame.origin.x, custom.gridview.frame.origin.y, custom.gridview.frame.size.width, addheight*4);
    }else if(index > 12){
        custom.bottom_view.frame = CGRectMake(0, custom.bottom_view.frame.origin.y, custom.bottom_view.frame.size.width, height+addheight*4);
        gridview.frame = CGRectMake(custom.gridview.frame.origin.x, custom.gridview.frame.origin.y, custom.gridview.frame.size.width, addheight*5);
    }
    
    custom.music_view.frame = CGRectMake(custom.music_view.frame.origin.x, custom.bottom_view.frame.origin.y +custom.bottom_view.frame.size.height + 11 , custom.music_view.frame.size.width, custom.music_view.frame.size.height);

    [scrollview setContentSize:CGSizeMake(scrollview.frame.size.width, custom.music_view.frame.origin.y + custom.music_view.frame.size.height+50)];
}

-(void)RightBarBtnClicked:(id)sender{
    //preview
    is_yl = NO;
    [self SendUp];
    [TalkingData trackEvent:@"预览" label:@"自定义"];
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
    [TalkingData trackPageBegin:@"自定义编辑"];
    //    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, -1000)];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [TalkingData trackPageEnd:@"自定义编辑"];
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
//        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
//        des.maxCount = m_count;
//        des.needAnimation = NO;
//        des.delegate = self;
    }else if ([segue.identifier compare:@"preview"] == NSOrderedSame){
//        PreviewViewController *view = (PreviewViewController*)segue.destinationViewController;
//        view.delegate = self;
//        view.type = 3;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([data count] > 15) {
        return 15;
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
        isHead = NO;
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
    if(isHead){
        if (items.count>0) {
            ALAsset* al = [items objectAtIndex:0];
            UIImage* userHeadImage = [assert getImageFromAsset:al type:ASSET_PHOTO_SCREEN_SIZE];
            [self SendPECropView:userHeadImage];
        }
    }else{
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
}

- (void)CVDelegate:(CustomView *)cell didTapAtIndex:(int) type{
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
            [[StatusBar sharedStatusBar] talkMsg:@"您还没有输入活动时间。" inTime:0.8];
        }
    }else if (type == 2){
        MusicViewController *des = [[MusicViewController alloc] init];
        des.delegate = self;
        des.typeid = @"4";
        des.modalPresentationStyle = UIModalPresentationFormSheet;
        des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:des animated:YES completion:^{
            
        }];
    }else if (type == 3){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (custom.show_top_img.image != nil) {
                UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"修改头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"修改这张" otherButtonTitles:@"从相册选取",@"照一张", nil ];
                as.tag = 999;
                [as showInView:self.view];
            } else {
                UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"选择头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"照一张", nil ];
                as.tag = 998;
                [as showInView:self.view];
            }
        } else {
            if (custom.show_top_img.image != nil) {
                UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"修改头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"修改这张" otherButtonTitles:@"从相册选取",@"照一张", nil ];
                as.tag = 999;
                [as showFromRect:CGRectMake(self.view.frame.size.width-70, 70, 100, 100) inView:self.view animated:YES];
            } else {
                UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"选择一张头图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"照一张", nil ];
                as.tag = 998;
                [as showFromRect:CGRectMake(self.view.frame.size.width-70, 70, 100, 100) inView:self.view animated:YES];
            }
        }
    }else if (type == 4){
        mp3url = @"";
        mp3name = @"";
        custom.music_label.text = @"";
        [custom.del_music_view setHidden:YES];
    }
}
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
            //        des.transitioningDelegate = self;
//            des.modalPresentationStyle = UIModalPresentationCustom;
            des.modalPresentationStyle = UIModalPresentationFormSheet;
            des.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:des animated:YES completion:^{
                
            }];
        }else if(actionSheet.tag == 999 && buttonIndex == 0){
            [self SendPECropView:custom.show_top_img.image];
        }else if ((actionSheet.tag == 998 && buttonIndex == 1) || (actionSheet.tag == 999 && buttonIndex == 2)){
            UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [imgPicker setDelegate:self];
            [imgPicker setAllowsEditing:NO];
            [self.navigationController presentViewController:imgPicker animated:YES completion:^{
                
            }];
        }
    }
}
#pragma mark ----------ActionSheet 按钮点击-------------
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
                    [self.navigationController presentViewController:imgPicker animated:YES completion:^{
                        
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
                    [self SendPECropView:custom.show_top_img.image];
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
                    [self.navigationController presentViewController:imgPicker animated:YES completion:^{
                        
                    }];
                }
            }
                break;
            default:
                break;
        }
    }
}


#pragma mark ----------图片选择完成-------------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage  * userHeadImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    UIImage *midImage = [self imageWithImageSimple:userHeadImage scaledToSize:CGSizeMake(120.0, 120.0)];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
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

#pragma mark -

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    custom.show_top_img.image = croppedImage;
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


//压缩图片
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

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIColor *tintColor = [UIColor colorWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    //字体大小、颜色
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                tintColor,
                                NSForegroundColorAttributeName, nil];
    [navigationController.navigationBar setTitleTextAttributes:attributes];
    [[UINavigationBar appearance] setTintColor:tintColor];
}
- (BOOL)didSelectDateTime:(NSTimeInterval)time{
    if (time_type) {
        if (time*1000.0 > [bmendtime doubleValue]) {
            NSArray* time_s = [[[NSString alloc] initWithFormat:@"%f",time*1000.0] componentsSeparatedByString:@"."];
            hltime = [time_s objectAtIndex:0];
            custom.time_label.text = [TimeTool getFullTimeStr:time];
            return YES;
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"活动时间不能小于报名截止时间" inTime:0.8];
            return NO;
        }
    } else {
        NSArray* time_s = [[[NSString alloc] initWithFormat:@"%f",time*1000.0] componentsSeparatedByString:@"."];
        bmendtime = [time_s objectAtIndex:0];
        custom.endtime_label.text = [TimeTool getFullTimeStr:time];
        return YES;
    }
}

- (void)MVCDelegate:(MusicViewController *)cell didTapAtIndex:(NSString *) url :(NSString *)name{
    mp3url = url;
    mp3name = name;
    custom.music_label.text = name;
    [custom.del_music_view setHidden:NO];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    if (textField == custom.title_edit) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:10];
//        }
//    }
//    return YES;
//}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSLog(@"%lu",(unsigned long)textView.text.length);
//    if(textView == custom.content_edit){
////        if (textView.text.length > 70) {
////            textView.text = [textView.text substringToIndex:70];
////        }
////        NSLog(@"%d",textView.text.length);
//        long num = 50-textView.text.length;
//        custom.text_label_num.text = [NSString stringWithFormat:@"剩余%ld字",num];
//        if (num > 0) {
//            [custom.text_label_num setTextColor:[UIColor lightGrayColor]];
//        }else{
//            [custom.text_label_num setTextColor:[UIColor redColor]];
//        }
//    }
//    
//    return YES;
//}

- (void)textViewDidChange:(UITextView *)textView{
    if(textView == custom.content_edit){
        long num = 50-textView.text.length;
        custom.text_label_num.text = [NSString stringWithFormat:@"剩余%ld字",num];
        if (num > 0) {
            [custom.text_label_num setTextColor:[UIColor lightGrayColor]];
        }else{
            [custom.text_label_num setTextColor:[UIColor redColor]];
        }
    }
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    [custom.editview setHidden:NO];
    return YES;
}

- (void)send_onclick:(UITapGestureRecognizer *)gr{
    is_bcfs = NO;
    [self SendUp];
}

- (void)sendandshare_onclick:(UITapGestureRecognizer *)gr{
    is_bcfs = YES;
    [self SendUp];
}

-(void)SendUp{
    NSString *zdytitle = custom.title_edit.text;
    NSString *zdycontent = custom.content_edit.text;

    if (zdytitle.length > 0 && zdycontent.length > 0 && hltime.length > 0 && bmendtime.length > 0 && custom.show_top_img.image != nil && data.count -1 > 0 && mp3url.length > 0) {
        if (zdytitle.length > 11) {
            [[StatusBar sharedStatusBar] talkMsg:@"标题不得超过11个字" inTime:1.5];
            return;
        }
        if (zdycontent.length >50) {
            [[StatusBar sharedStatusBar] talkMsg:@"导读不得超过50个字" inTime:1.5];
            return;
        }
        
        
        [self upmbdt:custom.show_top_img.image];
    }else{
        [[StatusBar sharedStatusBar] talkMsg:@"内容不能为空" inTime:0.5];
    }
    
}

-(void)upmbdt:(UIImage *)img{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    addimg = [[NSMutableArray alloc] init];
    topimgname = [NSString stringWithFormat:@"../Image/%@",uuid];
    [UIImageJPEGRepresentation(img,C_JPEG_SIZE) writeToFile:imgpath atomically:YES];
    
    if (is_yl) {
        if(is_bcfs){
            [TalkingData trackEvent:@"生成并发送"];
        }else{
            [TalkingData trackEvent:@"生成"];
        }
        [[waitingView sharedwaitingView] waitByMsg:@"正在上传素材，请稍候。" haveCancel:NO];
        CGSize size = CGSizeMake(120, 120);
        img = [self imageWithImageSimple:img scaledToSize:size];
        [HttpManage uploadTP:img name:uuid cb:^(BOOL isOK, NSString *URL) {
            NSLog(@"%@",URL);
            if (isOK) {
                imgdata = [[NSMutableArray alloc] init];
                if ([data count] - 1 > 0) {
                    row_index = 0;
                    GridInfo *info = [data objectAtIndex:row_index];
                    [self postupload:info.img :URL];
                }else{
                    [self Sendcustom:URL];
                }
            }else{
                [[waitingView sharedwaitingView] stopWait];
                [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.5];
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
        
        [UDObject setZDYContent:topimgname zdytitle:custom.title_edit.text zdydd:custom.content_edit.text zdytime:hltime zdyendtime:bmendtime zdymusic:mp3url zdymusicname:mp3name zdyimgarr:hlarr];
        PreviewViewController *view = [[PreviewViewController alloc] init];
        view.type = 3;
        view.delegate = self;
        view.modalPresentationStyle = UIModalPresentationFormSheet;
        view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:view animated:YES completion:^{
            
        }];
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
                [self Sendcustom:URL];
            }else{
                GridInfo *info = [data objectAtIndex:row_index];
                [self postupload:info.img :URL];
            }
        }else{
            [[waitingView sharedwaitingView] stopWait];
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败了，再试一次吧" inTime:0.5];
        }
    }];
}

-(void)Sendcustom:(NSString *)logo{
    [[waitingView sharedwaitingView] changeWord:@"正在努力制作中……"];
    NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
    [HttpManage custom:[UDObject gettoken] title:custom.title_edit.text content:custom.content_edit.text logo:logo music:mp3url timestamp:hltime closeTimestamp:bmendtime images:arr mid:_unquieId cb:^(BOOL isOK, NSDictionary *array) {
        NSLog(@"%@",array);
        if (isOK) {
            NSString *hlarr = [arr componentsJoinedByString:@","];
            [UDObject setZDYContent:topimgname zdytitle:custom.title_edit.text zdydd:custom.content_edit.text zdytime:hltime zdyendtime:bmendtime zdymusic:mp3url zdymusicname:mp3name zdyimgarr:hlarr];
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
    [HttpManage multiHistory:[UDObject gettoken] timestamp:@"-1" size:@"-1" cb:^(BOOL isOK, NSDictionary *array) {
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
