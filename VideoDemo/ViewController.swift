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

class ViewController: UIViewController, UISearchBarDelegate {

    let playerViewController = VideoViewController()

    let searchBar = UISearchBar()

    let videoView = UIView()

    let bottomView = UIView()

    let muteButton = UIButton()

    let playButton = UIButton()

    var url: NSObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 8/255.0, green: 21/255.0, blue: 25/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false

        self.addChildViewController(playerViewController)

        setupBottomView()
        setupSearchBar()
        addActionToButton()
        setupVideoView()

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.text = nil
    }
    func setupVideoView() {

        videoView.frame = CGRect(x: 0, y: 63, width: view.frame.width, height: view.frame.height - 99 )
        view.addSubview(videoView)

    }

    func setupSearchBar() {
        searchBar.frame = CGRect(x: 8, y: 27, width: view.frame.width - 16, height: 30)
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

        playButton.frame = CGRect(x: 0, y: 0, width: 50, height: 19)
        playButton.frame = CGRect(x: 0, y: 0, width: 50, height: 19)
        bottomView.addSubview(playButton)
        bottomView.addSubview(muteButton)

        playButton.translatesAutoresizingMaskIntoConstraints = false
        muteButton.translatesAutoresizingMaskIntoConstraints = false

        playButton.setTitle("Play", for: .normal)
        playButton.titleLabel?.minimumScaleFactor = 5
        playButton.titleLabel?.lineBreakMode = .byTruncatingTail
        playButton.titleLabel?.numberOfLines = 0
        playButton.titleLabel?.adjustsFontSizeToFitWidth = true
        playButton.setTitleColor(.white, for: .normal)
        playButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 19).isActive = true

        muteButton.setTitle("Mute", for: .normal)
        muteButton.setTitleColor(.white, for: .normal)
        muteButton.titleLabel?.minimumScaleFactor = 5
        muteButton.titleLabel?.lineBreakMode = .byTruncatingTail
        muteButton.titleLabel?.numberOfLines = 0
        muteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        muteButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20).isActive = true
        muteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        muteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        muteButton.heightAnchor.constraint(equalToConstant: 19).isActive = true

    }

    func addActionToButton() {

        playButton.addTarget(self, action: #selector(playButtonSelected), for: .touchUpInside)
        muteButton.addTarget(self, action: #selector(muteButtonSelected), for: .touchUpInside)
    }

    @objc func playButtonSelected() {
        if playerViewController.play == true {
            playerViewController.play = false
        } else {
            playerViewController.play = true
        }
    }

    @objc func muteButtonSelected() {
        if playerViewController.mute == false {
            playerViewController.mute = true
        } else {
            playerViewController.mute = false
        }
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

        searchBar.text = nil

        let videoPlayer = AVPlayer(url: inputUrl)

        playerViewController.player = videoPlayer
        playerViewController.view.backgroundColor = .clear
        playerViewController.view.frame = self.videoView.bounds
        self.videoView.addSubview(playerViewController.view)
        playerViewController.player?.play()
        playerViewController.showsPlaybackControls = false

        playButton.setTitle("Pause", for: .normal)

    }

}
