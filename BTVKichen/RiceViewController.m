//
//  RiceViewController.m
//  BTVKichen
//
//  Created by 夏子皓 on 14/12/14.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "RiceViewController.h"

@interface RiceViewController ()

@end

@implementation RiceViewController{
    NSString* titles[5];
    UIImage* chosen;
}
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titles[0]=@"粗粮";
    titles[1]=@"面条";
    titles[2]=@"面粉";
    titles[3]=@"糯米";
    titles[4]=@"其他米面类";
    chosen = [UIImage imageNamed:@"fenlei_choosen.png"];
    self.preferredContentSize = CGSizeMake(240.0f, 220.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    UIImageView* checkmark = (UIImageView*)[cell.contentView viewWithTag:1];
    UILabel* label = (UILabel*)[cell.contentView viewWithTag:2];
    label.text = titles[indexPath.row];
    
    
    
    if(delegate.tagNameArray.count!=0)
    {
        for(int i=0;i<=3;i++)
        {
            if([titles[indexPath.row] isEqualToString:[delegate.tagNameArray objectAtIndex:i]])
            {
                checkmark.image = chosen;
            }
        }
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView* checkmark = (UIImageView*)[cell.contentView viewWithTag:1];
    if(checkmark.image==nil){
        
        if([delegate creatTagViewWithTitle:titles[indexPath.row]])
        {
            checkmark.image = chosen;
        }
        
    }
    else
    {
        checkmark.image = nil;
        [delegate deleteTagViewWithTitle:titles[indexPath.row]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
