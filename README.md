# ADFView
利用RAC封装的一个首页弹出广告页，每天弹出一次

安装：
1、直接将下载的文件拉入项目中
2、引入开源库: reactivecocoa 2.5 、布局库SDAutoLayout、模型转换库MJExtension，MBProgressHUD，SDWebImage


引用：
//先判断今天是否已经显示，如果未显示则显示广告页
        if (![imgShowControl isTodayHaveShow]) {
            CpsAdView* adview=[CpsAdView adView];
               adview.tapblock=^(NSInteger num){
               NSLog(@"%ld",num);
            };
        }
    });




