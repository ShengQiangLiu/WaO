//
//  Macro.h
//  WaO
//
//  Created by admin on 15/9/20.
//  Copyright © 2015年 ShengQiangLiu. All rights reserved.
//

#ifndef Macro_h
#define Macro_h
// 颜色
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

// 比例
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define HScale(a) (a*(ScreenWidth/320.0))
#define VScale(a) a*(ScreenHeight/568.0)

#endif /* Macro_h */
