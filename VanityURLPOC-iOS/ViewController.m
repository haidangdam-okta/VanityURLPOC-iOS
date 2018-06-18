//
//  ViewController.m
//  VanityURLPOC-iOS
//
//  Created by Hai-Dang Dam on 6/18/18.
//  Copyright © 2018 Hai-Dang Dam. All rights reserved.
//

#import "ViewController.h"
#import <netdb.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editText;

@end

@implementation ViewController

- (NSString *) canonicalAddressForHostAddress: (NSString *)hostAddess {
    const char* hostAddress_char = [hostAddess UTF8String];
    struct addrinfo hints, *res;
    int retval;
    
    memset(&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = AF_UNSPEC;
    hints.ai_flags = AI_CANONNAME;
    
    retval = getaddrinfo(hostAddress_char, NULL, &hints, &res);
    if (retval == 0 && res->ai_canonname) {
        return [NSString stringWithUTF8String:res->ai_canonname];
    }
    return nil;
}

- (IBAction)touchButton:(UIButton *)sender {
    NSString *userInput = self.editText.text;
    NSString *canAddr = [self canonicalAddressForHostAddress:userInput];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"URL POC" message:[NSString stringWithFormat:@"URL return from %@: %@", self.editText.text, canAddr] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *acknowledge = [UIAlertAction actionWithTitle:@"Acknowledge" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"User acknowledge");
    }];
    [alert addAction:acknowledge];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
