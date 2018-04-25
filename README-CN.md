## 一 接入ZPLAY Ads SDK和AdMob SDK
以cocoapods为例，其它请查看ZPLAY Ads广告接入文档，AdMob SDK接入文档，以下简要步骤
1. 在项目终端下执行```pod init```
2. 编辑Podfile，添加库
```
# AdMob library
pod ‘Google-Mobile-Ads-SDK’

# PlayableAd library
pod 'PlayableAds', '~>2.0.5'
```
如下所示
![image](imgs/image01.png)
3. 执行```pod install --repo-update``` 看到如下信息证明安装完成
![image](imgs/image02.png)
## 二 在AdMob平台添加ZPLAY Ads广告广告源
