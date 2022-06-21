//
//  Tweet.m
//  twitter
//
//  Created by Samuel Osa-Agbontaen on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

// Initializer for Tweet with a dictionary
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    if (self)
    {
        // If Tweet is a re-tweet
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if (originalTweet != nil)
        {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        //Get dictionary from Tweet's user property (used in initializing user)
        NSDictionary *user = dictionary[@"user"];
        //Initialize user object using User initializer
        self.user = [[User alloc] initWithDictionary:user];
        
        // Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // Configure input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        
        //Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        // COnvert Date to String
        self.createdAtString = [formatter stringFromDate:date];
            
    }
    return self;
}

+(NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}
@end