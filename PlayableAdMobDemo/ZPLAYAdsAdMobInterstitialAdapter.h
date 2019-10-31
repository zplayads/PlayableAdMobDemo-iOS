//
//  ZPLAYAdsAdMobInterstitialAdapter.h
//  PlayableAdMobDemo
//
//  Created by lgd on 2018/4/19.
//  Copyright © 2018年 playable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlayableAds/AtmosplayAdsBanner.h>

@import GoogleMobileAds;

@interface ZPLAYAdsAdMobInterstitialAdapter : NSObject<GADCustomEventInterstitial, PlayableAdsDelegate>{
}

@property(nonatomic) PlayableAds *pAd;

@end
