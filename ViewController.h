//
//  ViewController.h
//  NetWorkStudy
//
//  Created by WangZhengHong on 15/7/31.
//  Copyright (c) 2015年 WangZhengHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSMutableData *responseData;
@property (strong,nonatomic) NSMutableString *captureCharacters;
@property (nonatomic)BOOL inItemElement;
-(void) parserXML;

@end

