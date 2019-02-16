//
//  ReactNativePermissions.m
//  ReactNativePermissions
//
//  Created by Yonah Forst on 18/02/16.
//  Copyright © 2016 Yonah Forst. All rights reserved.
//

@import Contacts;

#import "ReactNativePermissions.h"

#if __has_include(<React/RCTBridge.h>)
  #import <React/RCTBridge.h>
#elif __has_include("React/RCTBridge.h")
  #import "React/RCTBridge.h"
#else
  #import "RCTBridge.h"
#endif

#if __has_include(<React/RCTConvert.h>)
  #import <React/RCTConvert.h>
#elif __has_include("React/RCTConvert.h")
  #import "React/RCTConvert.h"
#else
  #import "RCTConvert.h"
#endif

#if __has_include(<React/RCTEventDispatcher.h>)
  #import <React/RCTEventDispatcher.h>
#elif __has_include("React/RCTEventDispatcher.h")
  #import "React/RCTEventDispatcher.h"
#else
  #import "RCTEventDispatcher.h"
#endif

#import "RNPAudioVideo.h"

@interface ReactNativePermissions()
@end

@implementation ReactNativePermissions


RCT_EXPORT_MODULE();
@synthesize bridge = _bridge;

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init]) {
    }

    return self;
}

/**
 * run on the main queue.
 */
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}


RCT_REMAP_METHOD(canOpenSettings, canOpenSettings:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    resolve(@(UIApplicationOpenSettingsURLString != nil));
}


RCT_EXPORT_METHOD(openSettings:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    if (@(UIApplicationOpenSettingsURLString != nil)) {

        NSNotificationCenter * __weak center = [NSNotificationCenter defaultCenter];
        id __block token = [center addObserverForName:UIApplicationDidBecomeActiveNotification
                                               object:nil
                                                queue:nil
                                           usingBlock:^(NSNotification *note) {
                                               [center removeObserver:token];
                                               resolve(@YES);
                                           }];

        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


RCT_REMAP_METHOD(getPermissionStatus, getPermissionStatus:(RNPType)type json:(id)json resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *status;

    switch (type) {
        case RNPTypeCamera:
            status = [RNPAudioVideo getStatus:@"video"];
            break;
        default:
            break;
    }

    resolve(status);
}

RCT_REMAP_METHOD(requestPermission, permissionType:(RNPType)type json:(id)json resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *status;

    switch (type) {
        case RNPTypeCamera:
            return [RNPAudioVideo request:@"video" completionHandler:resolve];
    }


}


@end
