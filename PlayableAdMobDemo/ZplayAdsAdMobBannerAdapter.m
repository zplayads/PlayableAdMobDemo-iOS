//
//  ZplayAdsAdMobBannerAdapter.m
//  PlayableAdMobDemo
//
//  Created by 王泽永 on 2019/10/30.
//  Copyright © 2019 playable. All rights reserved.
//

#import "ZplayAdsAdMobBannerAdapter.h"
#import <PlayableAds/AtmosplayAdsBanner.h>

@interface ZplayAdsAdMobBannerAdapter () <AtmosplayAdsBannerDelegate>
@property (nonatomic) AtmosplayAdsBanner *bannerView;

@end

@implementation ZplayAdsAdMobBannerAdapter
@synthesize delegate;
- (void)requestBannerAd:(GADAdSize)adSize parameter:(nullable NSString *)serverParameter label:(nullable NSString *)serverLabel request:(nonnull GADCustomEventRequest *)request {
    NSLog(@"zp=> AdMob UI config is right. %@", serverParameter);
    if (!serverParameter){
        NSLog(@"server parameter is nil");
        return;
    }
    
    NSString *trimIds = [serverParameter stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *ids = [trimIds componentsSeparatedByString:@" "];
    NSLog(@"zp=> %@ : %@", ids[1], ids[0]);
    NSString *AppID = ids[0];
    NSString *AdUnitID = ids[1];

    self.bannerView = [[AtmosplayAdsBanner alloc] initWithAdUnitID:AdUnitID appID:AppID rootViewController:[self.delegate viewControllerForPresentingModalView]];
    self.bannerView.delegate = self;
    
    if (GADAdSizeEqualToSize(adSize, kGADAdSizeBanner)) {
        self.bannerView.bannerSize = kAtmosplayAdsBanner320x50;
    } else if (GADAdSizeEqualToSize(adSize, kGADAdSizeLeaderboard)) {
        self.bannerView.bannerSize = kAtmosplayAdsBanner728x90;
    } else if (GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerPortrait)) {
        self.bannerView.bannerSize = kAtmosplayAdsSmartBannerPortrait;
    } else if (GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerLandscape)) {
        self.bannerView.bannerSize = kAtmosplayAdsSmartBannerLandscape;
    }
    
    self.bannerView.bannerSize = kAtmosplayAdsBanner320x50;
    [self.bannerView loadAd];
}

/// Tells the delegate that an ad has been successfully loaded.
- (void)atmosplayAdsBannerViewDidLoad:(AtmosplayAdsBanner *)bannerView {
    [self.delegate customEventBanner:self didReceiveAd:bannerView];
}

/// Tells the delegate that a request failed.
- (void)atmosplayAdsBannerView:(AtmosplayAdsBanner *)bannerView didFailWithError:(NSError *)error {
    self.bannerView.delegate = nil;
    self.bannerView = nil;
    [self.delegate customEventBanner:self didFailAd:error];
}

/// Tells the delegate that the banner view has been clicked.
- (void)atmosplayAdsBannerViewDidClick:(AtmosplayAdsBanner *)bannerView {
    [self.delegate customEventBannerWasClicked:self];
    [self.delegate customEventBannerWillLeaveApplication:self];
}

- (void)dealloc {
    self.bannerView.delegate = nil;
    self.bannerView = nil;
}

@end
