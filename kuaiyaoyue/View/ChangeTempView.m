//
//  ChangeTempView.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 14/12/25.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "ChangeTempView.h"
#import "myImageView.h"
#import "TempCell.h"
#import "DataBaseManage.h"

@implementation ChangeTempView

- (instancetype)initWithFrame:(CGRect)frame
{
//    CGRect br = [[UIScreen mainScreen] bounds];
//    frame = CGRectMake(-120+32, 64, 120, br.size.height-64);
    frame = CGRectMake(-120+32, 0, 120, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        UIView* btn = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width-44, self.bounds.size.height-71, 44, 49)];
        btn.backgroundColor = [UIColor clearColor];
        myImageView* bg = [[myImageView alloc] initWithFrame:CGRectMake(12, 0, 32, 49) andImageName:@"btn_sidebar" withScale:2.0];
        
//        UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 40)];
//        bg.backgroundColor = [[UIColor alloc] initWithWhite:0.7 alpha:0.5];
//        bg.center = CGPointMake(btn.bounds.size.width/2.0-8.0, btn.bounds.size.height/2.0);
//        bg.layer.cornerRadius = 5.0;
//        bg.layer.borderWidth = 1.5;
//        bg.layer.borderColor = [[UIColor alloc] initWithWhite:0.4 alpha:0.6].CGColor;
        [btn addSubview:bg];
//        myImageView* arr = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16) andImageName:@"ic_32_arr" withScale:2.0];
//        arr.tag = 302;
//        arr.center = CGPointMake(bg.bounds.size.width/2.0+3, 10);
//        [bg addSubview:arr];
//        myImageView* tp = [[myImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16) andImageName:@"ic_c_meeting" withScale:2.0];
//        tp.center = CGPointMake(bg.bounds.size.width/2.0+6, 30);
//        [bg addSubview:tp];
        [self addSubview:btn];
        
        UITapGestureRecognizer* didTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewInorOut)];
        [btn addGestureRecognizer:didTap];
        UITableView* table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120-32, self.bounds.size.height)];
        table.backgroundColor = [UIColor whiteColor];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.tag = 101;
        table.showsHorizontalScrollIndicator = NO;
        table.showsVerticalScrollIndicator = NO;
        table.dataSource = self;
        table.delegate = self;
        
        [self addSubview:table];
        UIView* line1 = [[UIView alloc] initWithFrame:CGRectMake(120-33.5, 0, 1.5, self.bounds.size.height)];
        line1.backgroundColor = [[UIColor alloc] initWithWhite:0.1 alpha:0.8];
        [self addSubview:line1];
//        UIView* line2 = [[UIView alloc] initWithFrame:CGRectMake(120-33.5, btn.frame.origin.y+bg.frame.origin.y+1, 1.5, bg.bounds.size.height-2)];
//        line2.backgroundColor = [UIColor whiteColor];
//        [self addSubview:line2];
    }
    return self;
}

- (void)viewInorOut{
    UIView* arr = [self viewWithTag:302];
    [UIView animateWithDuration:0.4 animations:^{
        if (self.frame.origin.x == 0) {
            self.center = CGPointMake(self.center.x-120+32, self.center.y);
            arr.layer.transform = CATransform3DIdentity;
        } else {
            self.center = CGPointMake(self.center.x+120-32, self.center.y);
            arr.layer.transform = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
        }
    }];
}

-(void)loadDate{
    NSLog(@"%d--%d",self.type,_type);
    UITableView* table = (UITableView*)[self viewWithTag:101];
    //0婚礼,1商务,2玩乐,3自定义
    NSString* neftypeId = @"";
    if (_type == 0) {
        neftypeId = @"1";
    }else if (_type == 1){
        neftypeId = @"2";
    }else if (_type == 2){
        neftypeId = @"3";
    }else if (_type == 3){
        neftypeId = @"4";
    }
    
    data = [[DataBaseManage getDataBaseManage] GetTemplate:neftypeId];
    if (data.count < 2) {
        data = [[NSArray alloc] init];
        self.alpha = 0;
        [table reloadData];
    } else {
        [table reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ViewCell";
    
    TempCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TempCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    Template *info = [data objectAtIndex:[indexPath row]];
    NSString *nefmbbg =[info.nefmbbg stringByReplacingOccurrencesOfString:@"preview" withString:@"thumb"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    nefmbbg = [documentsDirectory stringByAppendingString:nefmbbg];
    UIImage* imgt = [[UIImage alloc]initWithContentsOfFile:nefmbbg];
    UIImage* img = [[UIImage alloc] initWithCGImage:imgt.CGImage scale:2.0 orientation:UIImageOrientationUp];
    cell.image.image = img;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self viewInorOut];
    
    Template *info = [data objectAtIndex:[indexPath row]];
    [self.delegate didSelectTemplate:info];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    index_path = indexPath;
//    Userdata *info = [data objectAtIndex:[indexPath row]];
//    uniqueId = info.nefid;
//    starttime = [info.nefdate longLongValue]/1000;
//    endtime = [info.nefclosetimestamp longLongValue]/1000;
//    datatime = [info.neftimestamp longLongValue]/1000;
//    maxnum = info.neftotal;
//    
//    [self performSegueWithIdentifier:@"detail" sender:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
