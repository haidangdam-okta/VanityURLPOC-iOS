//
//  ViewController.m
//  VanityURLPOC-iOS
//
//  Created by Hai-Dang Dam on 6/18/18.
//  Copyright © 2018 Hai-Dang Dam. All rights reserved.
//

#import "ViewController.h"
#import <netdb.h>
@import dnssd;
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editText;
+ (NSString *) getCName;
+ (void) setCName: (NSString *)cname;
@end

@implementation ViewController

static NSString *cName;
+ (void) setCName:(NSString *)cname {
    cName = cname;
}

+(NSString *) getCName {
    return cName;
}

- (void) canonicalAddressForHostAddress: (NSString* )hostAddess {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DNSServiceRef serviceRef;
        DNSServiceErrorType error;
        error = DNSServiceQueryRecord(&serviceRef, 0, 0, "dan.sigmanetcorp.us", kDNSServiceType_CNAME,
                                      kDNSServiceClass_IN, queryCallback, NULL);
        if (error != kDNSServiceErr_NoError){
            NSLog(@"DNS Service error");
        }
        
        DNSServiceProcessResult(serviceRef);
        DNSServiceRefDeallocate(serviceRef);
    });
    
    
}



static void queryCallback(DNSServiceRef sdRef,
                          DNSServiceFlags flags,
                          uint32_t interfaceIndex,
                          DNSServiceErrorType errorCode,
                          const char *fullname,
                          uint16_t rrtype,
                          uint16_t rrclass,
                          uint16_t rdlen,
                          const void *rdata,
                          uint32_t ttl,
                          void *context) {
    if (errorCode == kDNSServiceErr_NoError && rdlen > 1) {
        NSMutableData *txtData = [NSMutableData dataWithCapacity:rdlen];
        
        
        for (uint16_t i = 1; i < rdlen; i += 256) {
            [txtData appendBytes:rdata + i length:MIN(rdlen - i, 256)];
        }
        
        
        
        NSString *theTXT = [[NSString alloc] initWithBytes:txtData.bytes length:txtData.length encoding:NSUTF8StringEncoding];
        [ViewController setCName:theTXT];
        NSLog(@"%@", theTXT);
    }
}


/*NSString *s = [[NSString alloc] initWithBytes:rdata
 length:rdlen
 encoding:NSUTF8StringEncoding];
 
 NSLog(@"%@", s);
 
 }
 */


- (IBAction)touchButton:(UIButton *)sender {
    NSString *userInput = self.editText.text;
    [self canonicalAddressForHostAddress:userInput];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"URL POC" message:[NSString stringWithFormat:@"URL return from %@: %@", self.editText.text, [ViewController getCName]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *acknowledge = [UIAlertAction actionWithTitle:@"Acknowledge" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {
        NSLog(@"User acknowledge");
    }];
    [alert addAction:acknowledge];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
