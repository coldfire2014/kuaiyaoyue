//
//  myPicItem.m
//  kuaiyaoyue
//
//  Created by wuyangbing on 15/2/28.
//  Copyright (c) 2015年 davidwang. All rights reserved.
//

#import "myPicItem.h"
#import "PCHeader.h"
#import "FileManage.h"
@implementation myPicItem
- (instancetype)initWithFrame:(CGRect)rect fromAsset:(ALAsset*)al andThumb:(UIImage*)img orFile:(NSString*)fileName
{
    self = [super initWithFrame:rect];
    if (self) {
        self.uploaded = NO;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        UIImageView* image = [[UIImageView alloc] initWithFrame:rect];
        image.tag=11;
        [self addSubview:image];
        if ([fileName compare:@""] == NSOrderedSame) {
            image.image = img;
            [self performSelectorInBackground:@selector(loadImage:) withObject:al];
        } else {
            self.fileName = [[NSString alloc] initWithFormat:@"%@",fileName];
            NSArray* arr = [self.fileName componentsSeparatedByString:@"/"];
            self.localName = [[NSString alloc] initWithFormat:@"../Image/%@",[arr lastObject]];
            [self resetImage];
        }
        UIView *removeBtn = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width - 44, 0, 44, 44)];
        removeBtn.backgroundColor = [UIColor clearColor];
        removeBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMe)];
        [removeBtn addGestureRecognizer:tap];
        UIView *yuan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        yuan.backgroundColor = [UIColor redColor];
        yuan.layer.borderColor = [[UIColor alloc] initWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0].CGColor;
        yuan.layer.borderWidth = 1;
        yuan.layer.cornerRadius = 12;
        [removeBtn addSubview:yuan];
        yuan.center = CGPointMake(removeBtn.bounds.size.width/2.0, removeBtn.bounds.size.height/2.0);
        yuan.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
        CGFloat h = yuan.bounds.size.width*0.618;
        CGFloat w = 3.0;
        UIView *hen = [[UIView alloc] initWithFrame:CGRectMake(0, 0, h, w)];
        hen.backgroundColor = [UIColor whiteColor];
        hen.layer.cornerRadius = 1.0;
        hen.center = CGPointMake(yuan.bounds.size.width/2.0, yuan.bounds.size.height/2.0);
        [yuan addSubview:hen];
        UIView *shu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        shu.backgroundColor = [UIColor whiteColor];
        shu.layer.cornerRadius = 1.0;
        shu.center = CGPointMake(yuan.bounds.size.width/2.0, yuan.bounds.size.height/2.0);
        [yuan addSubview:shu];
        [self addSubview:removeBtn];
    }
    return self;
}
-(void)removeMe{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_REMOVE_ME" object:[NSNumber numberWithInteger:[self superview].tag]];
}
-(void)loadImage:(ALAsset*)al{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuid= (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    uuid = [NSString stringWithFormat:@"%@.jpg",uuid];
    UIImage* fullImage = [[AssetHelper sharedAssetHelper] getImageFromAsset:al type:ASSET_PHOTO_SCREEN_SIZE];
    self.fileName = [[[FileManage sharedFileManage] imgDirectory] stringByAppendingPathComponent:uuid];
    [UIImageJPEGRepresentation(fullImage,C_JPEG_SIZE) writeToFile:self.fileName atomically:YES];
    self.localName = [[NSString alloc] initWithFormat:@"../Image/%@",uuid];
    [self performSelectorOnMainThread:@selector(resetImage) withObject:nil waitUntilDone:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MSG_ADD_ME" object:[NSNumber numberWithInteger:[self superview].tag]];
}
-(void)resetImage{
    UIImageView* image = (UIImageView*)[self viewWithTag:11];
    UIImage* img = [[UIImage alloc] initWithContentsOfFile:self.fileName];
    CGFloat img_w = img.size.width;
    CGFloat img_h = img.size.height;
    if (img_w/img_h > self.bounds.size.width/self.bounds.size.height) {
        image.frame = CGRectMake(0, 0, self.bounds.size.width, img_h/img_w*self.bounds.size.width);
    } else {
        image.frame = CGRectMake(0, 0, img_w/img_h*self.bounds.size.height, self.bounds.size.height);
    }
    image.image = [[UIImage alloc] initWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
    image.center = CGPointMake(self.bounds.size.width/2.0,self.bounds.size.height/2.0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
