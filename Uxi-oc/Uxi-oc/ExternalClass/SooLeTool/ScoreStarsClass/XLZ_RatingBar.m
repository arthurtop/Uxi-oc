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


- (void)xlz_setImagesArray:(NSArray *)arrImgs andDelegate:(id<RetingBarDelegate>)delegate{
    
    self.delegate = delegate;
    
    unSelectImg = [UIImage imageNamed:arrImgs[0]];
    halfSelectImg = arrImgs[0] == nil ?unSelectImg:[UIImage imageNamed:arrImgs[1]];
    fullSelectImg = [UIImage imageNamed:arrImgs[2]];
    
    height = 0.0;
    width = 0.0;
    
    
    
}

- (void)xlz_setImagesArray:(NSArray *)arrImgs ratingBlcok:(XLZRatingChangedBlock)changedBlock{
    
    
    
    
    
}

- (void)displayRating:(float)rating{
    
    
}

- (float)rating{
    
    return 10;
}























/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





@end





