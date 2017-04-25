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
#define selfCornerRadius 10
#define defaultAlpha 0.8
#define defaultImage_w_h 30*VIEWLAYOUT_W
#define BackColor [UIColor blackColor]
#define defaultDelayAnimationValue 1.

static YBProgressHUD *_progressHUD;


@interface YBProgressHUD ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGSize messageSize;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) CGSize selfSize;
@property (nonatomic, strong) UIImageView *tipImageView;

@end

@implementation YBProgressHUD

//@synthesize messageSize = _messageSize;
//@synthesize selfSize = _selfSize;


static dispatch_once_t onceToken;
#pragma mark - singleton
+ (YBProgressHUD *)shareInstance
{
    dispatch_once(&onceToken, ^{
        _progressHUD = [[YBProgressHUD alloc]init];
    });
    return _progressHUD;
}

+ (void)attemptDealloc
{
    onceToken = 0l;
    _progressHUD = nil;
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

#pragma mark - show method
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

- (void)showMessage:(NSString *)message withCompletion:(YBProgressHUDCompletion)completion
{
    self.message = message;
    
    [self initSelf];
    self.titleLabel.hidden = NO;
    if (self.tipImage) {
        self.tipImageView.hidden = NO;
    }
    
    [self dismissWithCompletion:completion];
}

- (void)showMessage:(NSString *)message withErrorImage:(UIImage *)errorImage
{
    if (errorImage) {
        self.tipImage = errorImage;
    }else {
        //YBLog(@"您选定的图片为空，已自动设成默认图片");
        self.tipImage = [UIImage imageNamed:@"yb_error"];
    }
    
    [self showMessage:message];
}

- (void)showMessage:(NSString *)message withErrorImage:(UIImage *)errorImage withCompletion:(YBProgressHUDCompletion)completion
{
    if (errorImage) {
        self.tipImage = errorImage;
    }else {
        //YBLog(@"您选定的图片为空，已自动设成默认图片");
        self.tipImage = [UIImage imageNamed:@"yb_error"];
    }
    
    [self showMessage:message withCompletion:completion];

}

- (void)showMessage:(NSString *)message withSuccessImage:(UIImage *)successImage
{
    if (successImage) {
        self.tipImage = successImage;
    }else {
        //YBLog(@"您选定的图片为空，已自动设成默认图片");
        self.tipImage = [UIImage imageNamed:@"yb_success"];
    }
    
    [self showMessage:message];
}


- (void)showMessage:(NSString *)message withSuccessImage:(UIImage *)successImage withCompletion:(YBProgressHUDCompletion)completion
{
    if (successImage) {
        self.tipImage = successImage;
    }else {
        //YBLog(@"您选定的图片为空，已自动设成默认图片");
        self.tipImage = [UIImage imageNamed:@"yb_success"];
    }
    
    [self showMessage:message withCompletion:completion];

}


- (void)dismiss
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.animationValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            [self.tipImageView removeFromSuperview];
            [self.titleLabel removeFromSuperview];
            self.titleLabel = nil;
            self.tipImageView = nil;
            self.textColor = TextColor;
            self.backColor = BackColor;
            self.tipImage = nil;
            self.cornerRadiusValue = selfCornerRadius;
            self.spaceMarginValue = spaceMargin;
            self.tipImageViewWH = defaultImage_w_h;
            _selfOriginY = 0;
            self.alphaValue = defaultAlpha;
            self.textFont = [UIFont systemFontOfSize:Font_size_value];
            self.animationValue = defaultDelayAnimationValue;
            [self removeFromSuperview];
            [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
            
        }];
    });

}

- (void)dismissWithCompletion:(YBProgressHUDCompletion)completion
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.animationValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            [self.tipImageView removeFromSuperview];
            [self.titleLabel removeFromSuperview];
            self.titleLabel = nil;
            self.tipImageView = nil;
            self.textColor = TextColor;
            self.backColor =BackColor;
            self.tipImage = nil;
            self.cornerRadiusValue = selfCornerRadius;
            self.spaceMarginValue = spaceMargin;
            self.tipImageViewWH = defaultImage_w_h;
            _selfOriginY = 0;
            self.alphaValue = defaultAlpha;
            self.textFont = [UIFont systemFontOfSize:Font_size_value];
            self.animationValue = defaultDelayAnimationValue;
            [self removeFromSuperview];
            [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
            
            if (completion) {
                completion();
            }
        }];
    });
    
}

#pragma mark - custom getter

- (CGSize)getSelfSize
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

- (CGSize)getMessageSize
{
    _messageSize = [self sizeWithFont:self.textFont withString:self.message maxSize:CGSizeMake(FULL_SCREEN_WIDTH*2/3, FULL_SCREEN_HEIGHT/2)];
    CGFloat widthMessage = _messageSize.width>100?_messageSize.width:100;
    _messageSize = CGSizeMake(widthMessage + self.spaceMarginValue, _messageSize.height + self.spaceMarginValue + 5);//手动加5
    return _messageSize;
}

- (CGFloat)getTipImageViewWH
{
    if (_tipImageViewWH <= 0)
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

- (CGFloat)getSpaceMarginValue
{
    if (_spaceMarginValue>ProgressHUD_W || _spaceMarginValue == 0)
    {
        _spaceMarginValue = spaceMargin;
    }
    return _spaceMarginValue;
}

- (CGFloat)getSelfOriginY
{
    if ( _selfOriginY<=0 || _selfOriginY > FULL_SCREEN_HEIGHT) {
        _selfOriginY = FULL_SCREEN_HEIGHT/2 - self.selfSize.height/2;
    }
    return _selfOriginY;
}

- (CGFloat)getAnimationValue
{
    if (_animationValue>30 || _animationValue<=0) {
        _animationValue = defaultDelayAnimationValue;
    }
    return _animationValue;
}

- (CGFloat)getAlphaValue
{
    if (_alphaValue<=0 || _alphaValue>1) {
        _alphaValue =  defaultAlpha;
    }
    return _alphaValue;
}

- (CGFloat)getCornerRadiusValue
{
    if (_cornerRadiusValue==0 || _cornerRadiusValue >ProgressHUD_W/2)
    {
        _cornerRadiusValue = selfCornerRadius;
    }
    return _cornerRadiusValue;
}

- (void)initSelf
{
    //YBLog(@"原始的：%f",self.tipImageViewWH);
    
    self.cornerRadiusValue = [self getCornerRadiusValue];
    self.alphaValue = [self getAlphaValue];
    self.animationValue = [self getAnimationValue];
    self.spaceMarginValue = [self getSpaceMarginValue];
    self.tipImageViewWH = [self getTipImageViewWH];
    self.messageSize = [self getMessageSize];
    self.selfSize = [self getSelfSize];
    self.selfOriginY = [self getSelfOriginY];
    
    self.frame = CGRectMake(FULL_SCREEN_WIDTH/2 - self.selfSize.width/2, self.selfOriginY, self.selfSize.width, self.selfSize.height);
    
    self.backgroundColor = self.backColor;
    self.alpha = self.alphaValue;
    self.layer.cornerRadius = self.cornerRadiusValue;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - overide getter
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
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - (self.messageSize.width-self.spaceMarginValue)/2, self.frame.size.height - self.messageSize.height, self.messageSize.width-_spaceMarginValue, self.messageSize.height)];
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

- (void)setEnableClickBackView:(BOOL)EnableClickBackView
{
    if (EnableClickBackView)
    {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    }else
    {
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
    }
}

- (UIColor *)backColor
{
    if (!_backColor) {
        _backColor = BackColor;
    }
    return _backColor;
}

- (UIFont *)textFont
{
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:Font_size_value];
    }
    return _textFont;
}

- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = TextColor;
    }
    return _textColor;
}

#pragma mark - private method
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
