# PermissionCenter

[![CI Status](https://img.shields.io/travis/JuYeonYu/PermissionCenter.svg?style=flat)](https://travis-ci.org/JuYeonYu/PermissionCenter)
[![Version](https://img.shields.io/cocoapods/v/PermissionCenter.svg?style=flat)](https://cocoapods.org/pods/PermissionCenter)
[![License](https://img.shields.io/cocoapods/l/PermissionCenter.svg?style=flat)](https://cocoapods.org/pods/PermissionCenter)
[![Platform](https://img.shields.io/cocoapods/p/PermissionCenter.svg?style=flat)](https://cocoapods.org/pods/PermissionCenter)

## Purpose of Permission Center

let you free steps for getting permission.

help you focus on the logic.

---
Imagine, now you want to open gallery. There are some inevitable steps.
1. Check the permission
	1. If you can -> action
	2. If you can’t, the status will be
		1. Not determined -> request access permission
			1. If they accept the request -> action
		2. Denied -> induce them to access permission
		3. Limited -> induce them to access all permission or to use more photos

These steps correspond to functions that require all permissions, not just the gallery.

---

## How to use

``` Swift
PermissionCenter.video.action {
    // do something what you want
}
```

if you don't have permission, Permission Center present alert depending on status.

<img src = https://user-images.githubusercontent.com/50232474/146294407-0859b308-9aa6-4058-87b1-1ddd873ec0c4.PNG width = "30%" height = "30%"> <img src = https://user-images.githubusercontent.com/50232474/146294424-b0dbc276-4956-4f91-9e7f-ff5f704732fa.PNG width = "30%" height = "30%"> <img src = https://user-images.githubusercontent.com/50232474/146294429-bc104101-0a3a-42ed-a280-8fb221f43939.PNG width = "30%" height = "30%">

before using, change the message if you want

``` Swift
PermissionCenterString.cancel = "cancel"
PermissionCenterString.allowAllPhotos = "allow all photos"
PermissionCenterString.useCurrentPhoto = "use now"
PermissionCenterString.openSettings = "settings"
PermissionCenterString.notNow = "later"
PermissionCenterString.selectMorePhotos = "add photos"
PermissionCenterString.deniedUserTitle = "alert"
PermissionCenterString.deniedUserMessage = "you had denied the permission.\nyou can change it on settings."
PermissionCenterString.limitedPhotoUserMessage = "access to part of photos."
```

#### don't forget to add your property in plist.

```
<key>NSPhotoLibraryAddUsageDescription</key>
<string></string>
<key>NSPhotoLibraryUsageDescription</key>
<string></string>
<key>NSMicrophoneUsageDescription</key>
<string></string>
<key>NSLocationWhenInUseUsageDescription</key>
<string></string>
<key>NSLocationUsageDescription</key>
<string></string>
<key>NSLocationAlwaysUsageDescription</key>
<string></string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string></string>
<key>NSContactsUsageDescription</key>
<string></string>
<key>NSCameraUsageDescription</key>
<string></string>
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 10.0

## Installation

PermissionCenter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PermissionCenter'
```

## Author

JuYeonYu, remake867@gmail.com

## License

PermissionCenter is available under the MIT license. See the LICENSE file for more info.
