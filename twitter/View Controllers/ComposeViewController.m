//
//  ComposeViewController.m
//  twitter
//
//  Created by Samuel Osa-Agbontaen on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetSpace;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetBtn;

@end

@implementation ComposeViewController
- (IBAction)closeTweetAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)sendTweetAction:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetSpace.text completion:^(Tweet* tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
