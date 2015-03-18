//
//  ImgCollectionViewController.m
//  SpeciallyEffect
//
//  Created by wuyangbing on 14/12/7.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

#import "ImgCollectionViewController.h"
#import "ImgCollectionViewCell.h"
#import "imgGroupView.h"
#import "myImageView.h"
#import "ImgNavBar.h"
#import "ImgToolBar.h"
#import "ZipDown.h"
#import "Template.h"
@interface ImgCollectionViewController ()

@end

@implementation ImgCollectionViewController

static NSString * const reuseIdentifier = @"imgcell";
static NSString * const hIdentifier = @"imgcellh";
static NSString * const fIdentifier = @"imgcellf";

- (void)viewDidLoad {
    [super viewDidLoad];
    isShow = YES;
    selectLib = -1;
    selectIndexs = [[NSMutableArray alloc] init];
    selectItems = [[NSMutableArray alloc] init];
    selectIDs = [[NSMutableArray alloc] init];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    self.view.frame = [UIScreen mainScreen].bounds;
    CGFloat top = 20.0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.view.frame = IPAD_FRAME;
        w = self.view.frame.size.width;
        h = self.view.frame.size.height;
        m_w = (w-1.5*11.0)/11.0;
    }else{
        m_w = (w-6.0)/4.0;
    }
    
    self.clearsSelectionOnViewWillAppear = YES;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
//    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 128.0/2.0, w, h-128.0/2.0) collectionViewLayout:flowLayout];
    
    [self.view addSubview:self.collectionView];
    
    // Register cell classes
    [self.collectionView registerClass:[ImgCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[imgGroupView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hIdentifier];
//    [self.collectionView registerClass:[imgGroupView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:fIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:0.9];
    self.collectionView.frame = CGRectMake(0, 88.0/2.0+top, w, h-88.0/2.0-top);
    assert = ASSETHELPER;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self initDate];
    assert.bReverse = YES;
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.clipsToBounds = NO;
    
    ImgNavBar* bar = [[ImgNavBar alloc] initWithFrame:CGRectMake(0, 0, w, 88.0/2.0 + top)];
    bar.tag = 501;
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
    CGFloat toolH = 48.0;
    ImgToolBar* bar2 = [[ImgToolBar alloc] initWithFrame:CGRectMake(0, h - toolH, w, toolH)];
    bar2.tag = 502;
    [self.view addSubview:bar2];
    [self.view bringSubviewToFront:bar2];
    //加了已经有的数量
//    if (nil != [self.collectionView indexPathsForSelectedItems] && [self.collectionView indexPathsForSelectedItems].count > 0) {
//        [self setNowCount:[self.collectionView indexPathsForSelectedItems].count];
//    }
}
-(void) handleEnterForeground:(NSNotification*)noc{
    [self reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initDate{
    if ([self.delegate respondsToSelector:@selector(ownAssets)]) {
        selectItems = [self.delegate ownAssets];
    }
    selectIDs = [[NSMutableArray alloc] init];
    cells = [[NSMutableArray alloc] init];
    sections = [[NSMutableArray alloc] init];
    [assert getGroupList:^(NSArray *ag) {
        for (ALAssetsGroup* g in ag) {
            [assert getPhotoListOfGroup:g result:^(NSArray *imgs) {
                if (imgs != nil && imgs.count > 0) {
                    [sections addObject:g];
                }
            }];
        }
        [self reloadData];
    }];
}
-(void)reloadData{
    if (selectLib == -1) {
        selectLib = 1;
        oldSelectLib = 1;
    }
    [selectIDs removeAllObjects];
    [cells removeAllObjects];
    if (selectLib < sections.count) {
        for (int i=0; i<sections.count; i++) {
            ALAssetsGroup* g = [sections objectAtIndex:i];
            if (i == selectLib) {
                ImgNavBar* bar = (ImgNavBar*)[self.view viewWithTag:501];
                [bar setTitle:[g valueForProperty:ALAssetsGroupPropertyName]];
                [assert getPhotoListOfGroup:g result:^(NSArray *imgs) {
                    [cells addObject:imgs];
                }];
            }
        }
    } else if (self.needLocal){
        NSInteger index = selectLib - sections.count;
        NSString* neftypeId = @"";
        ImgNavBar* bar = (ImgNavBar*)[self.view viewWithTag:501];
        switch (index) {
            case 0:
            {
                neftypeId = @"1";
                [bar setTitle:@"婚礼资源"];
                break;
            }
            case 1:
            {
                neftypeId = @"3";
                [bar setTitle:@"聚会资源"];
                break;
            }
            case 2:
            {
                neftypeId = @"2";
                [bar setTitle:@"商务资源"];
                break;
            }
            default:
                break;
        }
        NSArray *data = [[DataBaseManage getDataBaseManage] GetTemplate:neftypeId];
        [cells addObject:data];
    }
    [self.collectionView reloadData];
    [self setNowCount:0];
    
    if (self.needAnimation) {
//        ImgNavBar* bar = (ImgNavBar*)[self.view viewWithTag: 501];
//        bar.frame = CGRectMake(0, -bar.frame.size.height, bar.frame.size.width, bar.frame.size.height);
        isShow = YES;
        CATransform3D t = CATransform3DIdentity;
        t.m34 = -1.0/600.0;
        CAKeyframeAnimation* moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        moveAnim.values = [[NSArray alloc] initWithObjects:[NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, -100)],
                           [NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, 216)],
                           [NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, -78)],
                           [NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, 24)],
                           [NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, -6)],
                           [NSValue valueWithCATransform3D:t],nil];
        moveAnim.removedOnCompletion = NO;
        
        CABasicAnimation* opacityAnim = [CABasicAnimation animationWithKeyPath: @"opacity"];
        opacityAnim.fromValue = [NSNumber numberWithFloat: 0.0];
        opacityAnim.toValue = [NSNumber numberWithFloat: 1.0];
        opacityAnim.removedOnCompletion = NO;
        
        CAAnimationGroup* animGroup = [CAAnimationGroup animation];
        animGroup.animations = [[NSArray alloc] initWithObjects: moveAnim,opacityAnim,nil];
        animGroup.duration = 0.8;
        animGroup.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
        animGroup.removedOnCompletion = NO;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.delegate = self;
        [self.collectionView.layer addAnimation:animGroup forKey:@"s"];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (isShow) {
//        ImgNavBar* bar = (ImgNavBar*)[self.view viewWithTag: 501];
//        [UIView animateWithDuration:0.4 animations:^{
//            bar.frame = CGRectMake(0, 0, bar.frame.size.width, bar.frame.size.height);
//        }];
        for (NSIndexPath* index in selectIndexs) {
            [self.collectionView selectItemAtIndexPath:index animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
        if (nil != [self.collectionView indexPathsForSelectedItems] && [self.collectionView indexPathsForSelectedItems].count > 0){
            [selectIndexs removeAllObjects];
            [selectItems removeAllObjects];
            [self setNowCount:[self.collectionView indexPathsForSelectedItems].count];
        }
    } else {
        [self setNowCount:0];
        [self dismissViewControllerAnimated:YES completion:^{
            if (isOK) {
                NSArray* ips= [self.collectionView indexPathsForSelectedItems];
                if (nil != ips && ips.count > 0){
                    NSMutableArray* als = [[NSMutableArray alloc] init];
                    for (NSIndexPath* index in selectIDs) {
                        NSArray* ar = [cells objectAtIndex:index.section];
                        if (selectLib < sections.count) {
                            ALAsset* al = [ar objectAtIndex:index.row];
                            [als addObject:al];
                        } else {
                            Template *info = [ar objectAtIndex:index.row];
                            NSString *nefmbbg = [[NSString alloc] initWithFormat:@"%@",info.nefmbbg];
                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                            NSString *documentsDirectory = [paths objectAtIndex:0];
                            nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
                            if (self.isHead) {
                                [als addObject:[nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"thumb"]];
                            } else if(sections.count == selectLib){
                                [als addObject:[nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"home"]];
                            }else{
                                [als addObject:nefmbbg];
                                //                                [als addObject:[nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"base"]];
                            }
                        }
                    }
                    if (als.count > 0) {
                        if (selectLib < sections.count) {
                            [self.delegate didSelectAssets:als isAssets:YES];
                        }else{
                            [self.delegate didSelectAssets:als isAssets:NO];
                        }
                    }
                }
            }
        }];
    }
}
- (void) setBadge:(NSNotification*)noc{
    NSNumber* count = (NSNumber*)noc.object;
    [self setNowCount:[count integerValue]];
}
- (void) setNowCount:(NSInteger)count{
    ImgToolBar* bar = (ImgToolBar*)[self.view viewWithTag: 502];
    [bar okCount:count];
//    ImgNavBar* bar2 = (ImgNavBar*)[self.view viewWithTag: 501];
//    [bar2 okCount:count];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backWithNO) name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backWithOK) name:@"MSG_IMGS_OK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(previewImage) name:@"MSG_IMGS_PV" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(libList) name:@"MSG_IMGS_LIST" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBadge:) name:@"MSG_SET_BADGE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addID:) name:@"MSG_ADD_ID" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeID:) name:@"MSG_REMOVE_ID" object:nil];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_IMGS_PV" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_IMGS_LIST" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_IMGS_OK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_SET_BADGE" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_ADD_ID" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_REMOVE_ID" object:nil];
}
-(void)libList{
    int listCount = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"选择相册" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil ];
        for (int i=0; i<sections.count; i++) {
            ALAssetsGroup* g = [sections objectAtIndex:i];
            [as addButtonWithTitle:[g valueForProperty:ALAssetsGroupPropertyName]];
            listCount++;
        }
        if (self.needLocal) {
            [as addButtonWithTitle:@"婚礼资源"];
            [as addButtonWithTitle:@"聚会资源"];
            [as addButtonWithTitle:@"商务资源"];
            listCount++;
        }
        if (listCount > 0) {
            [as showInView:self.view];
        }
    } else {
        
        UIActionSheet *as=[[UIActionSheet alloc]initWithTitle:@"选择相册" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles: nil ];
        for (int i=0; i<sections.count; i++) {
            ALAssetsGroup* g = [sections objectAtIndex:i];
            [as addButtonWithTitle:[g valueForProperty:ALAssetsGroupPropertyName]];
            listCount++;
        }
        if (self.needLocal) {
            [as addButtonWithTitle:@"婚礼资源"];
            [as addButtonWithTitle:@"聚会资源"];
            [as addButtonWithTitle:@"商务资源"];
            listCount++;
        }
        if (listCount > 0) {
            UIView* bar = [self.view viewWithTag: 501];
            [as showFromRect:CGRectMake(55, 40, 0, 0) inView:bar animated:YES];
        }
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == oldSelectLib || buttonIndex == -1) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if ([actionSheet isVisible]) {
                [actionSheet dismissWithClickedButtonIndex:0 animated:NO];
            }
        }
    } else {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if ([actionSheet isVisible]) {
                [actionSheet dismissWithClickedButtonIndex:0 animated:NO];
            }
        }
        if (buttonIndex < sections.count) {
            selectLib = buttonIndex;
            oldSelectLib = buttonIndex;
            [self reloadData];
        } else {
            selectLib = buttonIndex;
            oldSelectLib = buttonIndex;
            [self reloadData];
        }
    }
}
-(void)previewImage{
    
}
-(void)addID:(NSNotification*)noc{
    [selectIDs addObject:[noc object]];
}
-(void)removeID:(NSNotification*)noc{
    [selectIDs removeObject:[noc object]];
}
-(void)backWithOK{
    isOK = YES;
    [self back];
}
-(void)backWithNO{
    isOK = NO;
    [self back];
}
- (BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillAppear:animated];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//    }
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [self reloadData];
    }
}
-(void)back{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didBack)]){
        [self.delegate didBack];
    }
    isShow = NO;
    if (self.needAnimation) {
        ImgNavBar* bar = (ImgNavBar*)[self.view viewWithTag: 501];
        [UIView animateWithDuration:0.3 animations:^{
            bar.frame = CGRectMake(0, -bar.frame.size.height, bar.frame.size.width, bar.frame.size.height);
        }];
        CATransform3D t = CATransform3DIdentity;
        t.m34 = -1.0/900.0;
        CAKeyframeAnimation* moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        moveAnim.values = [[NSArray alloc] initWithObjects:[NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, 400)],
                           [NSValue valueWithCATransform3D:CATransform3DTranslate(t, 0, 0, 600)],nil];
        moveAnim.removedOnCompletion = NO;
        
        CABasicAnimation* opacityAnim = [CABasicAnimation animationWithKeyPath: @"opacity"];
        opacityAnim.fromValue = [NSNumber numberWithFloat: 1.0];
        opacityAnim.toValue = [NSNumber numberWithFloat: 0.0];
        opacityAnim.removedOnCompletion = NO;
        
        CAAnimationGroup* animGroup = [CAAnimationGroup animation];
        animGroup.animations = [[NSArray alloc] initWithObjects: moveAnim,opacityAnim,nil];
        animGroup.duration = 0.5;
        animGroup.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
        animGroup.removedOnCompletion = NO;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.delegate = self;
        [self.collectionView.layer addAnimation:animGroup forKey:@"stop"];
        
    } else {
        [self setNowCount:0];
        [self dismissViewControllerAnimated:YES completion:^{
            if (isOK) {
                NSArray* ips= [self.collectionView indexPathsForSelectedItems];
                if (nil != ips && ips.count > 0){
                    NSMutableArray* als = [[NSMutableArray alloc] init];
                    for (NSIndexPath* index in selectIDs) {
                        NSArray* ar = [cells objectAtIndex:index.section];
                        if (selectLib < sections.count) {
                            ALAsset* al = [ar objectAtIndex:index.row];
                            [als addObject:al];
                        } else {
                            Template *info = [ar objectAtIndex:index.row];
                            NSString *nefmbbg = [[NSString alloc] initWithFormat:@"%@",info.nefmbbg];
                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                            NSString *documentsDirectory = [paths objectAtIndex:0];
                            nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
                            if (self.isHead) {
                                [als addObject:[nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"thumb"]];
                            } else if(sections.count == selectLib){
                                [als addObject:[nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"home"]];
                            }else{
                                [als addObject:nefmbbg];
//                                [als addObject:[nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"base"]];
                            }
                        }
                    }
                    if (als.count > 0) {
                        if (selectLib < sections.count) {
                            [self.delegate didSelectAssets:als isAssets:YES];
                        }else{
                            [self.delegate didSelectAssets:als isAssets:NO];
                        }
                    }
                }
            }
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
//    return sections.count;
    if (sections.count == 0) {
        if (self.needLocal) {
            return 1;
        }
        return 0;
    }
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (cells.count > 0) {
        NSArray* ar = [cells objectAtIndex:0];
        return ar.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSArray* ar = [cells objectAtIndex:indexPath.section];
    if (ar.count <= indexPath.row) {
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    ALAsset* al = nil;
    Template *info = nil;
    UIImageView* imgv = (UIImageView*)[cell viewWithTag:202];
    if (selectLib < sections.count) {
        al = [ar objectAtIndex:indexPath.row];
        imgv.image = [assert getImageFromAsset:al type:ASSET_PHOTO_THUMBNAIL];
        cell.asset = al;
        cell.imgPath = @"";
    } else {
        info = [ar objectAtIndex:indexPath.row];
        NSString *nefmbbg = [[NSString alloc] initWithFormat:@"%@",info.nefmbbg];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
        if (![[NSFileManager defaultManager] fileExistsAtPath:nefmbbg]) {
            [cell performSelectorInBackground:@selector(changeImage:) withObject:info.nefmbbg];
            
        }else{
            NSString* imgPath = [nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"thumb"];
            imgv.image = [[UIImage alloc] initWithContentsOfFile:imgPath];
        }
        cell.asset = nil;
        if (self.isHead) {
            cell.imgPath = [nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"thumb"];
        } else if(sections.count == selectLib){
            cell.imgPath = [nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"home"];
        }else{
            cell.imgPath = nefmbbg;
//            cell.imgPath = [nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"base"];
        }
    }
    cell.index = indexPath;
    cell.maxCount = self.maxCount;
    [cell checkSelect];
    if (selectItems.count > 0) {
        if (selectLib < sections.count) {
            for (ALAsset* item in selectItems) {
                if ([[al description] compare:[item description]] == NSOrderedSame) {
                    [selectIndexs addObject:indexPath];
                    [cell setSelect];
                }
            }
        }else{
            
        }
    }
    return cell;
}
- (UICollectionReusableView*) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    imgGroupView* headerView;
    if ([kind compare:UICollectionElementKindSectionHeader] == NSOrderedSame) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:hIdentifier forIndexPath:indexPath];
    } else {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:fIdentifier forIndexPath:indexPath];
    }
    UIImageView* upgView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    //        upgView.backgroundColor = UIColor.blackColor()
    upgView.image = [myImageView getShadowImage:headerView.bounds];
    [headerView addSubview:upgView];
    NSDictionary* dic = [sections objectAtIndex:indexPath.section];
    
    NSString* s = [dic objectForKey:@"name"];
    NSInteger c = [[dic objectForKey:@"count"] integerValue];
    headerView.title.text = [[NSString alloc] initWithFormat: @"%@ 共 %ld 张照片",s,(long)c];
    [headerView bringSubviewToFront :headerView.title];
    return headerView;
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(CGSize) collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
-(CGSize) collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    CGSize size = [UIScreen mainScreen].bounds.size;
    return CGSizeZero;//return CGSizeMake(size.width, 80.0/2.0);
}
-(CGSize) collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(m_w, m_w);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0;
}

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
