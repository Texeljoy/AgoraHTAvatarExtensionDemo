# Usage of HTAvatar extension
This document provides guidance on integrating and using HONGTU HTAvatar 3D extension (referred to as "HTAvatar extension") in your project, including Android and iOS platforms.

## Technical Principles
HTAvatar extension wraps the core API of HTAvatar from HONGTU. By calling the [setExtensionProperty](https://api-ref.agora.io/en/voice-sdk/android/4.x/API/class_irtcengine.html#api_irtcengine_setextensionproperty) or [setExtensionPropertyWithVendor](https://api-ref.agora.io/en/voice-sdk/android/4.x/API/class_irtcengine.html#api_irtcengine_setextensionproviderproperty) method of the [Agora Video SDK v4.1.1](https://docs.agora.io/en/video-calling/overview/product-overview?platform=android), and passing the specified `key` and `value` parameters, you can quickly integrate the facial 3D effects capabilities provided by HONGTU.

For example, with setExtensionProperty, the value parameter encapsulates all or part of the API parameters of HONGTU in JSON format. Therefore, by providing the corresponding key and value when calling setExtensionProperty, you can invoke the corresponding API of HONGTU to achieve facial 3D effects-related functions. The same applies to setExtensionPropertyWithVendor.

For details on supported keys and values, please refer to [Interface instruction for HTAvatar extension](https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo/blob/master).

## Prerequisites
- For Android development, make sure you meet the following requirements:
  - Android Studio version 4.1 or above.
  - A real device (not an emulator) running Android 6.0 or above.
- For iOS development, make sure you meet the following requirements:
  - Xcode version 10.0 or above.
  - A real device (not a simulator) running iOS 10.0 or above.

## Sample Projects
View complete sample code and project structure on Github.

| Platform | Language | Sample Project |
| :------ | :---------- | :---------------- |
| Android | Java | [AgoraHTAvatorExtensionDemo/Android](https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo.git) |
| iOS | Objective-C | [AgoraHTAvatorExtensionDemo/iOS](https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo.git) |

### Running the Sample Project
**Android**
1. Clone the repository:
```shell
git clone https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo.git
```
2. Download the Android extension package for HTAvatar from [here](https://github.com/Texeljoy/AgoraHTAvatarExtension). After extracting the package, save all the `.aar` files to the `AgoraHTAvatarExtensionDemo/Android/app/libs` path. (Create the `libs` folder if it doesn't exist).
3. Contact Agora platform to obtain the certificate and resource package.
4. Save the required model and prop files from the resource package to the `AgoraHTAvatarExtensionDemo/Android/app/src/main/assets` path. (Create the `assets` folder if it doesn't exist)
5. Open Android Studio and import the sample project `AgoraHTAvatarExtensionDemo/Android`.
6. Sync project with Gradle files.
7. Open `AgoraHTAvatarExtensionDemo/Android/app/src/main/java/io/agora/rte/extension/hteffectar/example/Constants.java` and make the following modifications:
   - Replace `<YOUR_APP_ID>` with your Agora App ID. For acquiring the App ID, please refer to [Get an App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms).
   - You don't need to fill in `mToken` and `mLicenseName` when running the demo.

```java
public interface Constants {
    String mAppId = "<YOUR_APP_ID>";
    String mToken = null;
    String mLicenseName = "<YOUR_LICENSE_NAME>";
}
```

8. Open `AgoraHTAvatarExtensionDemo/Android/app/src/main/java/io/agora/rte/extension/hteffectar/example/HtKey.java` and make the following modifications:
   - Replace `<YOUR_HT_SDK_KEY>` with the test key provided by HTAvatar after purchasing from Agora.

```java
public interface HtKey {
    String HTKey = "<YOUR_HT_SDK_KEY>";
}
```

9. Connect an Android device (not an emulator) and run the project.

**iOS**
1. Clone the repository:
```shell
git clone https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo.git
```
2. Download the iOS extension package for HTAvatar from [here](https://github.com/Texeljoy/AgoraHTAvatarExtension). After extracting the package, save all the `.framework` library files to `AgoraHTAvatarExtensionDemo/iOS/ExtensionExample`.
3. Contact Agora platform to obtain the certificate and resource package.
4. Save the obtained certificate file `HTKey.h` and resource package `HTEffect.bundle` to `AgoraHTAvatarExtensionDemo/iOS/ExtensionExample`.
5. In Terminal, navigate to `AgoraHTAvatarExtensionDemo/iOS` directory and run the following command to install dependencies using CocoaPods:

```
pod install
```

6. Open the project `ExtensionExample.xcworkspace` in Xcode.
7. Open `Config.h` and make the following modifications:
   - Replace `<YOUR_APP_ID>` with your Agora App ID. For acquiring the App ID, please refer to [Get an App ID](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms).
   - You don't need to fill in `token` when running the demo.

```objective-c
NSString *const appID = @"<YOUR_APP_ID>";
NSString *const token = nil;
```

8. Open `AgoraHTAvatarExtensionDemo/iOS/ExtensionExample/HTKey.h` and make the following modification:
   - Replace `<YOUR_HT_SDK_KEY>` with the test key provided by HTAvatar after purchasing from Agora.

```objective-c
NSString *const HTKey = @"<YOUR_HT_SDK_KEY>";
```

9. Connect an iOS device (not a simulator) and run the project.

### Expected Results
Once successfully running, the sample project will be installed on your Android or iOS device.
1. After launching the app, HTAvatar extension is enabled by default. You will see buttons for `enableExtension` and `htARSetModel`.
2. Click on `htARSetModel` to set a 3D AR prop effect. The default setting is a boxing headgear effect. Note that 3D effects do not currently support landscape mode adaptation.

## Integration and Invocation Process
### Preparations
#### Implementing video calling using Agora SDK
HTAvatar extension requires integration with [Agora Video SDK v4.1.1](https://docs.agora.io/en/video-call-4.x/product_live_ng?platform=Android). Please refer to the following documents to integrate Video SDK v4.1.1 and implement basic video calling:
- [Implementing Video Calling (Android)](https://docs.agora.io/en/video-call-4.x/start_call_android_ng?platform=Android#%E5%BB%BA%E7%AB%8B%E9%A1%B9%E7%9B%AE)
- [Implementing Video Calling (iOS)](https://docs.agora.io/en/video-call-4.x/start_call_ios_ng%20?platform=iOS#%E5%88%9B%E5%BB%BA%E9%A1%B9%E7%9B%AE)

#### Purchasing and Activating Extension
Purchase and activate HTAvatar extension in the Agora Dashboard. Make sure to keep the certificate file provided during purchase for subsequent extension integration.

#### Integrating Extension
**Android**
1. Download Android extension package for HTAvatar from [here](https://github.com/Texeljoy/AgoraHTAvatarExtension). After extracting the package, save all the `.aar` files to your project's `/app/libs` folder.

2. Contact Agora to obtain resource packages for HTAvatar extension and save the required model and prop files in your project's `/app/src/main/assets` folder.

3. Open `app/build.gradle` file and add the following line under `dependencies`:

```java
implementation fileTree(dir: "libs", include: ["*.jar", "*.aar"])
```

4. Import the necessary classes:

```java
import io.agora.rtc2.Constants;
import io.agora.rtc2.IMediaExtensionObserver;
import io.agora.rtc2.IRtcEngineEventHandler;
import io.agora.rtc2.RtcEngine;
import io.agora.rtc2.RtcEngineConfig;
import io.agora.rtc2.video.VideoCanvas;
```

5. In the XML layout file corresponding to the Java file for using 3D effects, add:

```java
<RelativeLayout
    android:id="@+id/unityView"
    android:layout_width="1dp"
    android:layout_height="1dp">
</RelativeLayout>
```

6. In the Java file for using 3D effects, add:

```java
unityView = findViewById(R.id.unityView);
unityView.addView(mUnityPlayer);
```

**iOS**
1. Download iOS extension package for HTAvatar from [here](https://github.com/Texeljoy/AgoraHTAvatarExtension).

2. Extract the folder and save all `.framework` library files in your project folder.

3. Save the certificate file `HTKey.h` in your project folder.

4. Contact Agora to obtain resource packages for HTAvatar extension and save `HTEffect.bundle` in your project folder.

5. Add the dynamic library in Xcode to [Embed & Sign](https://help.apple.com/xcode/mac/current/#/dev51a648b07). Make sure that the **Embed** property is set to **Embed & Sign**.

6. Import the necessary header files:

```objective-c
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import "HTKey.h"
```

7. Add the following code at startup in `main.m`:

```objective-c
#import "AppDelegate.h"
#import <HTEffectAR/HTEffectARInterface.h>

int main(int argc, char * argv[]) {
    [[HTEffectARInterface shareInstance] initRuntime:argc argv:argv];
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
```

The following sections describe the invocation process of relevant extension interfaces. For parameter explanations of these interfaces, please refer to [Interface Documentation](https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo/blob/master).

### Step 1: Enable Extension
**Android**
Call `enableExtension` to enable the extension when initializing `RtcEngine`:

```java
private void enableExtension(boolean enabled) {
    mRtcEngine.enableExtension("Texeljoy", "HTAvatar", enabled);
}
```

**iOS**
Call `enableExtensionWithVendor` to enable the extension when initializing `AgoraRtcEngineKit`:

```objective-c
[self.agoraKit enableExtensionWithVendor:@"Texeljoy" extension:@"HTAvatar" enabled:self.enable];
```

### Step 2: Initiate the extension
To initiate the extension, call `setExtensionProperty` (Android) or `setExtensionPropertyWithVendor` (iOS) and pass in the corresponding key and value parameters. The process order is as follows:

**Android**
```java
private void initExtension() {
    // Initialization
    try {
        // Offline authentication mode
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("license", HTKey);
        setExtensionProperty("htARInitOffline", jsonObject.toString());
    } catch (JSONException e) {
        Log.e(TAG, e.toString());
    }
}
```

**iOS**
```objective-c
- (void)initExtension{
    // Resource copy
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                       extension:@"HTAvatar"
                                             key:@"htARCopyResource"
                                           value:[self toJson:@{
                                               @"path":[[NSBundle mainBundle] pathForResource:@"HTEffect" ofType:@"bundle"]
                                             }]];
  
    // Offline authentication mode
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                       extension:@"HTAvatar"
                                             key:@"htARInitOffline"
                                           value:[self toJson:@{
                                               @"license":HTSDKKey
                                             }]];
  
    // (Optional) Set image format
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                       extension:@"HTAvatar"
                                             key:@"htARImageFormat"
                                           value:[self toJson:@{
                                               @"imageFormat":@5
                                             }]];
}
```

### Step 3: Set 3D AR Effects
To set 3D AR effects, call `setExtensionProperty` (Android) or `setExtensionPropertyWithVendor` (iOS) and pass in the corresponding key and value parameters. The process order is as follows:
1. Pass the key `htARRenderEnable` to enable AR effects.
2. Pass the key `htARSetModel` to set an AR model.

You can combine these calls according to your specific requirements. For the corresponding keys and values, please refer to [Interface Documentation](https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo/blob/master).

## Interface Documentation
Please refer to [Interface Instruction](https://github.com/Texeljoy/AgoraHTAvatarExtensionDemo/blob/master) for the parameter explanations of all interfaces related to the extension.