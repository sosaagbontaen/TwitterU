//
//  TweetCell.h
//  twitter
//
//  Created by Samuel Osa-Agbontaen on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UILabel *userNameView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteView;
@property (weak, nonatomic) IBOutlet UIButton *retweetView;
@property (weak, nonatomic) IBOutlet UILabel *userTweetView;
@property (weak, nonatomic) IBOutlet UILabel *favCountView;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountView;
@property Tweet* tweet;
- (void)refreshCell;
@end

NS_ASSUME_NONNULL_END
