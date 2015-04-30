//
//  StepViewController.m
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/24.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "StepViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PengRenViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface StepViewController ()
{
    NSArray* tableData;
    PengRenViewController* pengrenViewController;
    NSUserDefaults* userDefaults;
    NSMutableArray* collection;
    NSMutableArray* downloadButton;
    NSMutableArray* progressLabel;
    NSMutableArray* downloadArray;
    NSMutableArray* downloadDics;
    BOOL isDownloadListHasSelf;
    
    int removeIndex;
}

@end

@implementation StepViewController
@synthesize titleView;
@synthesize likeButton;
@synthesize datasource;
@synthesize comments;
@synthesize mainMaterial;
@synthesize subMaterial;
@synthesize foodName;
@synthesize image;
@synthesize likeView;
@synthesize stepTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    downloadButton = [NSMutableArray array];
    progressLabel = [NSMutableArray array];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    //收藏数组获取
    NSArray *collectionArray =[userDefaults arrayForKey:@"collection"];
    if (collectionArray==nil) {
        collection = [NSMutableArray array];
    }
    else {
        collection = [NSMutableArray arrayWithArray:collectionArray];
        if(collection.count!=0)
        for (int i=0; i<=collection.count-1;i++)
        {
            NSString* ID = [collection objectAtIndex:i];
            if([ID isEqualToString:[datasource objectForKey:@"objectId"]])
            {
                likeButton.selected = true;
                removeIndex = i;
            }
        }
    }
    //NSLog(@"%@;%@",collection,collectionArray);
    
    //下载数组获取
    NSArray* tempDownloadArray = [userDefaults arrayForKey:@"DownloadDics"];
    if (tempDownloadArray==nil) {
        downloadArray = [NSMutableArray array];
        downloadDics = [NSMutableArray array];
    }
    else {
        downloadDics = [NSMutableArray arrayWithArray:tempDownloadArray];
        for (int i=0; i<downloadDics.count; i++) {
            NSDictionary* downItem = [downloadDics objectAtIndex:i];
            if ([[downItem objectForKey:@"downloadName"] isEqualToString:[datasource objectForKey:@"objectId"]])
            {
                downloadArray = [NSMutableArray arrayWithArray:[[downloadDics objectAtIndex:i] objectForKey:@"downloadArray"]];
                isDownloadListHasSelf = YES;
            }
        }
        if (downloadArray==nil) {
            downloadArray = [NSMutableArray array];
        }
    }
    //NSLog(@"%@",downloadDics);
    
    
    CALayer *layer = [titleView layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowOpacity = 0.5;
    layer.shadowRadius = 2.0;
    
    UIImage* selectedImage = [UIImage imageNamed:@"like_YES.png"];
    UIImage* normalImage = [UIImage imageNamed:@"like_NO.png"];
    [likeButton setImage:normalImage forState:UIControlStateNormal];
    [likeButton setImage:selectedImage forState:UIControlStateSelected];
    
    foodName.text = [datasource objectForKey:@"title"];
    comments.text = [datasource objectForKey:@"des"];
    AVQuery* imageQuery = (AVQuery*)[[datasource objectForKey:@"thumb"] query];
    imageQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
    NSData* imageData = [[[[imageQuery findObjects] objectAtIndex:0] objectForKey:@"file"] getData];
    image.image = [UIImage imageWithData:imageData];
    
    mainMaterial.text = [datasource objectForKey:@"mainMaterial"];
    subMaterial.text = [datasource objectForKey:@"subMaterial"];
    
    AVQuery* stepQuery = (AVQuery*)[[datasource objectForKey:@"step"] query];
    stepQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [stepQuery orderByAscending:@"order"];
    [stepQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            tableData = objects;
            [stepTable reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    self.view.frame = CGRectMake(0.0f, 768.0f, 996.0f, 658.0f);
    UIViewAnimationOptions options = UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction;
    [UIView animateWithDuration:0.2 delay:0 options:options animations:^
     {
         self.view.frame = CGRectMake(0.0f, 0.0f, 996.0f, 658.0f);
     } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    NSString* stepText = [[tableData objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    if(stepText.length>55) cell = [tableView dequeueReusableCellWithIdentifier:@"roll2" forIndexPath:indexPath];
    else cell= [tableView dequeueReusableCellWithIdentifier:@"roll1" forIndexPath:indexPath];
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:1];
    label.text = stepText;
    UIButton *button = (UIButton*)[cell.contentView viewWithTag:3];
    button.tag = indexPath.row;
    [downloadButton addObject:button];
    UILabel* progress = (UILabel*)[cell.contentView viewWithTag:99];
    [progressLabel addObject:progress];
    for (int i=0; i<downloadArray.count; i++) {
        if ([[downloadArray objectAtIndex:i] isEqualToString:[[tableData objectAtIndex:indexPath.row] objectForKey:@"objectId"]]) {
            button.hidden = YES;
            progress.hidden = NO;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* stepText=[[tableData objectAtIndex:indexPath.row] objectForKey:@"content"];
    if(stepText.length>55) return 66.0f;
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    pengrenViewController = [[PengRenViewController alloc] initWithNibName:@"PengRenViewController" bundle:nil];
    pengrenViewController.datasource = tableData;
    pengrenViewController.index = (int)indexPath.row;
    pengrenViewController.downloadName = [datasource objectForKey:@"objectId"];
    [self.view addSubview:pengrenViewController.view];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    if (likeView!=nil) {
        [likeView onStepViewExit];
    }
    [self.view removeFromSuperview];
}

- (IBAction)like:(id)sender {
    UIButton *button = (UIButton *)sender;
    if(button.selected){
        [collection removeObjectAtIndex:removeIndex];
        NSArray* array = [NSArray arrayWithArray:collection];
        [userDefaults setObject:array forKey:@"collection"];
    }
    else{
        [collection addObject: [datasource objectForKey:@"objectId"]];
        NSArray* array = [NSArray arrayWithArray:collection];
        [userDefaults setObject:array forKey:@"collection"];
    }
    button.selected = !button.selected;
    NSLog(@"%@",collection);
    
}
- (IBAction)pengRenBtn:(id)sender {
    pengrenViewController = [[PengRenViewController alloc] initWithNibName:@"PengRenViewController" bundle:nil];
    pengrenViewController.datasource = tableData;
    pengrenViewController.index = 0;
    pengrenViewController.downloadName = [datasource objectForKey:@"objectId"];
    [self.view addSubview:pengrenViewController.view];
}


- (IBAction)download1:(id)sender {
    UIButton *button = sender;
    [self videoDownload:(int)button.tag];
    button.hidden = YES;
    UILabel *label = [progressLabel objectAtIndex:button.tag];
    label.text = @"等待中";
    label.hidden = NO;
}

- (IBAction)download2:(id)sender {
    UIButton *button = sender;
    [self videoDownload:(int)button.tag];
    button.hidden = YES;
    UILabel *label = [progressLabel objectAtIndex:button.tag];
    label.text = @"等待中";
    label.hidden = NO;
}

- (void)videoDownload:(int)row {
    AVObject* downloadObject = [tableData objectAtIndex:row];
    AVRelation* videoRelation = [downloadObject objectForKey:@"video"];
    AVQuery* videoQuery = [videoRelation query];
    AVFile* videoFile = [[[videoQuery findObjects] objectAtIndex:0] objectForKey:@"file"];
    [videoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        NSLog(@"done");
        UILabel *label = [progressLabel objectAtIndex:row];
        label.text = @"已完成";
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@",[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[downloadObject objectForKey:@"objectId"]]]);
        [data writeToFile:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[downloadObject objectForKey:@"objectId"]]] atomically:YES];
        
        //下载本地数据记录
        [downloadArray addObject:[downloadObject objectForKey:@"objectId"]];
        int removeListIndex=-1;
        //重名文件清除
        for (int i=0; i<downloadDics.count; i++) {
            if ([[[downloadDics objectAtIndex:i] objectForKey:@"downloadName"] isEqualToString:[datasource objectForKey:@"objectId"]]) {
                removeListIndex = i;
            }
        }
        if (removeListIndex!=-1) {
            [downloadDics removeObjectAtIndex:removeListIndex];
        }
        //重新写入新文件
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:
        [datasource objectForKey:@"objectId"], @"downloadName",
        downloadArray, @"downloadArray",
        nil];
        [downloadDics addObject:dic];
        NSArray *array = [NSArray arrayWithArray:downloadDics];
        [userDefaults setObject:array forKey:@"DownloadDics"];
        
    }progressBlock:^(NSInteger percentDone){
        //进度指示器
        UILabel *label = [progressLabel objectAtIndex:row];
        
        NSString *progress = [NSString stringWithFormat:@"%ld%%",(long)percentDone];
        label.text = progress;
    }];
}

@end
