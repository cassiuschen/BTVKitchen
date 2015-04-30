//
//  MeetViewController.h
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/18.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Detail.h"
#import "ViewController.h"
#import "FoodMaterialViewController.h"

static BOOL checked[6];

@interface MeetViewController : Detail
@property ViewController* delegate;
@property (retain) NSMutableArray* delegateArray;

@end
