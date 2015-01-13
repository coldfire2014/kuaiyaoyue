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
@interface ImgCollectionViewController ()

@end

@implementation ImgCollectionViewController

static NSString * const reuseIdentifier = @"imgcell";
static NSString * const hIdentifier = @"imgcellh";
static NSString * const fIdentifier = @"imgcellf";

- (void)viewDidLoad {
    [super viewDidLoad];
    isShow = YES;
    selectIndexs = [[NSMutableArray alloc] init];
    selectItems = [[NSMutableArray alloc] init];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    m_w = (w-6.0)/4.0;
    self.clearsSelectionOnViewWillAppear = YES;
    self.view.frame = [UIScreen mainScreen].bounds;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
//    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 128.0/2.0, w, h-128.0/2.0) collectionViewLayout:flowLayout];
    
    [self.view addSubview:self.collectionView];
    
    // Register cell classes
    [self.collectionView registerClass:[ImgCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[imgGroupView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:hIdentifier];
    [self.collectionView registerClass:[imgGroupView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:fIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [[UIColor alloc] initWithWhite:1.0 alpha:0.9];
    self.collectionView.frame = CGRectMake(0, 128.0/2.0, w, h-128.0/2.0);
    assert = ASSETHELPER;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self initDate];
    assert.bReverse = YES;
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.clipsToBounds = NO;
    
    ImgNavBar* bar = [[ImgNavBar alloc] initWithFrame:CGRectMake(0, 0, w, 128.0/2.0)];
    bar.tag = 501;
    [self.view addSubview:bar];
    [self.view bringSubviewToFront:bar];
    
    ImgToolBar* bar2 = [[ImgToolBar alloc] initWithFrame:CGRectMake(0, h - 88.0/2.0, w, 88.0/2.0)];
    bar2.tag = 502;
    [self.view addSubview:bar2];
    [self.view bringSubviewToFront:bar2];
    //加了已经有的数量
    if (nil != [self.collectionView indexPathsForSelectedItems]) {
        [self setNowCount:[self.collectionView indexPathsForSelectedItems].count];
    }
}
-(void) handleEnterForeground:(NSNotification*)noc{
    [self initDate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initDate{
    if ([self.delegate respondsToSelector:@selector(ownAssets)]) {
        selectItems = [self.delegate ownAssets];
    }
    [assert getGroupList:^(NSArray *ag) {
        [self reloadData];
    }];
}
-(void)reloadData{
    NSInteger gc = [assert getGroupCount];
    sections = [[NSMutableArray alloc] init];
    cells = [[NSMutableArray alloc] init];
    for (int i=0; i<gc; i++) {
        NSDictionary* group = [assert getGroupInfo:i];
        NSInteger groupCount = [[group objectForKey:@"count"] integerValue];
        if (groupCount > 0) {
            [sections addObject:group];
            [assert getPhotoListOfGroupByIndex:i result:^(NSArray *imgs) {
                [cells addObject:imgs];
            }];
        }
    }
    [self.collectionView reloadData];
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
        if (nil != [self.collectionView indexPathsForSelectedItems]){
            [selectIndexs removeAllObjects];
            [selectItems removeAllObjects];
            [self setNowCount:[self.collectionView indexPathsForSelectedItems].count];
        }
    } else {
        [self setNowCount:0];
        [self dismissViewControllerAnimated:YES completion:^{
            if (isOK) {
                if (nil != [self.collectionView indexPathsForSelectedItems]){
                    NSArray* ips= [self.collectionView indexPathsForSelectedItems];
                    NSMutableArray* als = [[NSMutableArray alloc] init];
                    for (NSIndexPath* index in ips) {
                        NSArray* ar = [cells objectAtIndex:index.section];
                        ALAsset* al = [ar objectAtIndex:index.row];
                        [als addObject:al];
                    }
                    if (als.count > 0) {
                        [self.delegate didSelectAssets:als];
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
    ImgNavBar* bar2 = (ImgNavBar*)[self.view viewWithTag: 501];
    [bar2 okCount:count];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backWithNO) name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backWithOK) name:@"MSG_IMGS_OK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBadge:) name:@"MSG_SET_BADGE" object:nil];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_BACK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_IMGS_OK" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MSG_SET_BADGE" object:nil];
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"Shake..........");
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
                if (nil != [self.collectionView indexPathsForSelectedItems]){
                    NSArray* ips= [self.collectionView indexPathsForSelectedItems];
                    NSMutableArray* als = [[NSMutableArray alloc] init];
                    for (NSIndexPath* index in ips) {
                        NSArray* ar = [cells objectAtIndex:index.section];
                        ALAsset* al = [ar objectAtIndex:index.row];
                        [als addObject:al];
                    }
                    if (als.count > 0) {
                        [self.delegate didSelectAssets:als];
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
    return sections.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    NSDictionary* dic =[sections objectAtIndex:section];
    return [[dic objectForKey:@"count" ] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSArray* ar = [cells objectAtIndex:indexPath.section];
    ALAsset* al = [ar objectAtIndex:indexPath.row];
    UIImageView* imgv = (UIImageView*)[cell viewWithTag:202];
    imgv.image = [assert getImageFromAsset:al type:ASSET_PHOTO_THUMBNAIL];
    cell.index = indexPath;
    cell.asset = al;
    cell.maxCount = self.maxCount;
    [cell checkSelect];
    if (selectItems.count > 0) {
        for (ALAsset* item in selectItems) {
            if ([[al description] compare:[item description]] == NSOrderedSame) {
                [selectIndexs addObject:indexPath];
                [cell setSelect];
            }
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
    CGSize size = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(size.width, 80.0/2.0);
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
