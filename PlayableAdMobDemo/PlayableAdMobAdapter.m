//
//  PlayableAdMobAdapter.m
//  PlayableAdMobDemo
//
//  Created by lgd on 2017/12/7.
//  Copyright © 2017年 playable. All rights reserved.
//

#import "PlayableAdMobAdapter.h"
@import PlayableAds;

@implementation PlayableAdMobAdapter

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
    _pAd.delegate = self;
    [_pAd loadAd];
}

- (void)stopBeingDelegate {
}

+ (Class<GADAdNetworkExtras>)networkExtrasClass {
    return nil;
}

- (void)requestRewardBasedVideoAd {
}


#pragma mark PlayableAd
- (void)playableAdsDidRewardUser:(PlayableAds *)ads {
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardedConnector;
    [strongConnector adapter: nil didRewardUserWithReward:nil];
}

- (void)playableAdsDidLoad:(PlayableAds *)ads {
    id<GADMRewardBasedVideoAdNetworkConnector> strongConnector = _rewardedConnector;
    if (_pAd.isReady) {
        [strongConnector adapterDidReceiveRewardBasedVideoAd:self];
    } else {
        NSString *description = @"Failed to load ad.";
        NSDictionary *userInfo =
        @{NSLocalizedDescriptionKey : description, NSLocalizedFailureReasonErrorKey : description};
        NSError *error =
        [NSError errorWithDomain:@"com.google.mediation.sample" code:0 userInfo:userInfo];
        [strongConnector adapter:self didFailToLoadRewardBasedVideoAdwithError:error];
    }
}


@end
