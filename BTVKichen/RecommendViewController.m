//
//  RecommendViewController.m
//  BTVKichen
//
//  Created by 夏子皓 on 15/1/5.
//  Copyright (c) 2015年 com.seaver. All rights reserved.
//

#import "RecommendViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "StepViewController.h"

@interface RecommendViewController ()

@end

@implementation RecommendViewController{
    NSArray* dishs;
    AVObject* recommendationObject;
    UIStoryboard* storyboard;
    StepViewController* stepViewController;
}
@synthesize dishView;
@synthesize story;
@synthesize storyText;
@synthesize loading;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    AVQuery* query = [AVQuery queryWithClassName:@"Recommendation"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            loading.hidden = YES;
            recommendationObject = [objects objectAtIndex:0];
            storyText.text = [recommendationObject objectForKey:@"des"];
            
            AVQuery* dishQuery = (AVQuery*)[[recommendationObject objectForKey:@"menu"] query];
            dishQuery.cachePolicy = kPFCachePolicyCacheElseNetwork;
            [dishQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    dishs = objects;
                    [dishView reloadData];
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];

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
    [self.view addSubview:stepViewController.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onSegment:(id)sender {
    UISegmentedControl* seg = sender;
    if(seg.selectedSegmentIndex==0)
    {
        story.hidden = NO;
        dishView.hidden = YES;
    }
    else if(seg.selectedSegmentIndex==1)
    {
        story.hidden = YES;
        dishView.hidden = NO;
    }
}
@end
