//
//  WebViewController.m
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/18.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "WebViewController.h"
#import "SDProgressView.h"

@interface WebViewController ()

@property (nonatomic,strong)NSString * webURL;
@property (nonatomic,strong)UIWebView *webView;
@end

SDRotationLoopProgressView *aProgressView;

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect bounds = self.view.frame;  //获取界面区域
    self.webView =[[UIWebView alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)];
    
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    
    
    aProgressView =[[SDRotationLoopProgressView alloc]initWithFrame:CGRectMake((bounds.size.width-bounds.origin.x)/2-50, bounds.origin.y+200,100, 100)];
    
    
    [self.view addSubview:aProgressView];

//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"www.sohu.com" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
    //[barBtn setTitle:@"取消"];
    
    
    [self.webView setScalesPageToFit:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]];
    [self.webView loadRequest:request];
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(btn_click)];
    self.navigationItem.leftBarButtonItem=barBtn;
    

}


- (void)showViewUrlValue:(NSString *)url
{
    
    //NSLog(@"url=%@",url);
    _webURL=url;
    
    
}

-(void)btn_click
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss finished");
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [activityIndicatorView startAnimating];
//}
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [activityIndicatorView stopAnimating];
//    
//}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[activityIndicatorView stopAnimating];
    UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"网络问题" message:@"请检查网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [self.view addSubview:alerView];
    [alerView show];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [aProgressView dismiss];
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
