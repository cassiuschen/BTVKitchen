//
//  TagViewController.h
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/18.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface TagViewController : UIViewController
- (IBAction)disable:(id)sender;
@property NSString* name;
@property ViewController* delegate;
@end
