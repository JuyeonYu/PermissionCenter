//
//  PermissionCenter.swift
//  PermissionCenter
//
//  Created by JuYeonYu on 12/15/2021.
//  Copyright (c) 2021 JuYeonYu. All rights reserved.
//

import Foundation
import UIKit
import PhotosUI
import ContactsUI
import CoreLocationUI
import LocalAuthentication

public enum PermissionCenter {
    case video
    case audio
    case gallery
    case notification
    case contact
    case location(type: LocationType)
}

public enum LocationType {
    case always
    case inUse
}

// MARK: common
@available(iOS 10.0, *)
extension PermissionCenter {
    public func action(completion: (() -> Void)?) {
        DispatchQueue.main.async {
            switch self {
            case .video: showVideo(completion: completion)
            case .audio: showAudio(completion: completion)
            case .gallery: showGallery(completion: completion)
            case .notification: showNotification(completion: completion)
            case .contact: showContact(completion: completion)
            case .location(type: let type): showLocation(type: type, completion: completion)
            }
        }
    }
    public func requestPermission(completion: (() -> Void)?) {
        switch self {
        case .video:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted { completion?() }
            }
        case .audio:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                if granted { completion?() }
            }
        case .gallery:
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    if status == .authorized { completion?() }
                }
            } else {
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized { completion?() }
                }
            }
        case .notification:
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted { completion?() }
            }
        case .contact:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if granted { completion?() }
            }
        case .location(type: let type):
            switch type {
            case .always: CLLocationManager().requestAlwaysAuthorization()
            case .inUse: CLLocationManager().requestWhenInUseAuthorization()
            }
        }
    }
    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) else {
                assertionFailure("Not able to open App privacy settings")
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    func showDeniedCase(type: PermissionCenter) {
        var sort: String
        switch type {
        case .video: sort = PermissionCenterString.video
        case .audio: sort = PermissionCenterString.audio
        case .gallery: sort = PermissionCenterString.gallery
        case .notification: sort = PermissionCenterString.notification
        case .contact: sort = PermissionCenterString.contact
        case .location(_): sort = PermissionCenterString.location
        }
        guard let topViewController = UIApplication.getTopViewController() else { return }
        let alert = UIAlertController(title: sort + PermissionCenterString.deniedUserTitle,
                                      message: PermissionCenterString.deniedUserMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: PermissionCenterString.notNow, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: PermissionCenterString.openSettings, style: .default) { _ in
            gotoAppPrivacySettings()
        })
        DispatchQueue.main.async {
            topViewController.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: video
@available(iOS 10.0, *)
extension PermissionCenter {
    func showVideo(completion: (() -> Void)?) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined: requestPermission(completion: completion)
        case .denied: showDeniedCase(type: .video)
        case .authorized: completion?()
        default: break
        }
    }
}

// MARK: audio
@available(iOS 10.0, *)
extension PermissionCenter {
    func showAudio(completion: (() -> Void)?) {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .notDetermined: requestPermission(completion: completion)
        case .denied: showDeniedCase(type: .audio)
        case .authorized: completion?()
        default: break
        }
    }
}

// MARK: gallery
@available(iOS 10.0, *)
extension PermissionCenter {
    func showGallery(completion: (() -> Void)?) {
        var status: PHAuthorizationStatus
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }

        switch status {
        case .notDetermined: requestPermission(completion: completion)
        case .denied: showDeniedCase(type: .gallery)
        case .authorized: completion?()
        case .limited: completion?()
        default: break
        }
    }
}

// MARK: notification
@available(iOS 10.0, *)
extension PermissionCenter {
    func showNotification(completion: (() -> Void)?) {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {
            switch $0.authorizationStatus {
            case .notDetermined: requestPermission(completion: completion)
            case .denied: showDeniedCase(type: .notification)
            case .authorized, .ephemeral: completion?()
            default: break
            }
        })
    }
}

// MARK: contact
@available(iOS 10.0, *)
extension PermissionCenter {
    func showContact(completion: (() -> Void)?) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .notDetermined: requestPermission(completion: completion)
        case .denied: showDeniedCase(type: .contact)
        case .authorized: completion?()
        default: break
        }
    }
}

// MARK: location
@available(iOS 10.0, *)
extension PermissionCenter {
    func showLocation(type: LocationType, completion: (() -> Void)?) {
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = CLLocationManager().authorizationStatus
        } else {
            status =  CLLocationManager.authorizationStatus()
        }
        switch status {
        case .notDetermined: requestPermission(completion: completion)
        case .denied: showDeniedCase(type: .location(type: .always))
        case .authorized, .authorizedAlways, .authorizedWhenInUse: completion?()
        default: break
        }
    }
}

