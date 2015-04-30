//
//  SearchViewController.m
//  BTVKichen
//
//  Created by 夏子皓 on 14/12/9.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "SearchViewController.h"
#import "StepViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface SearchViewController ()

@end

@implementation SearchViewController{
    NSArray* dishs;
    UIStoryboard* storyboard;
    StepViewController* stepViewController;
}

@synthesize dishCollection;
@synthesize search;
@synthesize unFindText;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0.0f, 0.0f, 996.0f, 685.0f);
    // Do any additional setup after loading the view.
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    AVQuery *query = [AVQuery queryWithClassName:@"Dish"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"title" containsString:searchBar.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            dishs = objects;
            if(dishs.count==0) unFindText.hidden = NO;
            else unFindText.hidden = YES;
            [dishCollection reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [search resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tap:(id)sender {
    NSLog(@"touch");
    [search resignFirstResponder];
}
@end
