//
//  EditViewController.m
//  kuaiyaoyue
//
//  Created by DavidWang on 14/12/27.
//  Copyright (c) 2014年 davidwang. All rights reserved.
//

#import "EditViewController.h"
#import "UDObject.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *name;
    if (_type == 0) {
        name = @"姓名";
        _content_edit.text = [UDObject getXM];
    }else{
        name = @"联系方式";
        _content_edit.text = [UDObject getLXFS];
    }
    
    UIColor *color = [[UIColor alloc] initWithRed:255.0/255.0 green:88.0/255.0 blue:88.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = name;
    [label sizeToFit];
    label.textColor = color;
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
    [self.navigationItem setTitleView:label];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    
    _content_edit.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)right{
    [self save];
}

- (IBAction)content_next:(id)sender {
    [self save];
}

-(void)save{
    NSString *content = _content_edit.text;
    if (content.length > 0) {
        if (_type == 0) {
            [UDObject setXM:content];
        }else{
            [UDObject setLXFS:content];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
   if (textField == _content_edit){
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    return YES;
}

@end
