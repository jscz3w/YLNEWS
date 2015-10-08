//
//  NewsViewController.m
//  亿利MIS
//
//  Created by WangZhengHong on 15/9/19.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "NewsViewController.h"
#import "WebViewController.h"
#import "AFNetworking.h"

@interface NewsViewController ()
{
  NSMutableArray *titleArray;//新闻标题
  NSMutableArray *dateArray;//新闻日期
  NSMutableArray *urlArray;//新闻URL
  UIScrollView* helpScrView;
  UIPageControl* pageCtrl;
  
  UIActivityIndicatorView *acView;
  UIImageView * msgView;
    
  int iPage ;

}
@end

@implementation NewsViewController


-(void)network_test{
    
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", status);
        if (status ==-1 || status == 0) {
            [acView stopAnimating];
            
        };
        
    }];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CGRect bounds = self.view.frame;  //获取界面区域
    
    
    
    UIImage *aBackGround=[UIImage imageNamed:@"background@2x"];
    
    //UIColor *aColor =[UIColor colorWithPatternImage:aBackGround];
    
    //self.view.backgroundColor=aColor;
    
    UIImageView * backgrountView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width,bounds.size.height)];
    
    backgrountView.image=aBackGround;
    
    [self.view addSubview:backgrountView];
    
    
    titleArray =[NSMutableArray array];
    dateArray  =[NSMutableArray array];
    urlArray   =[NSMutableArray array];
   
    
    //集团要闻
    [self loadNews:@"http://www.shenhuagroup.com.cn/cs/sh/RSSINFO?siteName=siteName:shenhua,siteColumnId:1382682123408"];
    
    
    
    
    UIImage * initImages= [UIImage imageNamed:@"jtTOP@2x"];
    
    
    UIImageView * imgView =[[UIImageView alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 130)];
    //imgView.contentMode=UIViewContentModeCenter;
    
    [imgView setImage:initImages];
    //    imgView.alpha = 0.5f;
    
    
    UIImage * initImages2= [UIImage imageNamed:@"jcTOP@2x"];
    
    
    UIImageView * imgView2 =[[UIImageView alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 130)];
    //    imgView2.contentMode=UIViewContentModeCenter;
    [imgView2 setImage:initImages2];
    
    
    
    
    
    //    imgView2.alpha = 0.5f;
    
    
    UIImage * initImages3= [UIImage imageNamed:@"ldTOP@2x"];
    
    
    UIImageView * imgView3 =[[UIImageView alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 130)];
    //    imgView2.contentMode=UIViewContentModeCenter;
    [imgView3 setImage:initImages3];
    
    
    //创建UIScrollView
    helpScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 130)];  //创建UIScrollView，位置大小与主界面一样。
    [helpScrView setContentSize:CGSizeMake(bounds.size.width * 3, 0)];  //设置全部内容的尺寸，这里帮助图片是2张，所以宽度设为界面宽度*2  ，高度和界面一致。
    helpScrView.pagingEnabled = YES;//设为YES时，会按页滑动
    helpScrView.bounces = NO;//取消UIScrollView的弹性属性，这个可以按个人喜好来定
    [helpScrView setDelegate:self]; //UIScrollView的delegate函数在本类中定义
    helpScrView.showsHorizontalScrollIndicator = NO;  //因为我们使用UIPageControl表示页面进度，所以取消UIScrollView自己的进度条。
    [self loadScrollViewWithPage:imgView];
    [self loadScrollViewWithPage:imgView2];
    [self loadScrollViewWithPage:imgView3];
    
    
    [self.view addSubview:helpScrView]; //将UIScrollView添加到主界面上。
    
    
    
    //创建UIPageControl
    pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bounds.origin.y+100, bounds.size.width, 30)];  //创建UIPageControl，位置在屏幕最下方。
    pageCtrl.numberOfPages = 3;//总的图片页数
    pageCtrl.currentPage = 0;//当前页
    [pageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
    
    
    [self.view addSubview:pageCtrl];  //将UIPageControl添加到主界面上。
    
    
    acView =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((bounds.size.width-bounds.origin.x)/2-50, bounds.origin.y+50,120, 120)];
    
    [acView setCenter:CGPointMake(35, 80)];//指定进度轮中心点
    
    [acView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
    
    
    
    [self.view addSubview:acView];
    [acView startAnimating];
    
    
    
}
- (void)loadScrollViewWithPage:(UIView *)page
{
    //NSLog(@"load");
    NSUInteger pageCount = [[helpScrView subviews] count];
    CGRect bounds = helpScrView.bounds;
    bounds.origin.x = bounds.size.width * pageCount;
    bounds.origin.y = 0;
    page.frame = bounds;
    [helpScrView addSubview:page];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    
    
    
    
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
//    NSLog(@"scrollViewDidEndDecelerating");
    
 //   NSLog(@"offset.x =%f bounds.size.width = %f",offset.x , bounds.size.width);
//    [pageCtrl setCurrentPage:offset.x / bounds.size.width];
    
    
    [pageCtrl setCurrentPage:offset.x / bounds.size.width];
    
    //NSLog(@"PAGE %ld",pageCtrl.currentPage);
    
    
    if(pageCtrl.currentPage==0)
    {
        [self loadNews:@"http://www.shenhuagroup.com.cn/cs/sh/RSSINFO?siteName=siteName:shenhua,siteColumnId:1382682123408"];
        //[self loadNews:@"http://www.shenhuagroup.com.cn/cs/sh/RSSINFO?siteName=siteName:shenhua,siteColumnId:1382685260394"];
        //self.navigationItem.title=@"集团要闻";

    }
    else if (pageCtrl.currentPage==1)
    {
        [self loadNews:@"http://www.shenhuagroup.com.cn/cs/sh/RSSINFO?siteName=siteName:shenhua,siteColumnId:1382682123414"];
        //self.navigationItem.title=@"基层新闻";

    }
    else
    {
        [self loadNews:@"http://www.shenhuagroup.com.cn/cs/sh/RSSINFO?siteName=siteName:shenhua,siteColumnId:1382682123402"];
        //self.navigationItem.title=@"领导新闻";

    }
    
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    NSLog(@"AAAA");
//}

- (void)pageTurn:(UIPageControl*)sender

{
    
    
    //NSLog(@"pageTurn");
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = helpScrView.frame.size;
    
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    
    
    [helpScrView scrollRectToVisible:rect animated:YES];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([titleArray count]>=9)
        return 9 ;
    else
        return [titleArray count];
}

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
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [titleArray objectAtIndex:row];
    cell.detailTextLabel.text=[dateArray objectAtIndex:row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Section = %ld, Row = %ld",indexPath.section+1,indexPath.row+1);
    
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //NSLog(@"%ld", status);
        if (status ==-1 || status == 0) {
            [acView stopAnimating];
            
            [self loadMsgImg:@"msg@2x"];
            
            
        }
        else{
            NSMutableString * baseURL=[[NSMutableString alloc]init];
            [baseURL appendString:@"http://www.shenhuagroup.com.cn"];
            [baseURL appendString:[[urlArray objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            // NSLog(@"%@",baseURL);
            
            WebViewController * newsWeb = [[WebViewController alloc]init];
            [newsWeb showViewUrlValue:baseURL];
            
            UINavigationController * LoginNC =  [[UINavigationController alloc]initWithRootViewController:newsWeb];
            
            [self presentViewController:LoginNC animated:YES completion:^{
                NSLog(@"Read News....");
            }];
        }
    
    }];
    
    
    
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    
}





-(void)loadNews:(NSString *)url
{
    
    
    
     [acView startAnimating];
    
    
    
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //NSLog(@"%ld", status);
        if (status ==-1 || status == 0) {
            [acView stopAnimating];
            
            [self loadMsgImg:@"msg@2x"];
            
            
        }
        else{
            NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData  timeoutInterval:40.0];
            
            NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            
            if (connection) {
                
                
                self.responseData=[NSMutableData data];
                
            }
            else
            {
                //NSLog(@"The connection failed");
                [self loadMsgImg:@"error@2x"];
            }

        }
        
    }];

    
    
    
    
    
    
    
    
    
    
}
-(void)loadMsgImg:(NSString * )imgName {
    CGRect bounds = self.view.bounds;
    UIImage * msgImg =[UIImage imageNamed:imgName];
    msgView =[[UIImageView alloc]initWithFrame:CGRectMake((bounds.size.width-bounds.origin.x)/2-110, 200, 220, 60)];
    
    msgView.image=msgImg;
    
    [self.view addSubview:msgView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = 1.0;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    
    
    [msgView.layer addAnimation:animation forKey:@"opacity"];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hidePic) userInfo:nil repeats:NO];

}

-(void)hidePic{
    
    [msgView removeFromSuperview];
    //return ;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    //NSLog(@"connection willSendRequest:redirectResponse:");
    
    
    return request;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    //NSLog(@"connection:didReceiveResponse:");
    //NSLog(@"Length :%qi",[response expectedContentLength]);
    //NSLog(@"textEncodingName: %@",[response textEncodingName]);
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"connection:didReceiveData:");
    
    [self.responseData appendData:data];
    
}




- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    //NSLog(@"connection:willCacheResponse:");
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [self parserXML];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"connection:didFailWithError:");
    //NSLog(@"%@",[error localizedDescription]);
    [self loadMsgImg:@"error@2x"];
    
}

-(void)parserXML
{
    //NSLog(@"parserXML");
    NSXMLParser *xmlParser =[[NSXMLParser alloc]initWithData:self.responseData];
    [xmlParser setDelegate:self];
    
    if (![xmlParser parse]) {
        //NSLog(@"Parser Error");
        [self loadMsgImg:@"error@2x"];
    }
    
}
// Document handling methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //NSLog(@"parserDidStartDocument:");
    self.inItemElement=NO;
    //txtView.text=nil;
    
    [titleArray removeAllObjects];
    [dateArray removeAllObjects];
    [urlArray removeAllObjects];
    
}
// sent when the parser begins parsing of the document.
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //NSLog(@"parserDidEndDocument:");
    
    // NSLog(@"titleArray Count = %d",[titleArray count]);
    
    
    if([titleArray count]>0)
    {
        
        CGRect bounds = self.view.frame;  //获取界面区域
        
        UITableView * newsTableView =[[UITableView alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y+130, bounds.size.width, bounds.size.height-40) style:UITableViewStylePlain];
        newsTableView.delegate=self;
        newsTableView.dataSource=self;
        newsTableView.scrollEnabled=NO;
        [self.view addSubview:newsTableView];
        
        [acView stopAnimating];
        
        
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"didStartElement");
    if ([elementName isEqualToString:@"item"]) {
        self.inItemElement=YES;
    }
    
    if (self.inItemElement && [elementName isEqualToString:@"title"]) {
        
        self.captureCharacters = [[NSMutableString alloc]initWithCapacity:100];
    }
    
    if (self.inItemElement && [elementName isEqualToString:@"link"]) {
        
        self.captureCharacters = [[NSMutableString alloc]initWithCapacity:100];
    }
    
    if (self.inItemElement && [elementName isEqualToString:@"pubDate"]) {
        
        self.captureCharacters = [[NSMutableString alloc]initWithCapacity:100];
    }
   
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"didEndElement");
    //NSLog(@"elementName=%@",elementName);
    if (self.inItemElement && [elementName isEqualToString:@"title"]) {
         //NSLog(@"capturedCharacters:%@",self.captureCharacters);
        //txtView.text= [txtView.text stringByAppendingFormat:@"%@ ",self.captureCharacters ];
        [titleArray addObject:self.captureCharacters];
        
        self.captureCharacters=nil;
    }
    if(self.inItemElement && [elementName isEqualToString:@"pubDate"]) {
        //txtView.text= [txtView.text stringByAppendingFormat:@"%@\n",self.captureCharacters ];
        [dateArray addObject:self.captureCharacters];
        //NSLog(@"link = %@\n",self.captureCharacters);
        self.captureCharacters=nil;
        
    }
    if(self.inItemElement && [elementName isEqualToString:@"link"]) {
        //txtView.text= [txtView.text stringByAppendingFormat:@"%@\n",self.captureCharacters ];
        [urlArray addObject:self.captureCharacters];
        //NSLog(@"link = %@\n",self.captureCharacters);
        self.captureCharacters=nil;
        
    }
    
    
    if ([elementName isEqualToString:@"item"]) {
        self.inItemElement=NO;
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"foundCharacters : %@",string);
    
    if (self.captureCharacters !=nil) {
        
        
        
        [self.captureCharacters appendString:string];
        
        
    }
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"点击了删除");
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"手指撮动了");
//    return UITableViewCellEditingStyleDelete;
//}
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return  @"删除";
//}
//
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//    
//}
//




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
