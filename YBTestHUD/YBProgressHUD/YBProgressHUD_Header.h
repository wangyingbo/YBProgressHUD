
//
//  YBProgressHUD_Header.h
//  YBTestHUD
//
//  Created by EDZ on 2017/3/2.
//  Copyright © 2017年 王颖博. All rights reserved.
//

#ifndef YBProgressHUD_Header_h
#define YBProgressHUD_Header_h


#import "YBProgressHUD.h"
#define YBInstanceProgressHUD [YBProgressHUD shareInstance]
//自定义高效率的 NSLog
#ifdef DEBUG
#define YBLog(...) NSLog(@"打印：\n%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define YBLog(...)
#endif



#endif /* YBProgressHUD_Header_h */
