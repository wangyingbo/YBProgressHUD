//
//  YBProgressHUD.m
//  YBTestHUD
//
//  Created by EDZ on 2017/3/1.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "YBProgressHUD.h"
#import "YBProgressHUD_Header.h"

//屏幕的宽和高
#define FULL_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define FULL_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define VIEWLAYOUT_W  FULL_SCREEN_WIDTH/375
#define VIEWLAYOUT_H  FULL_SCREEN_HEIGHT/667

#define ProgressHUD_W FULL_SCREEN_WIDTH*2/3
#define Font_size_value 15*VIEWLAYOUT_H
#define TextColor [UIColor whiteColor]
#define spaceMargin 15
#define selfCornerRadius 5
#define defaultAlpha 0.8
#define defaultImage_w_h 30*VIEWLAYOUT_W

static YBProgressHUD *_progressHUD;


@interface YBProgressHUD ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGSize messageSize;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) CGSize selfSize;
@property (nonatomic, strong) UIImageView *tipImageView;

@end

@implementation YBProgressHUD

#pragma mark - singleton
+ (YBProgressHUD *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _progressHUD = [[YBProgressHUD alloc]init];
    });
    return _progressHUD;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _progressHUD = [super allocWithZone:zone];
    });
    return _progressHUD;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _progressHUD;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _progressHUD;
}

#pragma mark - private method
- (void)showMessage:(NSString *)message
{
    self.message = message;
    
    [self initSelf];
    self.titleLabel.hidden = NO;
    if (self.tipImage) {
        self.tipImageView.hidden = NO;
    }
    
    [self dismiss];
    
}

- (void)showMessage:(NSString *)message withErrorImage:(UIImage *)errorImage
{
    if (errorImage) {
        self.tipImage = errorImage;
    }else {
        YBLog(@"您选定的图片为空，已自动设成默认图片");
        self.tipImage = [UIImage imageNamed:@"yb_error"];
    }
    
    [self showMessage:message];
}

- (void)showMessage:(NSString *)message withSuccessImage:(UIImage *)successImage
{
    if (successImage) {
        self.tipImage = successImage;
    }else {
        YBLog(@"您选定的图片为空，已自动设成默认图片");
        self.tipImage = [UIImage imageNamed:@"yb_success"];
    }
    
    [self showMessage:message];
}


- (void)dismiss
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.animationValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            [self.tipImageView removeFromSuperview];
            [self.titleLabel removeFromSuperview];
            self.titleLabel = nil;
            self.tipImageView = nil;
            [self removeFromSuperview];
            [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
        }];
    });

}

- (CGSize)selfSize
{
    if (self.tipImage)
    {
        _selfSize = CGSizeMake(self.messageSize.width, self.messageSize.height + self.tipImageViewWH + self.spaceMarginValue);
    }else
    {
        _selfSize = self.messageSize;
    }
    return _selfSize;
}

- (CGSize)messageSize
{
    _messageSize = [self sizeWithFont:self.textFont withString:self.message maxSize:CGSizeMake(FULL_SCREEN_WIDTH*2/3, FULL_SCREEN_HEIGHT/2)];
    _messageSize = CGSizeMake(_messageSize.width + self.spaceMarginValue, _messageSize.height + self.spaceMarginValue + 5);//手动加5
    return _messageSize;
}

- (void)initSelf
{
    self.frame = CGRectMake(FULL_SCREEN_WIDTH/2 - self.selfSize.width/2, FULL_SCREEN_HEIGHT/2 - self.selfSize.height/2, self.selfSize.width, self.selfSize.height);
    
    self.backgroundColor = self.backColor;
    self.alpha = self.alphaValue;
    self.layer.cornerRadius = self.cornerRadiusValue;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (UIImageView *)tipImageView
{
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - self.tipImageViewWH/2, self.spaceMarginValue, self.tipImageViewWH, self.tipImageViewWH)];
        _tipImageView.image = self.tipImage;
        _tipImageView.hidden = YES;
        [self addSubview:_tipImageView];
    }
    return _tipImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - self.messageSize.width/2, self.frame.size.height - self.messageSize.height, self.messageSize.width, self.messageSize.height)];
        _titleLabel.text = self.message;
        _titleLabel.textColor = self.textColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = self.textFont;
        _titleLabel.hidden = YES;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (CGFloat)tipImageViewWH
{
    if (!_tipImageViewWH)
    {
        _tipImageViewWH = defaultImage_w_h;
    }
    else
    {
        if (_tipImageViewWH>ProgressHUD_W) {
            _tipImageViewWH = ProgressHUD_W;
        }
    }
    return _tipImageViewWH;
}

- (void)setEnableClickBackView:(BOOL)EnableClickBackView
{
    if (EnableClickBackView) {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    }else{
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
    }
}

- (CGFloat)spaceMarginValue
{
    if (!_spaceMarginValue) {
        _spaceMarginValue = spaceMargin;
    }
    return _spaceMarginValue;
}

- (UIColor *)backColor
{
    if (!_backColor) {
        _backColor = [UIColor blackColor];
    }
    return _backColor;
}

- (CGFloat)animationValue
{
    if (!_animationValue) {
        _animationValue = 1.;
    }
    return _animationValue;
}

- (UIFont *)textFont
{
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:Font_size_value];
    }
    return _textFont;
}

- (CGFloat)alphaValue
{
    if (!_alphaValue) {
        _alphaValue =  defaultAlpha;
    }
    if (_alphaValue>1) {
        _alphaValue = defaultAlpha;
    }
    return _alphaValue;
}

- (CGFloat)cornerRadiusValue
{
    if (!_cornerRadiusValue) {
        _cornerRadiusValue = selfCornerRadius;
    }
    return _cornerRadiusValue;
}


- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = TextColor;
    }
    return _textColor;
}

-(CGSize)sizeWithFont:(UIFont *)font withString:(NSString *)string maxSize:(CGSize)maxSize
{
    //根据系统版本确定使用哪个api
    CGSize resultSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        //段落样式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        //字体大小，换行模式
        NSDictionary *attributes = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
        
        resultSize = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else
    {
        //计算文字显示需要的区域
        resultSize = [string sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return resultSize;
}
@end
