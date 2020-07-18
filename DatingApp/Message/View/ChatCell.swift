//
//  ChatCell.swift
//  DatingApp
//
//  Created by Vy Le on 2/23/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ChatCell : UICollectionViewCell {
    // MARK: - Properties
    private let activityIndicatorView = CustomActivityIndicatorView()
    let playButton = CustomButton(imageName: "play.fill", size: 20, color: UIColor.white, cornerRadius: nil, shadowColor: nil, backgroundColor: .clear)
    private let containerView = CustomContainerView(cornerRadius: 16, backgroundColor: UIColor.amour)
    let profileImageView = CircleImageView(imageName: "user")
    var messageImageView = CustomImageView(imageName: "user", cornerRadius: 16)
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.boldSystemFont(ofSize: Constants.textSize)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = UIColor.white
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var isPlaying: Bool!
    var containerViewWidthAnchor: NSLayoutConstraint!
    private var containerViewRightAnchor: NSLayoutConstraint!
    private var containerViewLeftAnchor: NSLayoutConstraint!
    var tapDelegate: ZoomTapDelegate?
    var viewModel: MessageViewModel! {
        didSet {
            profileImageView.setImage(image: viewModel.userMainImage)
            textView.text = viewModel.text
//            setUpMessageRelationshipStyle()
//            setUpMessageType()
            if let image = viewModel.image {
                messageImageView.setImage(image: image)
            }
            playButton.isHidden = viewModel.videoUrl == nil
        }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        isPlaying = false
        playButton.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        activityIndicatorView.stopAnimating()
    }
    
    //MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
        addTapGesture()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        addSubview(textView)
        addSubview(messageImageView)
        addSubview(profileImageView)
        messageImageView.addSubview(playButton)
        messageImageView.addSubview(activityIndicatorView)
        messageImageView.bringSubviewToFront(playButton)
        messageImageView.sendSubviewToBack(activityIndicatorView)
    }
    
    private func setupConstraints() {
        containerViewRightAnchor = containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        containerViewLeftAnchor = containerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        containerViewWidthAnchor = containerView.widthAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        NSLayoutConstraint.activate([
            containerViewRightAnchor,
            containerViewLeftAnchor,
            containerViewWidthAnchor,
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            textView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            messageImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            messageImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            messageImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            messageImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 50),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUpMessageRelationshipStyle(style: RelationshipType) {
        switch style {
        case .currentUser:
            containerView.backgroundColor = UIColor.amour
            textView.textColor = UIColor.white
            containerViewRightAnchor.isActive = true
            containerViewLeftAnchor.isActive = false
            profileImageView.isHidden = true
        case .otherPerson:
            containerView.backgroundColor = UIColor.inputContainerColor
            textView.textColor = UIColor.black
            containerViewRightAnchor.isActive = false
            containerViewLeftAnchor.isActive = true
            profileImageView.isHidden = false
        }
    }
    
    func setUpMessageType(messageType: MessageType) {
        switch messageType {
        case .text:
            //containerViewWidthAnchor.constant = textView.estimatedFrameForText(text: viewModel.text).width + 36
            textView.isHidden = false
            messageImageView.isHidden = true
            playButton.isHidden = true
        case .image:
            containerViewWidthAnchor.constant = 200
            textView.isHidden = true
            messageImageView.isHidden = false
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.cancelsTouchesInView = false
        messageImageView.isUserInteractionEnabled = true
        messageImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: Actions
    @objc private func handleTapGesture() {
//        if viewModel?.videoUrl != nil {
//            if isPlaying {
//                player?.pause()
//                playButton.isHidden = false
//            } else if !isPlaying {
//                player?.play()
//                playButton.isHidden = true
//            }
//            isPlaying = !isPlaying
//        } else {
//            tapDelegate?.didTap(on: messageImageView)
//        }
    }
    
    @objc private func handlePlay() {
//        if let videoUrlString = viewModel?.videoUrl, let url = URL(string: videoUrlString) {
//            player = AVPlayer(url: url)
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer?.frame = containerView.bounds
//            messageImageView.layer.insertSublayer(playerLayer!, below: playButton.layer)
//            player?.play()
//            activityIndicatorView.startAnimating()
//            playButton.isHidden = true
//            isPlaying = true
//        }
    }
}
