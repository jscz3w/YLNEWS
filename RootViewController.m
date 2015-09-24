//
//  RootViewController.m
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/18.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "RootViewController.h"
#import "WebViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //self.navigationItem.title=@"常用内部网址";

    UIImage *aTopImg = [UIImage imageNamed:@"top@2x"];

    UIImageView * imgView =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,170)];
    imgView.image = aTopImg;
    
    [self.view addSubview:imgView];
    
    UIImage *aBackGround=[UIImage imageNamed:@"background@2x"];
    
    UIColor *aColor =[UIColor colorWithPatternImage:aBackGround];
    
    self.view.backgroundColor=aColor;
    
    UITableView *urlTableView =  [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+150, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    urlTableView.delegate=self;
    urlTableView.dataSource=self;
    
    [self.view addSubview:urlTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置节段数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置节段行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
        
    }
    
    
    return 1;
}

//初始化行数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                
                reuseIdentifier:CellIdentifier] ;
         }
    
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            cell.textLabel.text = @"管理信息系统（MIS）" ;
            //            cell.imageView.image=[UIImage imageNamed:@"btn_self_check_selected@2x.png"];
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"公司主页" ;
            //            cell.imageView.image=[UIImage imageNamed:@"health_data_600.png"];
        }
        if (indexPath.row==2) {
            cell.textLabel.text = @"神华邮箱" ;
            //            cell.imageView.image=[UIImage imageNamed:@"health_data_600.png"];
        }
        
        
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
//    if (indexPath.section==1) {
//        
//        cell.textLabel.text=@"关于";
//        
//        
//    }
    
    
    
    return cell;
    
}
//选择行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        
//        WebViewController * login = [[WebViewController alloc]init];
//        [login showViewUrlValue:@"http://www.shenhuagroup.com.cn"];
//        
//        UINavigationController * LoginNC =  [[UINavigationController alloc]initWithRootViewController:login];
//    
//        [self.navigationController presentViewController:LoginNC animated:YES completion:^{
//            NSLog(@"login....");
//        }];
        if (indexPath.row==0) {
            //亿利电厂MIS
        NSURL* MISurl = [[ NSURL alloc ] initWithString :@"http://10.229.128.25:8080/mis"];
        [[UIApplication sharedApplication ] openURL:MISurl];
         
         }
        if (indexPath.row==1) {
            //亿利电厂主页
            NSURL* MISurl = [[ NSURL alloc ] initWithString :@"http://10.229.128.8"];
            [[UIApplication sharedApplication ] openURL:MISurl];
            
        }

        if (indexPath.row==2) {
            //神华邮箱
            NSURL* MISurl = [[ NSURL alloc ] initWithString :@"http://portalwg.shenhua.cc/oimdiy/login.jsp?appname=webcenter"];
            [[UIApplication sharedApplication ] openURL:MISurl];
            
        }
        
    }
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return 68.0;
    }
    return 40;
    
}

//设置节段注脚
-(NSString * )tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return @"访问内部网址手机需连接内部WIFI状态";
    }
    return @"";
    
}

//设置节段注头
-(NSString * )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if (section==0) {
//        return @"常用内部网址";
//    }
    return @"";
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
