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

@interface HLEditViewController ()<PhotoCellDelegate,ImgCollectionViewDelegate>{
    int count;
    NSMutableArray *imgdata;
    AssetHelper* assert;
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
    
    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, 550)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)initImgData{
    count = 9;
    GridInfo *info = [[GridInfo alloc] initWithDictionary:nil :NO];
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
        des.needAnimation = YES;
        des.delegate = self;
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
    
    _bottomview.clipsToBounds = YES;
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GridInfo *info = [self.data objectAtIndex:[indexPath row]];
    if (!info.is_open) {
        [self performSegueWithIdentifier:@"imgSelect" sender:nil];
    }else{
//        imgarray = [[NSMutableArray alloc] init];
//        
//        for (int i = 0; i < [self.data count]; i++) {
//            GridInfo *info1 = [self.data objectAtIndex:i];
//            if (info1.is_open) {
//                [imgarray addObject:info1.img];
//            }
//        }
//        imgindex = [indexPath row];
//        NSLog(@"%@",imgarray);
//        [self performSegueWithIdentifier:@"showimg" sender:nil];
    }
}

- (void)PhotoCellDelegate:(PhotoCell *)cell didTapAtIndex:(long ) index{
    GridInfo *info = [self.data objectAtIndex:index];
    [_data removeObject:info];
    [_gridview reloadData];
    count ++;
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
    
}

-(void)didSelectAssets:(NSArray*)items{
    NSLog(@"%@",items);
    for (int i = 0; i < items.count; i++)
    {
        ALAsset* al = [items objectAtIndex:i];
        UIImage *img = [assert getImageFromAsset:al type:ASSET_PHOTO_THUMBNAIL];
        GridInfo *info = [[GridInfo alloc] initWithDictionary:img :YES];
        [self.data addObject:info];
    }
    
    for (int j = 0;j< [self.data count] ; j++) {
        GridInfo *info = [self.data objectAtIndex:j];
        if (!info.is_open) {
            [self.data removeObject:info];
        }
    }
    
    GridInfo *info = [[GridInfo alloc] initWithDictionary:nil :NO];
    [self.data addObject:info];
    [self.gridview reloadData];
    count -= items.count;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self sethigh];
    }];
    
}

-(void)sethigh{
    long index = [_data count];
    long height = 161;
    if (index <= 3) {
        _bottomview.frame = CGRectMake(_bottomview.frame.origin.x, _bottomview.frame.origin.y, _bottomview.frame.size.width, height);
//        _gridview.frame = CGRectMake(_gridview.frame.origin.x, _gridview.frame.origin.y, _gridview.frame.size.width, 115);
    }else if(index > 3 && index <= 6){
        _bottomview.frame = CGRectMake(_bottomview.frame.origin.x, _bottomview.frame.origin.y, _bottomview.frame.size.width, height+115);
        [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, 550+115)];
//        _gridview.frame = CGRectMake(_gridview.frame.origin.x, _gridview.frame.origin.y, _gridview.frame.size.width, 115*2);
//        _gridview.contentSize = CGSizeMake(_gridview.frame.size.width, 115*2);
        NSLog(@"%f",_gridview.frame.size.height);
    }else if(index > 6 && index <= 9){
        _bottomview.frame = CGRectMake(_bottomview.frame.origin.x, _bottomview.frame.origin.y, _bottomview.frame.size.width, height+115*2);
        [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, 550+115*2)];
//        _gridview.frame = CGRectMake(_gridview.frame.origin.x, _gridview.frame.origin.y, _gridview.frame.size.width, 115*3);
    }
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    NSRange r = [[dismissed.classForCoder description] rangeOfString:@"ImgCollectionViewController"];
    if (r.length > 0 ) {
        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:NO];
        return ca;
    } else {
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    NSString* name = [presented.classForCoder description];
    NSRange r = [name rangeOfString:@"ImgCollectionViewController"];
    if (r.length > 0 ) {
        picViewAnimate* ca = [[picViewAnimate alloc] initWithPresent:YES];
        return ca;
    } else {
    }
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
}

@end
