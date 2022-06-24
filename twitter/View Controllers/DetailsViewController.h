//
//  DetailsViewController.h
//  twitter
//
//  Created by Samuel Osa-Agbontaen on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *userNameView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameView;
@property (weak, nonatomic) IBOutlet UILabel *favCountView;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountView;
@property (weak, nonatomic) IBOutlet UILabel *userTweetView;
@property (weak, nonatomic) IBOutlet UILabel *dateView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (nonatomic, strong) Tweet *tweet;
@end

NS_ASSUME_NONNULL_END
