//
//  ViewController.m
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/16.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "ConfigViewController.h"
#import "TagViewController.h"
#import "FoodMatrial/FoodMaterialViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "StepViewController.h"
#import "SearchViewController.h"
#import "LikeViewController.h"
#import "RecommendViewController.h"
#import "BTVKichen-Swift.h"


@interface ViewController (){
    HomeViewController* homeView;
    ConfigViewController* configView;
    UIStoryboard* storyboard;
    TagViewController* tagViewControllers[4];
    UIView* tagViews[4];
    NSString* titles[4];
    int numberOfTags;
    NSString* tagNames[4];
    int dishNumber;
    StepViewController* stepViewController;
    SearchViewController* searchViewController;
    LikeViewController* likeViewController;
    TopicViewController* recommend;
    UIImageView* navSelectedImageView;
}

@end


@implementation ViewController
@synthesize contentView;
@synthesize selectView;
@synthesize tagNameArray;
@synthesize dishes;
@synthesize dishView;
@synthesize tuijian;
@synthesize zhuanti;
@synthesize fenlei;
@synthesize shoucang;
@synthesize shezhi;
@synthesize sousuo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [contentView addSubview:homeView.view];
    CALayer *layer = [contentView layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 5.0f;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowOpacity = 0.5;
    layer.shadowRadius = 10.0;
    
    UIImage* navSelectedImage = [UIImage imageNamed:@"daohang_recommendBIG.png"];
    navSelectedImageView = [[UIImageView alloc] initWithImage:navSelectedImage];
    navSelectedImageView.center = tuijian.center;
    [self.view addSubview:navSelectedImageView];
    
    
    
    
    tagNameArray = [NSMutableArray arrayWithCapacity:4];
    
    AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
    query.limit = 8;
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            dishes = objects;
            [dishView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------分类页面点击出现的小表格都在detail tables组中用segue连接--------------------------------
//----------------------------------------------－－分类页面－－-----------------------------------------------------
//----------------------------------------------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    Detail* nextViewController = [segue destinationViewController];
    nextViewController.delegate = self;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dishes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:1];
    NSDictionary* data = [dishes objectAtIndex:indexPath.row];
    NSString* title = [NSString stringWithFormat:@"%@",[data objectForKey:@"title"]];
    label.text = [NSString stringWithFormat:@"%@",title];
    
    AVRelation* thumb = [data objectForKey:@"thumb"];
    AVQuery* imageQuery = [thumb query];
    imageQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
    NSData* imageData =[[[[imageQuery findObjects] objectAtIndex:0] objectForKey:@"file"] getData];
    UIImage *image = [UIImage imageWithData:imageData];
    UIImageView* imageView = (UIImageView*)[cell.contentView viewWithTag:2];
    imageView.image = image;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    stepViewController.datasource = [dishes objectAtIndex:indexPath.row];
    [contentView addSubview:stepViewController.view];
}

- (BOOL)creatTagViewWithTitle:(NSString*)title
{
    if (numberOfTags<=3)
    {
        tagViewControllers[numberOfTags]=[storyboard instantiateViewControllerWithIdentifier:@"tagView"];
        tagViewControllers[numberOfTags].delegate = self;
        tagViews[numberOfTags]= tagViewControllers[numberOfTags].view;
        tagViews[numberOfTags].frame = CGRectMake(862-120*numberOfTags, 30.0f, 110.0f, 35.0f);
        UILabel* label = (UILabel*)[tagViews[numberOfTags] viewWithTag:1];
        label.text = title;
        tagNames[numberOfTags] = title;
        tagViewControllers[numberOfTags].name = title;
        [selectView addSubview:tagViews[numberOfTags]];
        numberOfTags++;
        
        
        NSString* tempStrings[4];
        for(int i=0;i<=3;i++)
        {
            tempStrings[i] = [NSString stringWithFormat:@"%@",tagNames[i]];
        }
        tagNameArray = [[NSMutableArray alloc] initWithObjects:tempStrings[0],tempStrings[1],tempStrings[2],tempStrings[3], nil];
        NSLog(@"%@",tagNameArray);
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分类标签最多只能选择四个" message:@""
                                                                 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        // Display the Hello World Message
        [alert show];
        return NO;
    }
    [self dataUpDate];
    return YES;
}

- (void)deleteTagViewWithTitle:(NSString*)title
{
    
    
    
    for(int i=0;i<=numberOfTags-1;i++)
    {
        
        if([tagNames[i] isEqualToString:title])
        {
            tagNames[i] = nil;
            [tagViews[i] removeFromSuperview];
            tagViewControllers[i] = nil;
        }
    }
    
    for(int n=0;n<=numberOfTags-1;n++)
    {
     
        if(tagNames[n]==nil&&n!=3)
        {
            tagNames[n] = tagNames[n+1];
            tagNames[n+1] = nil;
            tagViews[n] = tagViews[n+1];
            tagViews[n+1] = nil;
            tagViews[n].frame = CGRectMake(862-120*n, 30.0f, 110.0f, 35.0f);
            tagViewControllers[n]=tagViewControllers[n+1];
            tagViewControllers[n+1] = nil;
        }
    }
    
    numberOfTags--;
    
    NSString* tempStrings[4];
    for(int i=0;i<=3;i++)
    {
        tempStrings[i] = [NSString stringWithFormat:@"%@",tagNames[i]];
    }
    tagNameArray = [[NSMutableArray alloc] initWithObjects:tempStrings[0],tempStrings[1],tempStrings[2],tempStrings[3], nil];
    NSLog(@"%@",tagNameArray);
    [self dataUpDate];
}

- (void)dataUpDate
{
    NSMutableArray* tempArray = [NSMutableArray array];
    for (int i=0; i<=3; i++) {
        if (tagNames[i]!=nil) {
            [tempArray addObject:tagNames[i]];
        }
        else break;
    }
    //NSLog(@"tempTag:%@",tempArray);
    
    
    if(tempArray.count==0){
        AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
        query.limit = 8;
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                dishes = objects;
                [dishView reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    else{
        AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        [query whereKey:@"tags" containsAllObjectsInArray:tempArray];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                dishes = objects;
                [dishView reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

- (void)redirectToStepView:(NSString*)objectId {
    stepViewController = [storyboard instantiateViewControllerWithIdentifier:@"step"];
    AVQuery *query = [AVQuery queryWithClassName:@"Dish"];
    stepViewController.datasource = [query getObjectWithId: objectId];
    [contentView addSubview:stepViewController.view];

}

//--------------------------------⬆️⬆️⬆️⬆️------------------------------------------
//------------------------------－－分类页面－－-----------------------------------------
//-----------------------------------------------------------------------------------

- (void)changeContentView:(UIViewController*)newViewController {
    for(int i=1;i<=contentView.subviews.count-1;i++)
    {
        [contentView.subviews[i] removeFromSuperview];
    }
    if (homeView.view.subviews.count>12) {
        [homeView.view.subviews[12] removeFromSuperview];
    }
    [contentView addSubview:newViewController.view];
}


//-----------------------------------------------------------------------------------
//------------------------------－上方圆形按钮－-----------------------------------------
//-----------------------------------------------------------------------------------

- (IBAction)recommendBtn:(id)sender {
    for(int i=1;i<=contentView.subviews.count-1;i++)
    {
        [contentView.subviews[i] removeFromSuperview];
    }
    if (homeView.view.subviews.count>12) {
        [homeView.view.subviews[12] removeFromSuperview];
    }
    [contentView addSubview:homeView.view];
    navSelectedImageView.image = [UIImage imageNamed:@"daohang_recommendBIG.png"];
    navSelectedImageView.center = tuijian.center;
}

- (IBAction)specialBtn:(id)sender {
    for(int i=1;i<=contentView.subviews.count-1;i++)
    {
        [contentView.subviews[i] removeFromSuperview];
    }
    recommend = [storyboard instantiateViewControllerWithIdentifier:@"topic"];
    [contentView addSubview:recommend.view];
    navSelectedImageView.image = [UIImage imageNamed:@"daohang_specialBIG.png"];
    navSelectedImageView.center = zhuanti.center;
}

- (IBAction)classifyBtn:(id)sender {
    for(int i=1;i<=contentView.subviews.count-1;i++)
    {
        [contentView.subviews[i] removeFromSuperview];
    }
    navSelectedImageView.image = [UIImage imageNamed:@"daohang_classifyBTG.png"];
    navSelectedImageView.center = fenlei.center;
}

- (IBAction)collectionBtn:(id)sender {
    for(int i=1;i<=contentView.subviews.count-1;i++)
    {
        [contentView.subviews[i] removeFromSuperview];
    }
    likeViewController = [storyboard instantiateViewControllerWithIdentifier:@"like"];
    [contentView addSubview:likeViewController.view];
    navSelectedImageView.image = [UIImage imageNamed:@"daohang_collectionBIG.png"];
    navSelectedImageView.center = shoucang.center;
}

- (IBAction)configBtn:(id)sender {
    for(int i=1;i<=contentView.subviews.count-1;i++)
    {
        [contentView.subviews[i] removeFromSuperview];
    }
    configView = [storyboard instantiateViewControllerWithIdentifier:@"config"];
    [contentView addSubview:configView.view];
    navSelectedImageView.image = [UIImage imageNamed:@"daohang_setBIG.png"];
    navSelectedImageView.center = shezhi.center;
}

- (IBAction)searchBtn:(id)sender {
    for(int i=1;i<=contentView.subviews.count-1;i++)
    {
        [contentView.subviews[i] removeFromSuperview];
    }
    searchViewController = [storyboard instantiateViewControllerWithIdentifier:@"search"];
    [contentView addSubview:searchViewController.view];
    navSelectedImageView.image = [UIImage imageNamed:@"daohang_searchBIG.png"];
    navSelectedImageView.center = sousuo.center;
}
@end
