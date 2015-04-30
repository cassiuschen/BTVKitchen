//
//  LikeViewController.h
//  BTVKichen
//
//  Created by 夏子皓 on 14/12/11.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *dishCollection;
- (void)onStepViewExit;
- (IBAction)downloadOrSelection:(id)sender;
@end
