//
//  ChatLogMessageCell.swift
//  ChatBubbleTest
//
//  Created by daiki ichikawa on 2017/10/25.
//  Copyright © 2017年 Daiki Ichikawa. All rights reserved.
//

import UIKit

class ChatLogMessageCell: UICollectionViewCell {
    
    let textView: UITextView = {
        let _textView = UITextView()
        _textView.isEditable = false
        _textView.isUserInteractionEnabled = false
        
        _textView.font = UIFont.systemFont(ofSize: 14)
        _textView.text = "Sample Message"
        _textView.backgroundColor = .clear
        return _textView
    }()
    
    let bubbleView: UIView = {
        let _view = UIView()
        _view.layer.cornerRadius = 15
        _view.layer.masksToBounds = true
        return _view
    }()
    
    let profileImageView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.contentMode = .scaleAspectFill
        _imageView.layer.cornerRadius = 15
        _imageView.layer.masksToBounds = true
        _imageView.backgroundColor = .red
        
        return _imageView
    }()
    
    static let grayBubbleImage = #imageLiteral(resourceName: "bubble_gray").resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = #imageLiteral(resourceName: "bubble_blue").resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = ChatLogMessageCell.grayBubbleImage
        _imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return _imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profileImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(30)]|", views: profileImageView)
        
        bubbleView.addSubview(bubbleImageView)
        bubbleView.addConstraintsWithFormat(format: "H:|[v0]|", views: bubbleImageView)
        bubbleView.addConstraintsWithFormat(format: "V:|[v0]|", views: bubbleImageView)
        
    }
    
}
