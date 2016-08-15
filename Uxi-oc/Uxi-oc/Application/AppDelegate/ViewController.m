//
//  ViewController.m
//  Uxi-oc
//
//  Created by jecansoft on 16/8/12.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import "ViewController.h"


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
        make.topMargin.bottom.offset(0);
        
    }];
    
    
    /**
     *  自在前 图在后  横向
     */
    [btn lc_titleImageHorizontalAlignmentWithSpace:0];
    
    /**
     *  字在上 图在下 横向
     */
    [btn lc_titleImageVerticalAlignmentWithSpace:0];
    
    /**
     *  图在下 字在上 纵向(竖着)
     */
    [btn lc_imageTitleHorizontalAlignmentWithSpace:0];
    
    /**
     *  图在上 字在下 纵向(竖着)
     */
    [btn lc_imageTitleVerticalAlignmentWithSpace:0];
    
    
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""] highlightedImage:[UIImage imageNamed:@""]];
    
    imgView.layer.cornerRadius = 10;
    imgView.layer.borderWidth = 1;
    imgView.layer.borderColor = [UIColor greenColor].CGColor;
    [self.view addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.right.bottom.offset(0);
    }];
    
    
    
    
    UIView *view = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor colorWithRed:190.0f/255 green:31.0f/255 blue:44.0f/255 alpha:1.0f];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
        /**
         *  等价于
         make.top.equalTo(view).with.offset(10);
         make.left.equalTo(view).with.offset(10);
         make.bottom.equalTo(view).with.offset(-10);
         make.right.equalTo(view).with.offset(-10);
         */
        
        /**
         *  也等价于
         make.top.left.bottom.and.right.equalTo(view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
         */
        
        
        
        
    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
