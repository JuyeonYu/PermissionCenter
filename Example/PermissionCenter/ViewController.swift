//
//  ViewController.swift
//  PermissionCenter
//
//  Created by JuYeonYu on 12/15/2021.
//  Copyright (c) 2021 JuYeonYu. All rights reserved.
//

import UIKit
import PermissionCenter

class ViewController: UIViewController {
    @IBAction func onVideo(_ sender: Any) {
        PermissionCenterString.notNow = "later"
        PermissionCenter.video.action {
            let alert = UIAlertController(title: "video", message: "has granted callback", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func onAudio(_ sender: Any) {
        PermissionCenter.audio.action {
            let alert = UIAlertController(title: "video", message: "has granted callback", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }        }
    }
    @IBAction func onGallery(_ sender: Any) {
        PermissionCenter.gallery.action {
            let alert = UIAlertController(title: "video", message: "has granted callback", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func onNotification(_ sender: Any) {
        PermissionCenter.notification.action {
            let alert = UIAlertController(title: "notification", message: "has granted callback", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func onContact(_ sender: Any) {
        PermissionCenter.contact.action {
            let alert = UIAlertController(title: "contact", message: "has granted callback", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func onLocation(_ sender: Any) {
        PermissionCenter.location(type: .always).action {
            let alert = UIAlertController(title: "location", message: "has granted callback", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

