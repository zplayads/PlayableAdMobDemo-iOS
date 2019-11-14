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
    
    NSDictionary *paramterDict = [self dictionaryWithJsonString:serverParameter];
    NSCAssert(paramterDict, @"Yumi paramter is invalid，please check yumi adapter config");
    NSString *AppID = paramterDict[@"AppID"];
    NSString *AdUnitID = paramterDict[@"AdUnitID"];

    self.bannerView = [[AtmosplayAdsBanner alloc] initWithAdUnitID:AdUnitID appID:AppID rootViewController:[self.delegate viewControllerForPresentingModalView]];
    self.bannerView.delegate = self;
    
    self.bannerView.bannerSize = kAtmosplayAdsBanner320x50;
    if (GADAdSizeEqualToSize(adSize, kGADAdSizeLeaderboard)) {
        self.bannerView.bannerSize = kAtmosplayAdsBanner728x90;
    } else if (GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerPortrait)) {
        self.bannerView.bannerSize = kAtmosplayAdsSmartBannerPortrait;
    } else if (GADAdSizeEqualToSize(adSize, kGADAdSizeSmartBannerLandscape)) {
        self.bannerView.bannerSize = kAtmosplayAdsSmartBannerLandscape;
    }
    
    [self.bannerView loadAd];
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

#pragma mark - AtmosplayAdsBannerDelegate
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
