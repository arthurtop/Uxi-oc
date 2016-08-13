//
//  ViewController.m
//  Uxi-oc
//
//  Created by jecansoft on 16/8/12.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <UIButton+LCAlignment.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"facebook" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:@"icon_facebook"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.right.bottom.offset(0);
        make.top.bottom.offset(10);
        //make.
    }];
    
    
    [btn lc_titleImageHorizontalAlignmentWithSpace:10];
    [btn lc_titleImageVerticalAlignmentWithSpace:10];
    //[btn lc_imageTitleVerticalAlignmentWithSpace:10];
    //[btn lc_imageTitleHorizontalAlignmentWithSpace:10];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
