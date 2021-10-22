//
//  main.m
//  FFmpeg_Player
//
//  Created by Cloud on 2021/10/20.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include "SDL.h"
#include "SDL_main.h"
#include "ViewController.h"
//#undef main

int main(int argc, char * argv[]) {
//    NSString * appDelegateClassName;
//    @autoreleasepool {
//        // Setup code that might create autoreleased objects goes here.
//        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//    }
//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ViewController * vc = [[ViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        static UIWindow *window = nil;

        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [window setRootViewController:vc];
        [window makeKeyAndVisible];
    });
    return 0;
}
