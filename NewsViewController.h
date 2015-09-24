//
//  NewsViewController.h
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/19.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UIScrollViewDelegate,NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableData *responseData;
@property (strong,nonatomic) NSMutableString *captureCharacters;
@property (nonatomic)BOOL inItemElement;
-(void) parserXML;

@end
