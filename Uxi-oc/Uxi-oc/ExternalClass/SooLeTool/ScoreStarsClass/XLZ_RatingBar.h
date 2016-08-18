//
//  XLZ_RatingBar.h
//  Uxi-oc
//
//  Created by jecansoft on 16/8/17.
//  Copyright © 2016年 zyhl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ XLZRatingChangedBlock)(float newRating);

@protocol RetingBarDelegate <NSObject>

- (void)ratingChanged:(float)newRating;


@end


@interface XLZ_RatingBar : UIView

@property (nonatomic, weak) id <RetingBarDelegate> delegate;


/**
 *  是否是指示器，如果是指示器，就不能滑动了，只显示结果，不是指示器的话就能滑动修改值
 *  默认为NO
 */
@property (nonatomic,assign) BOOL isIndicator;


/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用Block）实现
 *  @param arrImgs  未选 半选 全选 图
 *  @param delegate         代理
 */
- (void)xlz_setImagesArray:(NSArray *)arrImgs andDelegate:(id<RetingBarDelegate>)delegate;

/**
 *  block 实现
 */
- (void)xlz_setImagesArray:(NSArray *)arrImgs ratingBlcok:(XLZRatingChangedBlock )changedBlock;


/**
 *  设置评分
 *  @param rating 评分值
 */
- (void)displayRating:(float)rating;



/**
 *  获取当前评分值
 *
 *  @return 评分值
 */
- (float)rating;





@end
