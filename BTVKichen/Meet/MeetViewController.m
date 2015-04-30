//
//  MeetViewController.m
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/18.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "MeetViewController.h"

@interface MeetViewController ()

@end

@implementation MeetViewController
{
    NSString* titles[6];
    UIImage* chosen;
}
@synthesize delegate;
@synthesize delegateArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.preferredContentSize = CGSizeMake(240.0f, 262.0f);
    
    titles[0]=[NSString stringWithFormat:@"猪肉"];
    titles[1]=[NSString stringWithFormat:@"牛肉"];
    titles[2]=[NSString stringWithFormat:@"羊肉"];
    titles[3]=[NSString stringWithFormat:@"鸡肉"];
    titles[4]=[NSString stringWithFormat:@"鸭肉"];
    titles[5]=[NSString stringWithFormat:@"其他肉类"];
    
    chosen = [UIImage imageNamed:@"fenlei_choosen.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meat" forIndexPath:indexPath];
    
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

*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
