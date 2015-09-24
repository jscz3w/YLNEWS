//
//  WebViewController.h
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/18.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlValueDelegate.h"

@interface WebViewController : UIViewController<UIWebViewDelegate>
- (void)showViewUrlValue:(NSString *)url;
@end
