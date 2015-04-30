//
//  PengRenViewController.h
//  BTVKichen
//
//  Created by 夏子皓 on 14/11/30.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PengRenViewController : UIViewController
- (IBAction)nextStep:(id)sender;
- (IBAction)preStep:(id)sender;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titles;
@property (weak, nonatomic) IBOutlet UIView *videoView;

@property NSArray* datasource;
@property NSString* downloadName;
@property int index;
- (IBAction)swipToLeft:(id)sender;
- (IBAction)swipToRIght:(id)sender;

@end
