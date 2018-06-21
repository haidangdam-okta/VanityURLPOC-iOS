//
//  ViewController.m
//  VanityURLPOC-iOS
//
//  Created by Hai-Dang Dam on 6/18/18.
//  Copyright © 2018 Hai-Dang Dam. All rights reserved.
//

#import "ViewController.h"
#import <netdb.h>
#import <dns_sd.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *editText;

@end

static ViewController *viewController;

@implementation ViewController


- (NSString *) canonicalAddressForHostAddress: (NSString *)hostAddess {
    const char* hostAddress_char = [hostAddess UTF8String];
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






     
- (void) showUserAlertWithString: (NSString *)string {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"URL POC" message:[NSString stringWithFormat:@"URL return from %@: %@", self.editText.text, string] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *acknowledge = [UIAlertAction actionWithTitle:@"Acknowledge" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"User acknowledge");
    }];
    [alert addAction:acknowledge];
    [self presentViewController:alert animated:YES completion:nil];
}



- (IBAction)touchButton:(UIButton *)sender {
    NSString *userInput = self.editText.text;
    NSString *canAddr = [self canonicalAddressForHostAddress:userInput];
    [self showUserAlertWithString:canAddr];
}



@end
