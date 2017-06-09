//
//  ViewController.m
//  YBTestHUD
//
//  Created by EDZ on 2017/2/22.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD+Add.h"

#import "YBProgressHUD_Header.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)click:(UIButton *)sender
{
    [self.textField resignFirstResponder];
    
    //[self testSVProgressHUD];
    
    [self testMBProgressHUD];
    
    //[self testYBProgressHUD];
}

- (IBAction)pop:(UIButton *)sender
{
    YBInstanceProgressHUD.textColor = [UIColor whiteColor];
    [YBInstanceProgressHUD showMessage:@"测试一下"];
}

- (void)testYBProgressHUD
{
    NSString *tipString = @"超过20个字以后是什么样子呢让我们试试看效果看咋样了好吧这已经超过20个字了";
    
    /**第一种*/
    YBInstanceProgressHUD.backColor = [UIColor purpleColor];
    YBInstanceProgressHUD.cornerRadiusValue = 20;
    YBInstanceProgressHUD.spaceMarginValue = 20;
    YBInstanceProgressHUD.tipImageViewWH = 50;
    YBInstanceProgressHUD.selfOriginY = 0;
    YBInstanceProgressHUD.alphaValue = .8;
    YBInstanceProgressHUD.animationValue = 1.5;
    YBInstanceProgressHUD.textFont = [UIFont systemFontOfSize:15];
    YBInstanceProgressHUD.textColor = [UIColor greenColor];
    YBInstanceProgressHUD.tipImage = [UIImage imageNamed:@"yb_error"];
    [YBInstanceProgressHUD showMessage:tipString];
    
    /**第二种*/
    //[[YBProgressHUD shareInstance] showMessage:tipString];
    
    /**第三种*/
    //[YBInstanceProgressHUD showMessage:tipString withSuccessImage:nil];
    
    /**第四种*/
    //[YBInstanceProgressHUD showMessage:tipString withErrorImage:[UIImage imageNamed:@"icon-20"]];
    
    /**第五种*/
//    [YBInstanceProgressHUD showMessage:tipString withCompletion:^{
//        YBLog(@"纯文字——————回调成功——————");
//    }];
    
    /**第六种*/
//    [YBInstanceProgressHUD showMessage:tipString withErrorImage:nil withCompletion:^{
//        YBLog(@"error图片——————回调成功——————");
//    }];
    
    /**第七种*/
//    [YBInstanceProgressHUD showMessage:tipString withSuccessImage:nil withCompletion:^{
//        YBLog(@"success图片——————回调成功——————");
//    }];
}


- (void)testSVProgressHUD
{
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //[SVProgressHUD showImage:[UIImage imageNamed:@"alert_image"] status:@"超过20个字以后是什么样子呢让我们试试看效果看咋样了好吧这已经超过20个字了" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showImage:[UIImage imageNamed:@"alert_image"] status:@"超过20个字以后是什么样子呢让我们试试看效果看咋样了好吧这已经超过20个字了"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

- (void)testMBProgressHUD
{
    [MBProgressHUD showError:@"超过20个字以后是什么样子呢让我们试试看效果看咋样了好吧这已经超过20个字了"];
}

- (void)test
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //在次写耗时操作，如加载数据、上传图片等
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新UI
        });
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YBLog(@"----点击了view-----");
}

@end
