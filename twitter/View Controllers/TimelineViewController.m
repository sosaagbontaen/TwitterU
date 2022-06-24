//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "DateTools.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
- (IBAction)didTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    NSLog(@"YoO!");

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];
}

- (void)didTweet:(Tweet *)tweet{
    [self.arrayOfTweets insertObject:tweet
                                    atIndex:0];
    [self.tableView reloadData];
}

- (void)fetchTweets{
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = (NSMutableArray*)tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *dictionary in tweets) {
                NSLog(@"%@", dictionary.text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
        // Tell the refreshControl to stop spinning
         [self.refreshControl endRefreshing];
        
    }];
}
 




- (NSInteger)tableView:(UITableView *)tableView
             numberOfRowsInSection:(NSInteger)section{
    //Returns the number of rows in your table view
    return self.arrayOfTweets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    
    // Upload tweet data to views
    cell.tweet = tweet;
    cell.favCountView.text = [@(tweet.favoriteCount) stringValue];
    cell.retweetCountView.text =[@(tweet.retweetCount) stringValue];
    cell.screenNameView.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName ];
    cell.userNameView.text = tweet.user.name;
    cell.userTweetView.text = tweet.text;
    [cell refreshCell];
    
    long dateTweetedAsInt;
    
    if ([tweet.dateTweeted secondsAgo] < 60){
        dateTweetedAsInt = [tweet.dateTweeted secondsAgo];
        cell.dateView.text = [NSString stringWithFormat:@"%lds", dateTweetedAsInt];
    }
    else if ([tweet.dateTweeted minutesAgo] < 60){
        dateTweetedAsInt = [tweet.dateTweeted minutesAgo];
        cell.dateView.text = [NSString stringWithFormat:@"%ldm", dateTweetedAsInt];
    }
    else if ([tweet.dateTweeted hoursAgo] < 24){
        dateTweetedAsInt = [tweet.dateTweeted hoursAgo];
        cell.dateView.text = [NSString stringWithFormat:@"%ldh", dateTweetedAsInt];
    }
    else if ([tweet.dateTweeted daysAgo] < 7){
        dateTweetedAsInt = [tweet.dateTweeted daysAgo];
        cell.dateView.text = [NSString stringWithFormat:@"%ldd", dateTweetedAsInt];
    }
    else{
        NSString *formattedDate = [tweet.dateTweeted formattedDateWithStyle:NSDateFormatterShortStyle];
        cell.dateView.text = formattedDate;
    }
    
    //dateTweetedAsInt = [tweet.dateTweeted formattedDateWithStyle:"yyyy"];
    
    
    // Upload profile picture of user who tweeted
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    cell.profilePicView.image = nil;
    UIImage *imageFromData = [UIImage imageWithData:urlData];
    cell.profilePicView.image = imageFromData;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
}



- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}
@end
