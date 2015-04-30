//
//  LikeViewController.m
//  BTVKichen
//
//  Created by 夏子皓 on 14/12/11.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "LikeViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "StepViewController.h"

@interface LikeViewController ()

@end

@implementation LikeViewController{
    NSUserDefaults* userDefaults;
    NSArray* dishs;
    StepViewController* stepViewController;
    UIStoryboard* storyboard;
    BOOL downloadMode;
}
@synthesize dishCollection;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0.0f, 0.0f, 996.0f, 685.0f);
    // Do any additional setup after loading the view.
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *collectionArray =[userDefaults arrayForKey:@"collection"];
    if (collectionArray!=nil) {
        AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
        query.cachePolicy =
        kPFCachePolicyCacheElseNetwork;
        [query whereKey:@"objectId" containedIn:collectionArray];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                dishs = objects;
                [dishCollection reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dishs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:1];
    NSDictionary* data = [dishs objectAtIndex:indexPath.row];
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
    stepViewController.datasource = [dishs objectAtIndex:indexPath.row];
    stepViewController.likeView = self;
    [self.view addSubview:stepViewController.view];
}

- (void)onStepViewExit{
    if (downloadMode) {
        NSArray *downloadDics = [userDefaults arrayForKey:@"DownloadDics"];
        if (downloadDics!=nil)
        {
            NSMutableArray *downloadList = [NSMutableArray array];
            for (int i=0; i<downloadDics.count; i++)
            {
                [downloadList addObject:[[downloadDics objectAtIndex:i] objectForKey:@"downloadName"]];
            }
            AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
            [query whereKey:@"objectId" containedIn:downloadList];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    dishs = objects;
                    [dishCollection reloadData];
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else
        {
            dishs=nil;
            [dishCollection reloadData];
        }

    }
    else{
        userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *collectionArray =[userDefaults arrayForKey:@"collection"];
        AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        [query whereKey:@"objectId" containedIn:collectionArray];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                dishs = objects;
                [dishCollection reloadData];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];

    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)downloadOrSelection:(id)sender {
    UISegmentedControl* seg = sender;
    if (seg.selectedSegmentIndex==0) {
        downloadMode = NO;
        userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *collectionArray =[userDefaults arrayForKey:@"collection"];
        if (collectionArray!=nil)
        {
            AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
            [query whereKey:@"objectId" containedIn:collectionArray];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    dishs = objects;
                    [dishCollection reloadData];
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else
        {
            dishs = nil;
            [dishCollection reloadData];
        }
    }
    
    else if(seg.selectedSegmentIndex==1)
    {
        downloadMode = YES;
        NSArray *downloadDics = [userDefaults arrayForKey:@"DownloadDics"];
        if (downloadDics!=nil)
        {
            NSMutableArray *downloadList = [NSMutableArray array];
            for (int i=0; i<downloadDics.count; i++)
            {
                [downloadList addObject:[[downloadDics objectAtIndex:i] objectForKey:@"downloadName"]];
            }
            AVQuery* query = [AVQuery queryWithClassName:@"Dish"];
            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
            [query whereKey:@"objectId" containedIn:downloadList];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    dishs = objects;
                    [dishCollection reloadData];
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else
        {
            dishs=nil;
            [dishCollection reloadData];
        }
    }
    
}
@end
