## 一 接入ZPLAY Ads SDK和AdMob SDK
以cocoapods为例，其它请查看ZPLAY Ads广告接入文档，AdMob SDK接入文档，以下简要步骤
1. 在项目终端下执行```pod init```
2. 编辑Podfile，添加库
```
# AdMob library
pod ‘Google-Mobile-Ads-SDK’

# PlayableAd library
pod 'PlayableAds', '~>2.0.7'
```
如下所示
![image](imgs/image01.png)
3. 执行```pod install --repo-update``` 安装依赖库
## 二 在AdMob平台添加ZPLAY Ads广告广告源

#### 1. 添加新应用
a. 选择目录中Apps，点击“ADD APP”按钮
![image](imgs/018addapp1.png)

b. 选择您的应用是否已经上架Googleplay或AppStore，以下以未上架为例
![image](imgs/018addapp2.png)

c. 输入应用名称，选择应用操作系统，点击“ADD”保存添加的应用
![image](imgs/019addapp3.png)

#### 2. 添加新广告位
a. 目录中选择“Apps”，选择您要添加广告位的应用

![image](imgs/001chooseapp.png)

b. 点击“ADD AD UNIT”按钮

![image](imgs/002addadunit1.png)

c. 选择您所需要的广告形式，ZPLAY Ads目前支持Interstitial及Rewarded，此处以Rewarded为例

![image](imgs/003addadunit2RV1.png)

d. 输入广告位名称及对广告位进行设置，点击“CREAT AD UNIT”保存添加的广告位

![image](imgs/004addadunit2RV2.png)

e. 获取此广告位的app ID及ad unit ID，点击“DONE”完成广告位的创建

![image](imgs/005addadunit2RV3.png)

#### 3. 添加ZPLAY Ads广告源
a. 进入Mediation目录，选择“CREATE MEDIATION GROUP”

![img](imgs/007mediationgroupcreate.png)

b. 选择您要使用的广告形式及操作系统，ZPLAY Ads目前支持Interstitial及Rewarded，此处以Rewarded为例，点击“CONTINUE”进入下一步

![img](imgs/008mediationgroupcreate1.png)

c. 输入Mediation名字，通过Location进行地域设置，状态置位Enable时Mediation才可生效，点击“ADD AD UNIT”选择要添加的广告位

![img](imgs/009mediationgroupcreat2.png)

d. 在广告位选择框中，先后选择所需应用及广告位，点击“SAVE”

![img](imgs/011mediationgroupcreate4.png)

e. 点击“ADD CUSTOM EVENT”添加自定义广告源

![img](imgs/012mediationgroupcreate5.png)

f. 输入第三方广告源名称，此处以ZPLAY Ads为例，可根据需求进行自定义，根据需要对第三方广告源进行价格设置

![img](imgs/013mediationgroupcreate6.png)

g. 对ZPLAY Ads广告源进行配置，这里Class Name必须与写入项目中的文件名一致，以Demo为例，这里填写PlayableAdMobAdapter（可自定义，如果没有特殊需要就与示例程序一致即可）。Parameter第一个值为ZPLAY Ads平台申请的应用ID，第二个值为ZPLAY Ads平台申请的广告位ID，注意这两个值的顺序不能更改，且之间只有一个空格，点击“DONE”完成ZPLAY Ads的配置

![img](imgs/014mediationgroupcreate7.png)

注：您在测试中可使用如下ID进行测试，测试ID不会产生收益，应用上线时请使用您申请的正式ID。

| 操作系统 | 广告形式 | App_ID                               | Ad_Unit_id                           |
| ---- | ---- | ------------------------------------ | ------------------------------------ |
| iOS  | 激励视频 | A650AB0D-7BFC-2A81-3066-D3170947C3DA | BAE5DAAC-04A2-2591-D5B0-38FA846E45E7 |
| iOS  | 插屏   | A650AB0D-7BFC-2A81-3066-D3170947C3DA | 0868EBC0-7768-40CA-4226-F9924221C8EB |

h. Ad source列表中可以看到所设置的广告源ZPLAY Ads，点击“SAVE”完成Mediation的配置

![img](imgs/015mediationgroupcreate8.png)

i. 检查第三方广告源是否添加完成，在Apps列表中找到步骤d中选择的应用及广告位，广告位Mediation groups中active数量增加表示广告源添加成功

![img](imgs/016mediationgroupcreate9.png)

## 三 适配类与请求请参考DEMO


