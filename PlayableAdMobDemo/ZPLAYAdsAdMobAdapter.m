//
//  ZPLAYAdsAdMobAdapter.m
//  PlayableAdMobDemo
//
//  Created by lgd on 2017/12/7.
//  Copyright © 2017年 playable. All rights reserved.
//

#import "ZPLAYAdsAdMobAdapter.h"
@import PlayableAds;

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
    NSString *paramStr = [_rewardedConnector.credentials objectForKey:@"parameter"];
    NSString *trimIds = [paramStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *ids = [trimIds componentsSeparatedByString:@" "];
    NSLog(@"playalbe appID: %@ and adUnitID: %@", ids[0], ids[1]);
    _pAd = [[PlayableAds alloc] initWithAdUnitID:ids[1] appID:ids[0]];
    _pAd.autoLoad = NO;
    _pAd.delegate = self;
    [_rewardedConnector adapterDidSetUpRewardBasedVideoAd:self];
    NSLog(@"zp=> setUp");
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
}

- (void)playableAdsDidStartPlaying:(PlayableAds *)ads {
    [_rewardedConnector adapterDidStartPlayingRewardBasedVideoAd:self];
    NSLog(@"zp=> adapterDidStartPlayingRewardBasedVideoAd");
}

- (void)playableAdsWillPresentScreen:(PlayableAds *)ads {
     [_rewardedConnector adapterDidOpenRewardBasedVideoAd:self];
    NSLog(@"zp=> adapterDidOpenRewardBasedVideoAd");
}

- (void)playableAdsDidEndPlaying:(PlayableAds *)ads {
}

- (void)playableAdsWillDismissScreen:(PlayableAds *)ads {
    [_rewardedConnector adapterDidCloseRewardBasedVideoAd:self];
    NSLog(@"zp=> adapterDidCloseRewardBasedVideoAd");
}

- (void)playableAdsDidClickFromLandingPage:(PlayableAds *)ads {
    [_rewardedConnector adapterDidGetAdClick:self];
    NSLog(@"zp=> adapterDidGetAdClick");
}

- (void)playableAdsWillLeaveApplication:(PlayableAds *)ads {
    [_rewardedConnector adapterWillLeaveApplication:self];
    NSLog(@"zp=> adapterWillLeaveApplication");
}


@end
