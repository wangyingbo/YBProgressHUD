#  [YBProgressHUD](https://github.com/wangyingbo/YBProgressHUD)

##### 一、大家在iOS开发中用的提示框一直都是SVProgressHUD或者MBProgressHUD，不过最近我在用这两个框架开发时，发现了这两个框架各有各自的不足的地方，比如：

+ SVProgressHUD在有键盘弹出时，加载提示框会有一个分段时的落差；提示框会先在上面，等键盘落下以后才能显示在正常位置。在我自己看来是很正常的，不过产品经理不满意，就只能改了，如图：

![SVProgressHUD](https://raw.githubusercontent.com/wangyingbo/YBProgressHUD/master/images/sv.gif)

+ MBProgressHUD虽然没有键盘落差这个问题，但是它也有一个硬伤，就是当文字过长时，不能自动换行，只能一行显示。如图：

![](https://raw.githubusercontent.com/wangyingbo/YBProgressHUD/master/images/mb.gif)



##### 二、接下来就要YBProgressHUD出场了。YBProgressHUD完美解决了这两个问题。

+ 支持自定义属性，提供了自定义属性的好多接口

![attribute](https://raw.githubusercontent.com/wangyingbo/YBProgressHUD/master/images/attribute.png)

+ 多种方法调用

![method](https://raw.githubusercontent.com/wangyingbo/YBProgressHUD/master/images/method.png)

+ 效果图如下

![YBProgressHUD](https://raw.githubusercontent.com/wangyingbo/YBProgressHUD/master/images/yb.gif)

   
+ 接入也很简单，只需导入`YBProgressHUD_Header.h`就可以使用了，调用的时候有以下几种方式：



![call_method](https://raw.githubusercontent.com/wangyingbo/YBProgressHUD/master/images/call_method.png)


    - (void)testYBProgressHUD
    {
        NSString *tipString = @"超过20个字以后是什么样子呢让我们试试看效果看咋样了好吧这已经超过20个字了";
        
        /**第一种*/
        YBInstanceProgressHUD.tipImage = [UIImage imageNamed:@"yb_error"];
        [YBInstanceProgressHUD showMessage:tipString];
        
        /**第二种*/
        [[YBProgressHUD shareInstance] showMessage:tipString];
        
        /**第三种*/
        [YBInstanceProgressHUD showMessage:tipString withSuccessImage:nil];
        
        /**第四种*/
        [YBInstanceProgressHUD showMessage:tipString withErrorImage:[UIImage imageNamed:@"icon-20"]];
        
        /**第五种*/
        [YBInstanceProgressHUD showMessage:tipString withCompletion:^{
            YBLog(@"纯文字——————回调成功——————");
        }];
        
        /**第六种*/
        [YBInstanceProgressHUD showMessage:tipString withErrorImage:nil withCompletion:^{
            YBLog(@"error图片——————回调成功——————");
        }];
        
        /**第七种*/
        [YBInstanceProgressHUD showMessage:tipString withSuccessImage:nil withCompletion:^{
            YBLog(@"success图片——————回调成功——————");
        }];
    }

+ 说明

1、用第一种方法调用时，可以设置多种属性，再调起方法。需要注意的是各种属性需在调起方法之前设置才有效。

2、用`[YBProgressHUD shareInstance]`和`YBInstanceProgressHUD`方法调起是一样的，因为用的是单例类，为了方便使用了宏定义。


        
##### 三、最后，放上项目地址，欢迎大家fork和star。 [YBProgressHUD](https://github.com/wangyingbo/YBProgressHUD)


