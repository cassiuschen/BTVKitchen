//
//  HomeViewController.h
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/17.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *tuijian1;
@property (weak, nonatomic) IBOutlet UIView *tuijian2;
@property (weak, nonatomic) IBOutlet UIView *tuijian3;
@property (weak, nonatomic) IBOutlet UIView *tuijian4;
@property (weak, nonatomic) IBOutlet UIView *hot1;
@property (weak, nonatomic) IBOutlet UIView *hot2;
@property (weak, nonatomic) IBOutlet UIView *hot3;
@property (weak, nonatomic) IBOutlet UIView *hot4;
- (IBAction)tuijianBtn1:(id)sender;
- (IBAction)tuijianBtn2:(id)sender;
- (IBAction)tuijianBtn3:(id)sender;
- (IBAction)tuijianBtn4:(id)sender;
- (IBAction)hotBtn1:(id)sender;
- (IBAction)hotBtn2:(id)sender;
- (IBAction)hotBtn3:(id)sender;
- (IBAction)hotBtn4:(id)sender;


@end
