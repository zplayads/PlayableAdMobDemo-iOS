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
    NSLog(@"zp=> AdMob UI config is right. %@", serverParameter);
    if (!serverParameter){
        NSLog(@"server parameter is nil");
        return;
    }
    
    NSString *trimIds = [serverParameter stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *ids = [trimIds componentsSeparatedByString:@" "];
    NSLog(@"zp=> %@ : %@", ids[1], ids[0]);
    self.pAd = [[PlayableAds alloc] initWithAdUnitID:ids[1] appID:ids[0]];
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


