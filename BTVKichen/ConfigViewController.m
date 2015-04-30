//
//  ConfigViewController.m
//  BTVKichen
//
//  Created by 夏 子皓 on 14/11/17.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "ConfigViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ConfigViewController ()

@end

@implementation ConfigViewController{
    UISwitch* wifi;
    UIAlertView* clearCache;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.frame = CGRectMake(0.0f, 0.0f, 996.0f, 658.0f);
    
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
    NSString *identifier = [NSString stringWithFormat:@"config%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if(indexPath.row==0)
    {
        wifi=(UISwitch*)[cell.contentView viewWithTag:1];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==4){return 600;}
    else return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        clearCache = [[UIAlertView alloc] initWithTitle:@"是否清除缓存？" message:@"清除需要一段时间，请耐心等待" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [clearCache show];
    }
    else if (indexPath.row==2) {
        NSURL* url = [[ NSURL alloc ] initWithString :@"http://www.suishenchufang.com"];
        [[UIApplication sharedApplication ] openURL:url];
    }
    else if(indexPath.row==3)
    {
        NSURL* url = [[ NSURL alloc ] initWithString :@"https://itunes.apple.com/cn/app/sui-shen-chu-fang/id957330900?mt=8"];
        [[UIApplication sharedApplication ] openURL:url];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [AVFile clearAllCachedFiles];
        NSUserDefaults* userDefaulfs = [NSUserDefaults standardUserDefaults];
        /*
        int count = 0;
        NSFileManager *defaultManager;
        defaultManager = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSArray *files = [defaultManager subpathsOfDirectoryAtPath: cachePath error:nil];
        NSLog(@"%@",files);
        NSArray *dishArray = [userDefaulfs objectForKey:@"DownloadDics"];
        for (int i=0; i<dishArray.count; i++) {
            NSArray *downloadArray = [[dishArray objectAtIndex:i] objectForKey:@"downloadArray"];
            count += downloadArray.count;
        }
        NSLog(@"%d",count);
        //[defaultManager removeFileAtPath: tildeFilename handler: nil];
        */
        
        [userDefaulfs setObject:nil forKey:@"DownloadDics"];
        clearCache = [[UIAlertView alloc] initWithTitle:@"缓存已清除" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [clearCache show];
    }
}

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

- (IBAction)whenWifi:(id)sender {
}
@end
