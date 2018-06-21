//
//  FindCName.m
//  VanityURLPOC-iOS
//
//  Created by Hai-Dang Dam on 6/21/18.
//  Copyright © 2018 Hai-Dang Dam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindCName.h"
#import <netdb.h>

@implementation FindCName

+ (NSString *) findCNameWithHost:(NSString *) hostAddress {
    const char* hostAddress_char = [hostAddress UTF8String];
    struct addrinfo hints, *res;
    int retval;
    
    memset(&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = AF_INET;
    hints.ai_flags = AI_CANONNAME;
    
    retval = getaddrinfo(hostAddress_char, NULL, &hints, &res);
    
    
    if (retval == 0 && res->ai_canonname) {
        return [NSString stringWithUTF8String:res->ai_canonname];
    }
    return nil;
}

@end
