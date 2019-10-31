//
//  ZPLAYAdsAdMobInterstitialAdapter.m
//  PlayableAdMobDemo
//
//  Created by lgd on 2018/4/19.
//  Copyright © 2018年 playable. All rights reserved.
//

#import "ZPLAYAdsAdMobInterstitialAdapter.h"

static NSString *const customEventErrorDomain = @"com.google.CustomEvent";
@implementation ZPLAYAdsAdMobInterstitialAdapter
@synthesize delegate;

- (void)requestInterstitialAdWithParameter:(NSString *GAD_NULLABLE_TYPE)serverParameter
                                     label:(NSString *GAD_NULLABLE_TYPE)serverLabel
                                   request:(GADCustomEventRequest *)request {
    NSDictionary *paramterDict = [self dictionaryWithJsonString:serverParameter];
    NSCAssert(paramterDict, @"Yumi paramter is invalid，please check yumi adapter config");
    NSString *AppID = paramterDict[@"AppID"];
    NSString *AdUnitID = paramterDict[@"AdUnitID"];
    
    self.pAd = [[PlayableAds alloc] initWithAdUnitID:AdUnitID appID:AppID];
    self.pAd.delegate = self;
    self.pAd.autoLoad = NO;
    [self.pAd loadAd];
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    if (self.pAd.ready) {
        [self.pAd present];
    } else {
        NSLog(@"ZPLAYAds interstitial not ready");
    }
}

#pragma mark: private
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - PlayableAdsDelegate
- (void)playableAdsDidLoad:(PlayableAds *)ads {
    [self.delegate customEventInterstitialDidReceiveAd:self];
    NSLog(@"zp=> customEventInterstitialDidReceiveAd");
}

- (void)playableAds:(PlayableAds *)ads didFailToLoadWithError:(NSError *)error {
    NSError *e = [NSError errorWithDomain:customEventErrorDomain
                                         code:-1
                                     userInfo:nil];
    [self.delegate customEventInterstitial:self didFailAd:e];
    NSLog(@"zp=> didFailToLoadRewardBasedVideoAdwithError: %@", [error description]);
}

- (void)playableAdsDidRewardUser:(PlayableAds *)ads {
}

- (void)playableAdsDidDismissScreen:(PlayableAds *)ads {
    [self.delegate customEventInterstitialDidDismiss:self];
}

- (void)playableAdsDidStartPlaying:(PlayableAds *)ads {
    [self.delegate customEventInterstitialWillPresent:self];
    NSLog(@"zp=> adapterDidStartPlayingRewardBasedVideoAd");
}

- (void)playableAdsDidEndPlaying:(PlayableAds *)ads {
}

- (void)playableAdsDidPresentLandingPage:(PlayableAds *)ads{
    
}

- (void)playableAdsDidClick:(PlayableAds *)ads{
    [self.delegate customEventInterstitialWasClicked:self];
}

@end


