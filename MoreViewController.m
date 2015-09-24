//
//  MoreViewController.m
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/19.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *aBackGround=[UIImage imageNamed:@"background@2x"];
    
    UIColor *aColor =[UIColor colorWithPatternImage:aBackGround];
    
    self.view.backgroundColor=aColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
