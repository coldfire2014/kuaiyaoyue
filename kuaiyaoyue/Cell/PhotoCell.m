//
//  PhotoCell.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/18.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)del_onclick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(PhotoCellDelegate:didTapAtIndex:)]){
        [self.delegate PhotoCellDelegate:self didTapAtIndex:self.index];
    }
}

@end
