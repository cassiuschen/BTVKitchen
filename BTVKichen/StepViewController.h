//
//  StepViewController.h
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/24.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeViewController.h"

@interface StepViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UILabel *mainMaterial;
@property (weak, nonatomic) IBOutlet UILabel *subMaterial;
@property (weak, nonatomic) IBOutlet UITableView *stepTable;
@property (weak, nonatomic) IBOutlet UIView *titleView;
- (IBAction)back:(id)sender;
- (IBAction)like:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property NSDictionary* datasource;
@property LikeViewController* likeView;
- (IBAction)pengRenBtn:(id)sender;
- (IBAction)download1:(id)sender;
- (IBAction)download2:(id)sender;

@end
