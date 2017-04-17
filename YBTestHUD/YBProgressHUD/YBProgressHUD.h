//
//  YBProgressHUD.h
//  YBTestHUD
//
//  Created by EDZ on 2017/3/1.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^YBProgressHUDCompletion)();

@interface YBProgressHUD : UIView

/**提示文本颜色*/
@property (nonatomic, assign) UIColor *textColor;
/**背景颜色*/
@property (nonatomic, assign) UIColor *backColor;
/**图片*/
@property (nonatomic, strong) UIImage *tipImage;
/**圆角*/
@property (nonatomic, assign) CGFloat cornerRadiusValue;
/**间隙*/
@property (nonatomic, assign) CGFloat spaceMarginValue;
/**图片大小*/
@property (nonatomic, assign) CGFloat tipImageViewWH;
/**HUD位置*/
@property (nonatomic, assign) CGFloat selfOriginY;
/**透明度，大于1的时候自动为0.8*/
@property (nonatomic, assign) CGFloat alphaValue;
/**提示字体*/
@property (nonatomic, assign) UIFont *textFont;
/**动画时长，设置多久后消失*/
@property (nonatomic, assign) CGFloat animationValue;
/**是否支持出现提示框时下层的view可点击*/
@property (nonatomic, assign) BOOL EnableClickBackView;

/**
 * 初始化
 */
+ (YBProgressHUD *)shareInstance;

/**
 * 销毁
 */
+ (void)attemptDealloc;

/**
 * 提示文字层
 */
- (void)showMessage:(NSString *)message;

/**
 * 提示文字层，提示成功回调
 */
- (void)showMessage:(NSString *)message withCompletion:(YBProgressHUDCompletion)completion;

/**
 * 提示文字，并设定出错时的图片
 */
- (void)showMessage:(NSString *)message withErrorImage:(UIImage *)errorImage;

/**
 * 提示文字，并设定出错时的图片，提示成功回调
 */
- (void)showMessage:(NSString *)message withErrorImage:(UIImage *)errorImage withCompletion:(YBProgressHUDCompletion)completion;

/**
 * 提示文字，并设定成功时的图片
 */
- (void)showMessage:(NSString *)message withSuccessImage:(UIImage *)successImage;

/**
 * 提示文字，并设定成功时的图片，提示成功回调
 */
- (void)showMessage:(NSString *)message withSuccessImage:(UIImage *)successImage withCompletion:(YBProgressHUDCompletion)completion;

@end
