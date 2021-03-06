//
//  ViewController.swift
//  YLLoginManager
//
//  Created by vsccw on 2017/6/27.
//  Copyright © 2017年 YOLO. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    var message: YLShareMessage!
    
    @IBAction func aacButtonClicked(_ sender: UIButton) {
        YLAudioManager.manager.audioFormat = YLAudioFormat.aac
    }
    @IBAction func wavButtonClicked(_ sender: UIButton) {
        YLAudioManager.manager.audioFormat = YLAudioFormat.wav
    }
    @IBAction func m4aButtonClicked(_ sender: UIButton) {
        YLAudioManager.manager.audioFormat = YLAudioFormat.m4a
    }
    @IBAction func startRecord(_ sender: UIButton) {
        YLAudioManager.manager.startRecord(withFileName: "\(Int(Date().timeIntervalSince1970)).wav") { (error) in
            if error != nil {
                let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
                alert.show()
            }
        }
    }
    
    @IBAction func stopRecordAndPlay(_ sender: UIButton) {
        
        YLAudioManager.manager.stopRecord { (recordPath, duration, error) in
            if error != nil {
                let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
                alert.show()
            }
            if let path = recordPath {
                let type = YLAudioManager.manager.audioType(withPath: path)
                switch type {
                case kAudioFormatMPEG4AAC:
                    print("kAudioFormatMPEG4AAC")
                case kAudioFormatLinearPCM:
                    print("kAudioFormatLinearPCM")
                    
                default:
                    print(AudioFormatID(type))
                }
                
            }
            
            if let path = recordPath {
                YLAudioManager.manager.startPlayAudio(withPath: path, completion: { (error) in
                    if error != nil {
                        let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
                        alert.show()
                    }
                    else {
                        let alert = UIAlertView(title: "", message: "\(String(describing: path))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
                        alert.show()
                    }
                })
            }
        }
    }
    
    @IBAction func startPlay(_ sender: UIButton) {
        
    }
    
    @IBAction func shareToQQButtonClicked(_ sender: UIButton) {
        
        YLShareManager.manager.share(withPlatform: .qq, message: message, success: {
            
        }) { (error) in
            let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }
    }
    
    @IBAction func shareToQQZoneButtonClicked(_ sender: UIButton) {
        YLShareManager.manager.share(withPlatform: .qqZone, message: message, success: {
            
        }) { (error) in
            let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }
    }
    
    @IBAction func shareToWXButtonClicked(_ sender: UIButton) {
        YLShareManager.manager.share(withPlatform: .wechatSesssion, message: message, success: {
            
        }) { (error) in
            let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }
    }

    @IBAction func shareToTimelineButtonClicked(_ sender: UIButton) {
        YLShareManager.manager.share(withPlatform: .wechatTimeline, message: message, success: {
            
        }) { (error) in
            let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }
    }
    
    @IBAction func loginWithWXButtonClicked(_ sender: UIButton) {
        YLAuthManager.manager.authWithPlatform(platform: .wechat, success: { (result) in
            let alert = UIAlertView(title: "", message: "\(String(describing: result))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }) { (error) in
            let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }
    }
    
    @IBAction func loginWithWBButtonClicked(_ sender: UIButton) {
        YLAuthManager.manager.authWithPlatform(platform: .weibo, success: { (result) in
            let alert = UIAlertView(title: "", message: "\(String(describing: result))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }) { (error) in
            let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }
    }
    
    @IBAction func loginWithQQButtonClicked(_ sender: UIButton) {
        YLAuthManager.manager.authWithPlatform(platform: .qq, success: { (result) in
            let alert = UIAlertView(title: "", message: "\(String(describing: result))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }) { (error) in
            let alert = UIAlertView(title: "", message: "\(String(describing: error))", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "取消")
            alert.show()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message = YLShareMessage()
        message.content = "[xxx］约你来同桌连麦玩游戏"
        message.title = "来同桌和我一起连麦玩游戏"
        message.url = "https://vsccw.com"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


