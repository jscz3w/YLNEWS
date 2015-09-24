//
//  ViewController.m
//  NetWorkStudy
//
//  Created by WangZhengHong on 15/7/31.
//  Copyright (c) 2015年 WangZhengHong. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()
{
    UITextView *txtView;
    NSMutableArray *titleArray;
    NSMutableArray *dateArray;
    NSMutableArray *urlArray;
    //NSMutableArray *descArray;

    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *aBackGround=[UIImage imageNamed:@"background@2x"];
    
    UIColor *aColor =[UIColor colorWithPatternImage:aBackGround];
    
    self.view.backgroundColor=aColor;

    
    titleArray =[NSMutableArray array];
    dateArray  =[NSMutableArray array];
    urlArray   =[NSMutableArray array];
    //descArray  =[NSMutableArray array];
    [self click];
    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    
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
    NSMutableString * baseURL=[[NSMutableString alloc]init];
    //[baseURL appendString:@"http://www.shenhuagroup.com.cn"];
    [baseURL appendString:[[urlArray objectAtIndex:indexPath.row] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    NSLog(@"%@",baseURL);
    
    WebViewController * newsWeb = [[WebViewController alloc]init];
    [newsWeb showViewUrlValue:baseURL];
    
    UINavigationController * LoginNC =  [[UINavigationController alloc]initWithRootViewController:newsWeb];
    
    [self presentViewController:LoginNC animated:YES completion:^{
        NSLog(@"Read News....");
    }];
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 40;
    
}





-(void)click
{
    NSLog(@"Send Click");
    
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.163.com/special/00011K6L/rss_photo.xml"] cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:40.0];
    
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
        
    if (connection) {
        NSLog(@"The connection 成功");

        self.responseData=[NSMutableData data];
        
    }
    else
    {
        NSLog(@"The connection failed");
    }
    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    NSLog(@"connection willSendRequest:redirectResponse:");
    
    
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
    NSLog(@"connection:didReceiveData:");
    
    [self.responseData appendData:data];
    
}




- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    NSLog(@"connection:willCacheResponse:");
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading:");
   // NSString *responseString =[[NSString alloc]initWithData:self.responseData encoding:NSUTF8StringEncoding];
   // NSLog(@"Response String :\n%@",responseString);
    [self parserXML];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection:didFailWithError:");
    NSLog(@"%@",[error localizedDescription]);
    
}

-(void)parserXML
{
    NSLog(@"parserXML");
    NSXMLParser *xmlParser =[[NSXMLParser alloc]initWithData:self.responseData];
    [xmlParser setDelegate:self];
    
    if (![xmlParser parse]) {
        NSLog(@"Parser Error");
    }
    
}
// Document handling methods
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"parserDidStartDocument:");
    self.inItemElement=NO;
    //txtView.text=nil;
    
}
// sent when the parser begins parsing of the document.
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"parserDidEndDocument:");
    
   // NSLog(@"titleArray Count = %d",[titleArray count]);
    
    
    if([titleArray count]>0)
    {
        
        CGRect bounds = self.view.frame;  //获取界面区域
        
        UITableView * newsTableView =[[UITableView alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y+22, bounds.size.width, bounds.size.height) style:UITableViewStylePlain];
        newsTableView.delegate=self;
        newsTableView.dataSource=self;
        
        [self.view addSubview:newsTableView];
        
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"didStartElement");
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
    //description
    
    if (self.inItemElement && [elementName isEqualToString:@"description"]) {
        
        self.captureCharacters = [[NSMutableString alloc]initWithCapacity:1000];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"didEndElement");
    NSLog(@"elementName=%@",elementName);
    if (self.inItemElement && [elementName isEqualToString:@"title"]) {
       // NSLog(@"capturedCharacters:%@",self.captureCharacters);
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
    
//    if(self.inItemElement && [elementName isEqualToString:@"description"]) {
//        //txtView.text= [txtView.text stringByAppendingFormat:@"%@\n",self.captureCharacters ];
//        [descArray addObject:self.captureCharacters];
//        //NSLog(@"link = %@\n",self.captureCharacters);
//        self.captureCharacters=nil;
//        
//    }

    
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



@end
