//
//  AppDelegate.h
//  VanityURLPOC-iOS
//
//  Created by Hai-Dang Dam on 6/18/18.
//  Copyright © 2018 Hai-Dang Dam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

