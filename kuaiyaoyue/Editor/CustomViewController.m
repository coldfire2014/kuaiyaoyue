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
#import "CustomView.h"
#import "PECropViewController.h"
#import "PreviewViewController.h"
#import "TalkingData.h"

@interface CustomViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate,SDDelegate,MVCDelegate,CVDelegate,PECropViewControllerDelegate>{
    BOOL is_yl;
    int count;
    CustomView *custom;
    
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
    
    NSString *mp3url;
    NSString *mp3name;
    
    NSString *topimgname;
}

@end

@implementation CustomViewController

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
        custom.time_label.text = [TimeTool getFullTimeStr:[hltime longLongValue]/1000];
        custom.endtime_label.text = [TimeTool getFullTimeStr:[bmendtime longLongValue]/1000];
        custom.title_edit.text = [UDObject getzdytitle];
        custom.content_edit.text = [UDObject getzdydd];
        custom.text_label_num.text = [NSString stringWithFormat:@"剩余%d字",70-custom.content_edit.text.length];
        if ([UDObject getzdymusic].length > 0) {
            mp3name = [UDObject getzdymusicname];
            custom.music_label.text = mp3name;
            mp3url = [UDObject getzdymusic];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    is_yl = YES;
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [TalkingData trackPageBegin:@"自定义编辑"];
    //    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, -1000)];
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
        ImgCollectionViewController* des = (ImgCollectionViewController*)segue.destinationViewController;
        des.maxCount = m_count;
        des.needAnimation = NO;
        des.delegate = self;
    }else if ([segue.identifier compare:@"music"] == NSOrderedSame){
        MusicViewController *view = (MusicViewController*)segue.destinationViewController;
        view.delegate = self;
        view.typeid = @"4";
    }else if ([segue.identifier compare:@"preview"] == NSOrderedSame){
        PreviewViewController *view = (PreviewViewController*)segue.destinationViewController;
        view.type = 3;
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
        m_count = count;
        isHead = NO;
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
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if ((actionSheet.tag == 998 && buttonIndex == 0) || (actionSheet.tag == 999 && buttonIndex == 1)) {
            m_count = 1;
            isHead = YES;
            [self performSegueWithIdentifier:@"imgSelect" sender:nil];
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


- (void)SDDelegate:(ShowData *)cell didTapAtIndex:(NSString *) timebh{
    if (timebh != nil) {
        if (time_type) {
            hltime = timebh;
            custom.time_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
        }else{
            bmendtime = timebh;
            custom.endtime_label.text = [TimeTool getFullTimeStr:[timebh longLongValue]/1000];
        }
    }
    [UIView animateWithDuration:0.4f animations:^{
        show.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)MVCDelegate:(MusicViewController *)cell didTapAtIndex:(NSString *) url :(NSString *)name{
    mp3url = url;
    mp3name = name;
    custom.music_label.text = name;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%d",textView.text.length);
    if(textView == custom.content_edit){
//        if (textView.text.length > 70) {
//            textView.text = [textView.text substringToIndex:70];
//        }
//        NSLog(@"%d",textView.text.length);
        custom.text_label_num.text = [NSString stringWithFormat:@"剩余%d",70-textView.text.length];
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    [custom.editview setHidden:NO];
    return YES;
}

- (void)send_onclick:(UITapGestureRecognizer *)gr{
    [self SendUp];
}

- (void)sendandshare_onclick:(UITapGestureRecognizer *)gr{
    
}

-(void)SendUp{
    NSString *zdytitle = custom.title_edit.text;
    NSString *zdycontent = custom.content_edit.text;

    if (zdytitle.length > 0 && zdycontent.length > 0 && hltime.length > 0 && bmendtime.length > 0 && custom.show_top_img.image != nil && data.count -1 > 0 && mp3url.length > 0) {
        if (zdytitle.length > 11) {
            [[StatusBar sharedStatusBar] talkMsg:@"标题不得超过1个字" inTime:0.5];
            return;
        }
        if (zdycontent.length >70) {
            [[StatusBar sharedStatusBar] talkMsg:@"导读不得超过70个字" inTime:0.5];
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
    [UIImageJPEGRepresentation(img,0.8) writeToFile:imgpath atomically:YES];
    
    if (is_yl) {
        [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeBlack];
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
                
                CGSize size = CGSizeMake(120, 120);
                UIImage *img = [self imageWithImageSimple:info.img scaledToSize:size];
                
                [UIImageJPEGRepresentation(img,0.8) writeToFile:imgpath atomically:YES];
            }
        }
        
        NSArray *arr = [[NSArray alloc] initWithArray:addimg];
        NSString *hlarr = [arr componentsJoinedByString:@","];
        
        [UDObject setZDYContent:topimgname zdytitle:custom.title_edit.text zdydd:custom.content_edit.text zdytime:hltime zdyendtime:bmendtime zdymusic:mp3url zdymusicname:mp3name zdyimgarr:hlarr];
        
        [self performSegueWithIdentifier:@"preview" sender:nil];
    }
}

-(void)postupload :(UIImage *) img :(NSString *)URL{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    NSString *imgpath = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    [addimg addObject:[NSString stringWithFormat:@"../Image/%@",uuid]];
    [UIImageJPEGRepresentation(img,0.8) writeToFile:imgpath atomically:YES];
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
            [SVProgressHUD dismiss];
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
        }
    }];
}

-(void)Sendcustom:(NSString *)logo{
   
    NSArray *arr = [[NSArray alloc] initWithArray:imgdata];
    [HttpManage custom:[UDObject gettoken] title:custom.title_edit.text content:custom.content_edit.text logo:logo music:mp3url timestamp:hltime closeTimestamp:bmendtime images:arr mid:_unquieId cb:^(BOOL isOK, NSDictionary *array) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",array);
        if (isOK) {
            NSString *hlarr = [arr componentsJoinedByString:@","];
            [UDObject setZDYContent:topimgname zdytitle:custom.title_edit.text zdydd:custom.content_edit.text zdytime:hltime zdyendtime:bmendtime zdymusic:mp3url zdymusicname:mp3name zdyimgarr:hlarr];
            [[StatusBar sharedStatusBar] talkMsg:@"已生成" inTime:0.5];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [[StatusBar sharedStatusBar] talkMsg:@"生成失败" inTime:0.5];
        }
        
        
    }];
}

@end
