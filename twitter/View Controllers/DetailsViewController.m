//
//  DetailsViewController.m
//  twitter
//
//  Created by Samuel Osa-Agbontaen on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNameView.text = self.tweet.user.name;
    self.screenNameView.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.favCountView.text = [@(self.tweet.favoriteCount) stringValue];
    self.retweetCountView.text =[@(self.tweet.retweetCount) stringValue];
    self.userTweetView.text = self.tweet.text;
    
//    [self refreshCell];
//
    long dateTweetedAsInt;

    if ([self.tweet.dateTweeted secondsAgo] < 60){
        dateTweetedAsInt = [self.tweet.dateTweeted secondsAgo];
        self.dateView.text = [NSString stringWithFormat:@"%lds", dateTweetedAsInt];
    }
    else if ([self.tweet.dateTweeted minutesAgo] < 60){
        dateTweetedAsInt = [self.tweet.dateTweeted minutesAgo];
        self.dateView.text = [NSString stringWithFormat:@"%ldm", dateTweetedAsInt];
    }
    else if ([self.tweet.dateTweeted hoursAgo] < 24){
        dateTweetedAsInt = [self.tweet.dateTweeted hoursAgo];
        self.dateView.text = [NSString stringWithFormat:@"%ldh", dateTweetedAsInt];
    }
    else if ([self.tweet.dateTweeted daysAgo] < 7){
        dateTweetedAsInt = [self.tweet.dateTweeted daysAgo];
        self.dateView.text = [NSString stringWithFormat:@"%ldd", dateTweetedAsInt];
    }
    else{
        NSString *formattedDate = [self.tweet.dateTweeted formattedDateWithStyle:NSDateFormatterShortStyle];
        self.dateView.text = formattedDate;
    }

    // Upload profile picture of user who tweeted
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profilePicView.image = nil;
    UIImage *imageFromData = [UIImage imageWithData:urlData];
    self.profilePicView.image = imageFromData;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
*/

@end
