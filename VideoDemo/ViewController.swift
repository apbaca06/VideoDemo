//
//  ViewController.swift
//  VideoDemo
//
//  Created by cindy on 2018/1/19.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

//@objcMembers class VideoControl: NSObject {
//    
////    let url: URL
//    
//    var play: Bool = true
//    
//    @objc dynamic var play: Bool
//    
//    var mute: Bool = false
//    
//     @objc dynamic var mute: Bool
//    
////    init(_ url: URL) {
////        self.url = url
////    }
//
//}

class ViewController: UIViewController, UISearchBarDelegate {

    let playerViewController = VideoViewController()

    let searchBar = UISearchBar()

    let bottomView = UIView()

    let muteButton = UIButton()

    let playButton = UIButton()

    let video = VideoControl()

    var url: NSObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 8/255.0, green: 21/255.0, blue: 25/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        setupBottomView()
        setupSearchBar()
        addActionToButton()
        video.observ

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
        searchBar.text = nil
    }

    func setupSearchBar() {
        searchBar.frame = CGRect(x: 8, y: 20, width: view.frame.width - 16, height: 30)
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.placeholder = "Enter URL of video"
        searchBar.tintColor = UIColor(red: 122/255.0, green: 121/255.0, blue: 123/255.0, alpha: 1)
        searchBar.returnKeyType = .done
        searchBar.delegate = self
//        let offset = UIOffset(horizontal: (searchBar.frame.width - placeholderWidth) / 2, vertical: 0)
//        searchBar.setPositionAdjustment(offset, for: .search)
        view.addSubview(searchBar)
    }

    func setupBottomView() {
        bottomView.frame = CGRect(x: 0, y: view.frame.height - 44, width: self.view.frame.width, height: 44)
        bottomView.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.6)
        view.addSubview(bottomView)

        playButton.frame = CGRect(x: 0, y: 0, width: 39, height: 19)
        playButton.frame = CGRect(x: 0, y: 0, width: 39, height: 19)
        bottomView.addSubview(playButton)
        bottomView.addSubview(muteButton)

        playButton.translatesAutoresizingMaskIntoConstraints = false
        muteButton.translatesAutoresizingMaskIntoConstraints = false

        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 39).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 19).isActive = true

        muteButton.setTitle("Mute", for: .normal)
        muteButton.setTitleColor(.white, for: .normal)

        muteButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        muteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        muteButton.widthAnchor.constraint(equalToConstant: 39).isActive = true
        muteButton.heightAnchor.constraint(equalToConstant: 19).isActive = true

    }

    func addActionToButton() {

        playButton.addTarget(self, action: #selector(playButtonSelected), for: .touchUpInside)
        muteButton.addTarget(self, action: <#T##Selector#>, for: .touchUpInside)
    }

    @objc func playButtonSelected() {

        video.play = false
        playerViewController.player?.pause()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {

        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let urlString = searchBar.text?.lowercased(),
              let url = URL(string: urlString)
            else {
                let alert = UIAlertController(title: "Unable to transform as URL", message: "please insert correct URL", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                return }

        loadVideo(inputUrl: url)

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }

    func loadVideo(inputUrl: URL) {

        let videoPlayer = AVPlayer(url: inputUrl)

        playerViewController.player = videoPlayer
        playerViewController.view.backgroundColor = .clear
//        playerViewController.showsPlaybackControls = false

        self.present(playerViewController, animated: false, completion: playerViewController.player?.play)

    }

    func keyboardWillDismiss() {
        if searchBar.text != nil {

        }
    }

}
