//
//  PlayableAdMobAdapter.h
//  PlayableAdMobDemo
//
//  Created by lgd on 2017/12/7.
//  Copyright © 2017年 playable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/Mediation/GADMRewardBasedVideoAdNetworkConnectorProtocol.h>
#import <GoogleMobileAds/Mediation/GADMRewardBasedVideoAdNetworkAdapterProtocol.h>
@import GoogleMobileAds;
@import PlayableAds;

@interface PlayableAdMobAdapter : NSObject<GADMRewardBasedVideoAdNetworkAdapter, PlayableAdsDelegate> {
}
@property(nonatomic, strong) PlayableAds *pAd;
@property(nonatomic, strong) id<GADMAdNetworkConnector> connector;
@property(nonatomic, strong) id<GADMRewardBasedVideoAdNetworkConnector> rewardedConnector;

@end
