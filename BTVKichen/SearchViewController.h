//
//  SearchViewController.h
//  BTVKichen
//
//  Created by 夏子皓 on 14/12/9.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *dishCollection;
@property (weak, nonatomic) IBOutlet UISearchBar *search;
- (IBAction)tap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *unFindText;

@end
