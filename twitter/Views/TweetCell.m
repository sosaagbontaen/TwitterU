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

- (void)refreshCell{
    [self refreshFavorites];
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
