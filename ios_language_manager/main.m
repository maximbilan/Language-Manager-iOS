//
//  main.m
//  ios_language_manager
//
//  Created by Maxim Bilan on 12/23/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LanguageManager.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [LanguageManager setupCurrentLanguage];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
