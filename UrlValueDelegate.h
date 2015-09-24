//
//  UrlValueDelegate.h
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/18.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UrlValueDelegate <NSObject>

@optional
- (void)showViewUrlValue:(NSString *)url;

@end
