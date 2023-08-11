# Instruction of HTAvatar extension interface
## Agora SDK API Reference
This section provides reference documentation for extension related APIs in the Agora SDK.
### Java
- [addExtension](https://docs.agora.io/en/video-call-4.x/API%20Reference/java_ng/API/api_irtcengine_addextension.html) in the `RtcEngineConfig` class
- [enableExtension](https://api-ref.agora.io/en/voice-sdk/android/4.x/API/class_irtcengine.html#api_irtcengine_enableextension) in the `RtcEngine` class
- [setExtensionProperty](https://api-ref.agora.io/en/voice-sdk/android/4.x/API/class_irtcengine.html#api_irtcengine_setextensionproperty) in the `RtcEngine` class
- [onEvent](https://api-ref.agora.io/en/voice-sdk/android/4.x/API/class_imediaextensionobserver.html#callback_irtcengineeventhandler_onextensionevent) in the `IMediaExtensionObserver` class
### Objective-C
- [enableExtensionWithVendor](https://api-ref.agora.io/en/voice-sdk/ios/4.x/documentation/agorartckit/agorartcenginekit/enableextension(withvendor:extension:enabled:)) in the `AgoraRtcEngineKit` class
- [setExtensionPropertyWithVendor](https://api-ref.agora.io/en/voice-sdk/ios/4.x/documentation/agorartckit/agorartcenginekit/setextensionpropertywithvendor(_:extension:extensioninfo:key:value:)) in the `AgoraRtcEngineKit` class
- [onEvent](https://api-ref.agora.io/en/voice-sdk/ios/4.x/documentation/agorartckit/agoramediafiltereventdelegate/onevent(_:extension:key:value:)) in the `AgoraMediaFilterEventDelegate` class
## Overview of Extesnion Keys
### Method Keys
When calling the `setExtensionProperty`/`setExtensionPropertyWithVendor` method in the Agora SDK, you can pass the following keys and corresponding functionalities:
### Initialization
| Key for setExtensionProperty/setExtensionPropertyWithVendor method | Description |
| :---- | :---- |
| [htARInitOffline](#htARInitOffline) | Initialization for offline AR authentication. |
### Destruction
| Key for setExtensionProperty/setExtensionPropertyWithVendor method | Description |
| :---- | :---- |
| [htARReleaseBufferRenderer](#htARReleaseBufferRenderer) | Resource release function. |
### Functional Interfaces
| Key for setExtensionProperty/setExtensionPropertyWithVendor method | Description |
| :---- | :---- |
| [htARRenderEnable](#htARRenderEnable)| Function to enable/disable AR effects. |
| [htARSetModel](#htARSetModel) | Function to switch AR models. |
| [htARMirror](#htARMirror) | Function to set whether the image has a mirror effect. |
| [htARImageFormat](#htARImageFormat) | Function to set the image format. |
| [htARRotation](#htARRotation) | Function to set the image rotation angle. |
| [htARMaxFaces](#htARMaxFaces) | Function to set the maximum supported number of faces. |
| [htARCopyResource](#htARCopyResource)| Function to copy resource paths to the sandbox. |
### Value Explanation for Method Keys
<a id="htARInitOffline"> </a>
### htARInitOffline
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `license` | String value, representing the license key for offline AR authentication. |
<a id="htARReleaseBufferRenderer"> </a>
### htARReleaseBufferRenderer
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `enable` | BOOL value, indicating whether to release resources. |
<a id="htARRenderEnable"> </a>
### htARRenderEnable
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `enable` | BOOL value, indicating whether to enable AR effects. |
<a id="htARSetModel"> </a>
### htARSetModel
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `name` | String value, representing the name of the model. |
<a id="htARMirror"> </a>
### htARMirror
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `isMirror` | BOOL value, indicating whether to enable mirror display for prop effects. Default is true. |
<a id="htARImageFormat"> </a>
### htARImageFormat
The value includes the following parameters:
| Value Parameter| Description |
| :------- | :---- |
| `imageFormat` | Int value, representing the image format enum. For specific values, please refer to [HTEARImageFormat](https://github.com/Texeljoy/AgoraHTAvatarExtension/blob/master/iOS/ALL_ARCHITECTURE/Release/HTEffectAR.framework/Headers/HTEffectARInterface.h). |
<a id="htARRotation"> </a>
### htARRotation
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `rotation` | Int value, representing the image rotation angle enum. For specific values, please refer to [HTEAROrientation](https://github.com/Texeljoy/AgoraHTAvatarExtension/blob/master/iOS/ALL_ARCHITECTURE/Release/HTEffectAR.framework/Headers/HTEffectARInterface.h). |
<a id="htARMaxFaces"> </a>
### htARMaxFaces
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `maxFaces` | Int value, representing the maximum number of supported faces. Valid range is [1, 5]. |
<a id="htARCopyResource"> </a>
### htARCopyResource
The value includes the following parameters:
| Value Parameter | Description |
| :------- | :---- |
| `path` | String value, representing the path to be copied to the sandbox. |