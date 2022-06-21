//
//  User.m
//  twitter
//
//  Created by Samuel Osa-Agbontaen on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

// Initializer for user with a dictionary
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
     
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
    // Other dictionary properties initialized here
    }
    return self;
}

@end
