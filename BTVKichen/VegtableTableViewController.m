//
//  VegtableTableViewController.m
//  BTVKichen
//
//  Created by 夏子皓 on 14/12/13.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "VegtableTableViewController.h"

@interface VegtableTableViewController ()

@end

@implementation VegtableTableViewController{
    NSString* titles[5];
    UIImage* chosen;
}
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    titles[0]=@"叶类";
    titles[1]=@"根茎类";
    titles[2]=@"瓜类";
    titles[3]=@"豆类";
    titles[4]=@"其他蔬菜";
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
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
