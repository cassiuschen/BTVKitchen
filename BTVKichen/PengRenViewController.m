//
//  PengRenViewController.m
//  BTVKichen
//
//  Created by 夏子皓 on 14/11/30.
//  Copyright (c) 2014年 com.seaver. All rights reserved.
//

#import "PengRenViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVOSCloud/AVOSCloud.h>

@interface PengRenViewController ()

@end

@implementation PengRenViewController{
    MPMoviePlayerController* movieController;
    NSURL* myURL;
    NSArray* downloadArray;
    float titleCenterX;
    float textCenterX;
    float titleCenterY;
    float textCenterY;
}

@synthesize titles;
@synthesize textView;
@synthesize datasource;
@synthesize downloadName;
@synthesize index;
@synthesize videoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    titleCenterX = titles.center.x;
    textCenterX = textView.center.x;
    titleCenterY = titles.center.y;
    textCenterY = textView.center.y;
    
    textView.text = [[datasource objectAtIndex:index] objectForKey:@"content"];
    titles.text = [NSString stringWithFormat:@"第 %d 步",index+1];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *videoPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[[datasource objectAtIndex:index] objectForKey:@"objectId"]]];
    myURL = [NSURL fileURLWithPath:videoPath];
    if(![fileManager fileExistsAtPath:videoPath])
    {
        AVObject* downloadObject = [datasource objectAtIndex:index];
        AVRelation* videoRelation = [downloadObject objectForKey:@"video"];
        AVQuery* videoQuery = [videoRelation query];
        AVFile* videoFile = [[[videoQuery findObjects] objectAtIndex:0] objectForKey:@"file"];
        myURL = [NSURL URLWithString:videoFile.url];
    }
    movieController = [[MPMoviePlayerController alloc] initWithContentURL: myURL];
    movieController.repeatMode = MPMovieRepeatModeOne;
    [movieController prepareToPlay];
    [movieController.view setFrame: videoView.bounds];
    [videoView addSubview: movieController.view];
    [movieController play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadVideo {
    [movieController stop];
    [movieController.view removeFromSuperview];
    movieController = nil;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *videoPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[[datasource objectAtIndex:index] objectForKey:@"objectId"]]];
    myURL = [NSURL fileURLWithPath:videoPath];
    if(![fileManager fileExistsAtPath:videoPath])
    {
        AVObject* downloadObject = [datasource objectAtIndex:index];
        AVRelation* videoRelation = [downloadObject objectForKey:@"video"];
        AVQuery* videoQuery = [videoRelation query];
        AVFile* videoFile = [[[videoQuery findObjects] objectAtIndex:0] objectForKey:@"file"];
        myURL = [NSURL URLWithString:videoFile.url];
    }
    movieController = [[MPMoviePlayerController alloc] initWithContentURL: myURL];
    movieController.repeatMode = MPMovieRepeatModeOne;
    [movieController prepareToPlay];
    [movieController.view setFrame: videoView.bounds];
    [videoView addSubview: movieController.view];
    [movieController play];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)next
{
    if (++index<=datasource.count-1) {
        textView.text = [[datasource objectAtIndex:index] objectForKey:@"content"];
        titles.text = [NSString stringWithFormat:@"第 %d 步",index+1];
        [UIView animateWithDuration:0.3 animations:^{
            titles.center = CGPointMake(-titles.frame.size.width/2, titleCenterY);
            textView.center = CGPointMake(-textView.frame.size.width/2, textCenterY);
        }completion:^(BOOL finished){
            textView.center = CGPointMake(textCenterX, textCenterY);
            titles.center = CGPointMake(titleCenterX, titleCenterY);
        }];
        [self loadVideo];
    }
    else{
        index = (int)datasource.count-1;
    }
}

- (void)pre
{
    if (--index>=0) {
        textView.text = [[datasource objectAtIndex:index] objectForKey:@"content"];
        titles.text = [NSString stringWithFormat:@"第 %d 步",index+1];
        [UIView animateWithDuration:0.3 animations:^{
            titles.center = CGPointMake(1024+titles.frame.size.width/2, titleCenterY);
            textView.center = CGPointMake(1024+textView.frame.size.width/2, textCenterY);
        }completion:^(BOOL finished){
            textView.center = CGPointMake(textCenterX, textCenterY);
            titles.center = CGPointMake(titleCenterX, titleCenterY);
        }];
        
        [self loadVideo];
    }
    else{
        index = 0;
    }

}

- (IBAction)nextStep:(id)sender {
    [self next];
}

- (IBAction)preStep:(id)sender {
    [self pre];
}

- (IBAction)back:(id)sender {
    [movieController stop];
    [self.view removeFromSuperview];
}
- (IBAction)swipToLeft:(id)sender {
    [self next];
}

- (IBAction)swipToRIght:(id)sender {
    [self pre];
}


- (void)viewWillDisappear:(BOOL)animated{
    [movieController pause];
}
 
@end
