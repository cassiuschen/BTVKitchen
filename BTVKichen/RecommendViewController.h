//
//  RecommendViewController.h
//  BTVKichen
//
//  Created by 夏子皓 on 15/1/5.
//  Copyright (c) 2015年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *dishView;
- (IBAction)onSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *story;
@property (weak, nonatomic) IBOutlet UITextView *storyText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end
