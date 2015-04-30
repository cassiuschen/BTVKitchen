//
//  ViewController.h
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/16.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *contentView;
- (IBAction)recommendBtn:(id)sender;
- (IBAction)specialBtn:(id)sender;
- (IBAction)classifyBtn:(id)sender;
- (IBAction)collectionBtn:(id)sender;
- (IBAction)configBtn:(id)sender;
- (IBAction)searchBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UICollectionView *dishView;
@property (retain) NSArray* dishes;

@property NSMutableArray* tagNameArray;

- (BOOL)creatTagViewWithTitle:(NSString*)title;
- (void)deleteTagViewWithTitle:(NSString*)title;
- (void)dataUpDate;
@property (weak, nonatomic) IBOutlet UIButton *tuijian;
@property (weak, nonatomic) IBOutlet UIButton *zhuanti;
@property (weak, nonatomic) IBOutlet UIButton *fenlei;
@property (weak, nonatomic) IBOutlet UIButton *shoucang;
@property (weak, nonatomic) IBOutlet UIButton *shezhi;
@property (weak, nonatomic) IBOutlet UIButton *sousuo;

@end

