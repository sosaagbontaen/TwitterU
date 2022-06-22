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
    
    // TODO: Update cell UI
    if (self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [sender setSelected:YES];
    }
    else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [sender setSelected:NO];
    }
    [self refreshData];
    
    // TODO: Send a POST request to the POST favorites/create endpoint
     [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
}

- (void)refreshData{
    UIImage *favSelected = [UIImage imageNamed:@"favor-icon-red"];
    UIImage *favDeselected = [UIImage imageNamed:@"favor-icon"];
    
    [self.favoriteView setImage:favSelected
                       forState:UIControlStateSelected];
    [self.favoriteView setImage:favDeselected
                       forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
