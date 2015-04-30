//
//  HomeViewController.m
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/17.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "HomeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "StepViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    UIStoryboard* storyboard;
    StepViewController* stepViewController;
    NSArray* hotDishs;
    NSArray* tuijianDishs;
}
@synthesize hot1;
@synthesize hot2;
@synthesize hot3;
@synthesize hot4;
@synthesize tuijian1;
@synthesize tuijian2;
@synthesize tuijian3;
@synthesize tuijian4;
@synthesize page;
@synthesize scroll;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    //设置scrollview的属性
    scroll.contentSize=CGSizeMake(scroll.bounds.size.width*2, scroll.bounds.size.height);//计算ScroollView需要的大小
    scroll.pagingEnabled=YES;//scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
    scroll.delegate = self;
    
    //设置pagecontroller的属性
    page.numberOfPages=2; //设置页数为4
    page.currentPage=0; //初始页码为 0
    page.userInteractionEnabled=NO; //pagecontroller不响应点击操作
    
    
    //初始化小窗口
    AVQuery* hotquery = [AVQuery queryWithClassName:@"Dish"];
    hotquery.cachePolicy = kPFCachePolicyNetworkElseCache;
    [hotquery orderByDescending:@"hot"];
    hotquery.limit = 4;
    hotDishs = [hotquery findObjects];
    if(hotDishs==nil){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常，请检查网络配置" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        UIView* hotArray[4] = {hot1,hot2,hot3,hot4};
        for (int i=0; i<=3; i++) {
            UILabel* label = (UILabel*)[hotArray[i] viewWithTag:1];
            label.text = @"";
        }
    }
    else{
        UIView* hotArray[4] = {hot1,hot2,hot3,hot4};
        for (int i=0; i<=3; i++) {
            UILabel* label = (UILabel*)[hotArray[i] viewWithTag:1];
            NSDictionary* data = [hotDishs objectAtIndex:i];
            NSString* title = [NSString stringWithFormat:@"%@",[data objectForKey:@"title"]];
            label.text = [NSString stringWithFormat:@"%@",title];
            
            AVRelation* thumb = [data objectForKey:@"thumb"];
            AVQuery* imageQuery = [thumb query];
            imageQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
            NSData* imageData =[[[[imageQuery findObjects] objectAtIndex:0] objectForKey:@"file"] getData];
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView* imageView = (UIImageView*)[hotArray[i] viewWithTag:2];
            imageView.image = image;
        }
    }
    
    
    AVQuery* tuijianquery = [AVQuery queryWithClassName:@"Dish"];
    tuijianquery.cachePolicy = kPFCachePolicyNetworkElseCache;
    [tuijianquery orderByDescending:@"recommendation"];
    tuijianquery.limit = 4;
    tuijianDishs = [tuijianquery findObjects];
    
    if(tuijianDishs==nil){
        UIView* tuijianArray[4] = {tuijian1,tuijian2,tuijian3,tuijian4};
        for (int i=0; i<=3; i++) {
            UILabel* label = (UILabel*)[tuijianArray[i] viewWithTag:1];
            label.text = @"";
        }
    }
    else{
        UIView* tuijianArray[4] = {tuijian1,tuijian2,tuijian3,tuijian4};
        for (int i=0; i<=3; i++) {
            UILabel* label = (UILabel*)[tuijianArray[i] viewWithTag:1];
            NSDictionary* data = [tuijianDishs objectAtIndex:i];
            NSString* title = [NSString stringWithFormat:@"%@",[data objectForKey:@"title"]];
            label.text = [NSString stringWithFormat:@"%@",title];
            
            AVRelation* thumb = [data objectForKey:@"thumb"];
            AVQuery* imageQuery = [thumb query];
            imageQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
            NSData* imageData =[[[[imageQuery findObjects] objectAtIndex:0] objectForKey:@"file"] getData];
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView* imageView = (UIImageView*)[tuijianArray[i] viewWithTag:2];
            imageView.image = image;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) /scrollView.frame.size.width;
    page.currentPage = index;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tuijianBtn1:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [tuijianDishs objectAtIndex:0];
    [self.view addSubview:stepViewController.view];
}

- (IBAction)tuijianBtn2:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [tuijianDishs objectAtIndex:1];
    [self.view addSubview:stepViewController.view];
}

- (IBAction)tuijianBtn3:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [tuijianDishs objectAtIndex:2];
    [self.view addSubview:stepViewController.view];
}

- (IBAction)tuijianBtn4:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [tuijianDishs objectAtIndex:3];
    [self.view addSubview:stepViewController.view];
}

- (IBAction)hotBtn1:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [hotDishs objectAtIndex:0];
    [self.view addSubview:stepViewController.view];
}

- (IBAction)hotBtn2:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [hotDishs objectAtIndex:1];
    [self.view addSubview:stepViewController.view];
}

- (IBAction)hotBtn3:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [hotDishs objectAtIndex:2];
    [self.view addSubview:stepViewController.view];
}

- (IBAction)hotBtn4:(id)sender {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [hotDishs objectAtIndex:3];
    [self.view addSubview:stepViewController.view];
}
@end
