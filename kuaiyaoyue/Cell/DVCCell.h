//
//  DVCCell.h
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/16.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DVCCellDelegate <NSObject>

-(void)didSelectItemAtIndex:(NSIndexPath*)index;
-(void)didShowPhone:(NSString*) phone;
@end

@interface DVCCell : UITableViewCell

@property(nonatomic, weak) id<DVCCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *show_name;
@property (weak, nonatomic) IBOutlet UILabel *show_num;
@property (weak, nonatomic) IBOutlet UIButton *show_message;
@property (weak, nonatomic) IBOutlet UIButton *show_phone;
@property (weak, nonatomic) IBOutlet UIView *show_view;
@property (weak, nonatomic) IBOutlet UILabel *show_content;
- (IBAction)message_onclick:(id)sender;
- (IBAction)phone_onclick:(id)sender;
@property (nonatomic, strong) NSString* phone;
@property (nonatomic, strong) NSString* talk;
@property (nonatomic, strong) NSIndexPath* index;


@end
