//
//  ZPLAYAdsAdMobAdapter.m
//  PlayableAdMobDemo
//
//  Created by lgd on 2017/12/7.
//  Copyright © 2017年 playable. All rights reserved.
//

#import "ZPLAYAdsAdMobAdapter.h"
#import <PlayableAds/AtmosplayAdsBanner.h>

@implementation ZPLAYAdsAdMobAdapter

- (instancetype)initWithRewardBasedVideoAdNetworkConnector: (id<GADMRewardBasedVideoAdNetworkConnector>)connector {
    if (!connector) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _rewardedConnector = connector;
    }
    return self;
}

+ (NSString *)adapterVersion {
    return @"1.0.0";
}


- (void)presentRewardBasedVideoAdWithRootViewController:(UIViewController *)viewController {
    if (_pAd.isReady) {
        [_pAd present];
    } else {
        NSLog(@"No ads to show.");
    }
}

- (void)setUp {
    NSDictionary *paramterDict = [self dictionaryWithJsonString:[_rewardedConnector credentials][@"parameter"]];
    NSCAssert(paramterDict, @"Yumi paramter is invalid，please check yumi adapter config");
    NSString *AppID = paramterDict[@"AppID"];
    NSString *AdUnitID = paramterDict[@"AdUnitID"];
    
    _pAd = [[PlayableAds alloc] initWithAdUnitID:AdUnitID appID:AppID];
    _pAd.autoLoad = NO;
    _pAd.delegate = self;
    [_rewardedConnector adapterDidSetUpRewardBasedVideoAd:self];
    NSLog(@"zp=> setUp");
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

- (void)stopBeingDelegate {
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return nil;
}

- (void)requestRewardBasedVideoAd {
    [_pAd loadAd];
    NSLog(@"zp=> requestRewardBasedVideoAd");
}

#pragma mark - PlayableAdsDelegate
- (void)playableAdsDidLoad:(PlayableAds *)ads {
    [_rewardedConnector adapterDidReceiveRewardBasedVideoAd:self];
    NSLog(@"zp=> adapterDidReceiveRewardBasedVideoAd");
}

- (void)playableAds:(PlayableAds *)ads didFailToLoadWithError:(NSError *)error {
    [_rewardedConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
    NSLog(@"zp=> didFailToLoadRewardBasedVideoAdwithError");
}

- (void)playableAdsDidRewardUser:(PlayableAds *)ads {
    GADAdReward *reward = [[GADAdReward alloc] initWithRewardType:@"ZPLAYAds" rewardAmount:[NSDecimalNumber  decimalNumberWithString:@"1"]];
    [_rewardedConnector adapter: self didRewardUserWithReward:reward];
    NSLog(@"zp=> didRewardUserWithReward");
}

- (void)playableAdsDidDismissScreen:(PlayableAds *)ads {
    [_rewardedConnector adapterDidCloseRewardBasedVideoAd:self];
    NSLog(@"zp=> adapterDidCloseRewardBasedVideoAd");
}

- (void)playableAdsDidStartPlaying:(PlayableAds *)ads {
    [_rewardedConnector adapterDidOpenRewardBasedVideoAd:self];
    [_rewardedConnector adapterDidStartPlayingRewardBasedVideoAd:self];
    NSLog(@"zp=> adapterDidStartPlayingRewardBasedVideoAd");
}

- (void)playableAdsDidEndPlaying:(PlayableAds *)ads {
    NSLog(@"zp=> playableAdsDidEndPlaying");
}

- (void)playableAdsDidClick:(PlayableAds *)ads{
    [_rewardedConnector adapterDidGetAdClick:self];
    NSLog(@"zp=> playableAdsDidClick");
}

- (void)playableAdsDidPresentLandingPage:(PlayableAds *)ads{
    NSLog(@"zp=> playableAdsDidPresentLandingPage");
}

@end
