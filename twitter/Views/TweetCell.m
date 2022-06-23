//
//  TweetCell.m
//  twitter
//
//  Created by Samuel Osa-Agbontaen on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell


- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self postRequestAddFavorites];
        
    }
    else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [self postRequestRemoveFavorites];
    }
    [self refreshCell];
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == NO){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self postRequestAddRetweet];
        
    }
    else{
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [self postRequestRemoveRetweet];
    }
    [self refreshCell];
}

- (void)refreshCell{
    [self refreshFavorites];
    [self refreshRetweets];
}

- (void)refreshFavorites{
    UIImage *favSelected = [UIImage imageNamed:@"favor-icon-red"];
    UIImage *favDeselected = [UIImage imageNamed:@"favor-icon"];
    
    [self.favoriteView setSelected:FALSE];
    [self.favoriteView setHighlighted:FALSE];
    
    self.favCountView.text = [@(self.tweet.favoriteCount) stringValue];
    
    if (self.tweet.favorited == YES){
        [self.favoriteView setImage:favSelected
                           forState:UIControlStateNormal];
    }
    else{
        [self.favoriteView setImage:favDeselected
                           forState:UIControlStateNormal];
    }
}

- (void)refreshRetweets{
    UIImage *retweetSelected = [UIImage imageNamed:@"retweet-icon-green"];
    UIImage *retweetDeselected = [UIImage imageNamed:@"retweet-icon"];
    
    [self.retweetView setSelected:FALSE];
    [self.retweetView setHighlighted:FALSE];
    
    self.retweetCountView.text = [@(self.tweet.retweetCount) stringValue];
    
    if (self.tweet.retweeted == YES){
        [self.retweetView setImage:retweetSelected
                           forState:UIControlStateNormal];
    }
    else{
        [self.retweetView setImage:retweetDeselected
                           forState:UIControlStateNormal];
    }
}

- (void)postRequestAddFavorites{
    // POST request to the POST favorites/create endpoint
     [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
}

- (void)postRequestRemoveFavorites{
    // POST request to the POST favorites/create endpoint
     [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
         }
     }];
}

- (void)postRequestAddRetweet{
    // POST request to the POST favorites/create endpoint
     [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
         }
     }];
}

- (void)postRequestRemoveRetweet{
    // POST request to the POST favorites/create endpoint
     [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
         }
     }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
