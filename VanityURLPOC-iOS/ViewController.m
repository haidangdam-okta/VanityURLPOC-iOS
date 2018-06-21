//
//  ViewController.m
//  VanityURLPOC-iOS
//
//  Created by Hai-Dang Dam on 6/18/18.
//  Copyright © 2018 Hai-Dang Dam. All rights reserved.
//

#import "ViewController.h"
#import <dns_sd.h>
#import "FindCName.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *editText;

@end

static ViewController *viewController;

@implementation ViewController

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
    NSString *canAddr = [FindCName findCNameWithHost:userInput];
    [self showUserAlertWithString:canAddr];
}



@end
