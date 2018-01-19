//
//  VideoViewController.swift
//  VideoDemo
//
//  Created by cindy on 2018/1/19.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import AVKit

class VideoViewController: AVPlayerViewController {

    @objc dynamic var play: Bool = true

    @objc dynamic var mute: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver(self, forKeyPath: "play", options: .new, context: nil)
        addObserver(self, forKeyPath: "mute", options: .new, context: nil)

    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        guard let parentViewController = parent as? ViewController
            else {
                return
        }

        parentViewController.playButton
        if keyPath == "play" {
            guard let playChange = change,
                  let playOption = playChange[.newKey] as? Bool
                else { return }
            if playOption == true {
                self.player?.play()
                parentViewController.playButton.setTitle("Pause", for: .normal)

            } else {
                self.player?.pause()
                parentViewController.playButton.setTitle("Play", for: .normal)
            }

        } else if keyPath == "mute" {
            guard let muteChange = change,
                let muteOption = muteChange[.newKey] as? Bool
                else { return }
            if muteOption == true {
                self.player?.isMuted = true
                parentViewController.muteButton.setTitle("Unmute", for: .normal)
            } else {
                self.player?.isMuted = false
                parentViewController.muteButton.setTitle("Mute", for: .normal)
            }
        }
    }

    deinit {
        removeObserver(self, forKeyPath: "play")
        removeObserver(self, forKeyPath: "mute")
    }

}
