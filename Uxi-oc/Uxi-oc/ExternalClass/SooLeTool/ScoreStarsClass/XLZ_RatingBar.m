//
//  XLZ_RatingBar.m
//  Uxi-oc
//
//  Created by jecansoft on 16/8/17.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import "XLZ_RatingBar.h"


@interface XLZ_RatingBar(){
    float starRating;
    float lastRating;
    
    float height;
    float width;
    
    UIImage *unSelectImg;
    UIImage *halfSelectImg;
    UIImage *fullSelectImg;
    
}

@property (nonatomic, strong) UIImageView *img1;
@property (nonatomic, strong) UIImageView *img2;
@property (nonatomic, strong) UIImageView *img3;
@property (nonatomic, strong) UIImageView *img4;
@property (nonatomic, strong) UIImageView *img5;


@end

@implementation XLZ_RatingBar


- (void)xlz_setImageDeselected:(NSString *)deselectName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<RetingBarDelegate>)delegate{
    
    self.delegate = delegate;
    
    unSelectImg = [UIImage imageNamed:deselectName];
    halfSelectImg = halfSelectedName == nil ?unSelectImg:[UIImage imageNamed:halfSelectedName];
    fullSelectImg = [UIImage imageNamed:fullSelectedName];
    
    height = 0.0;
    width = 0.0;
    
    
    
}


- (void)xlz_setScoreStarSelectImages:(XLZScoreStarImages)starImages delegate:(id<RetingBarDelegate>)delegate{
    
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
