Pod::Spec.new do |s|
  s.name = "GoogleMobileAdsMediationZplayAds"
  s.version = "2.6.0"
  s.summary = "ZplayAds adapter used for mediation with the Google Mobile Ads SDK"
  s.license = "Custom"
  s.authors = {"zplay sdk team"=>"ad-client@zplay.cn"}
  s.homepage = "https://github.com/yumimobi/PlayableAds-iOS"
  s.description = "ZplayAds SDK provides a better ad format for monetizing."
  s.source = {:git => 'git@github.com:zplayads/PlayableAdMobDemo-iOS.git', :tag => s.version.to_s}
  s.source_files = 'PlayableAdMobDemo/Adapters/*.{h,m}'
  s.ios.deployment_target = '8.0'
  s.dependency 'PlayableAds', '~> 2.6.0'
  s.dependency 'Google-Mobile-Ads-SDK'
end
