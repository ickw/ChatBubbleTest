//
//  ChatLogController.swift
//  ChatBubbleTest
//
//  Created by daiki ichikawa on 2017/10/24.
//  Copyright © 2017年 Daiki Ichikawa. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private let marginOffset: CGFloat = 20
    private let bubbleWidthOffset:CGFloat = 16
    private let bleeding: CGFloat = 8
    private let leadingOffset: CGFloat = 48
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        }
    }
    var messages: [Message]?
    
    let messageInputContainerView: UIView = {
        let _view = UIView()
        _view.backgroundColor = .white
        return _view
    }()
    
    let inputTextField: UITextField = {
        let _textField = UITextField()
        _textField.placeholder = "Enter message.."
        return _textField
    }()
    
    lazy var sendButton: UIButton = {
        let _button = UIButton(type: .system)
        _button.setTitle("Send", for: .normal)
        let _titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        _button.setTitleColor(_titleColor, for: .normal)
        _button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        _button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return _button
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "simulate", style: .plain, target: self, action: #selector(simulate))
        
        //
        collectionView?.contentInset.bottom = 10
        collectionView?.contentInset.top = 10
        collectionView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 48)
        collectionView?.backgroundColor = .white
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
        //let nib = UINib(nibName: "ChatLogMessageCell", bundle: nil)
        //collectionView?.register(nib, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        //
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
        view.addConstraintsWithFormat(format: "V:[v0(48)]", views: messageInputContainerView)
        
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        //
        messages = ChatLogControllerHelper.createData()
        
        //
        setupInputComponents()
        
        // 
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
        messageInputContainerView.addConstraintsWithFormat(format: "H:|-8-[v0][v1(60)]|", views: inputTextField, sendButton)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButton)
        
        messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(0.5)]", views: topBorderView)
        
    }
    
    func handleKeyboardNotification(notification: Notification) {
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
           
            let isKeyboardShowing = notification.name == Notification.Name.UIKeyboardWillShow
    
            bottomConstraint?.constant = isKeyboardShowing ? -(keyboardFrame?.height)! : 0
            
            if isKeyboardShowing {
                let collectionViewHeight: CGFloat = UIScreen.main.bounds.size.height - (keyboardFrame?.height)! - 48
                collectionView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: collectionViewHeight)
            } else {
                let collectionViewHeight: CGFloat = UIScreen.main.bounds.size.height - 48
                collectionView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: collectionViewHeight)
            }

            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                
                self?.view.layoutIfNeeded()
                
            }, completion: { [weak self] (isCompleted) in
                
                if isKeyboardShowing {
                    let indexPath = NSIndexPath(item: (self?.messages!.count)! - 1, section: 0)
                    self?.collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
                }

            })
            
        }
    }
    
    func handleSend() {
        print("handle send text \(inputTextField.text!)")
        
        let message = Message(text: inputTextField.text!, date: NSDate().addingTimeInterval(-1 * 60), friend: nil, isSender: true)
        
        messages?.append(message)
        let item = (messages?.count)! - 1
        let indexPath = NSIndexPath(item: item, section: 0)
        collectionView?.insertItems(at: [indexPath as IndexPath])
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
        inputTextField.text = nil
    }
    
    func simulate() {
        let jack = Friend(name: "jack", profileImageName: "jack_profile", messages: nil)
        let message = Message(text: "Here's a text message that was sent a few minutes ago...", date: NSDate().addingTimeInterval(-2 * 60), friend: jack)
        messages?.append(message)
        messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})
        
        if let item = messages?.index(of: message) {
            let indexPath = IndexPath(item: item, section: 0)
            collectionView?.insertItems(at: [indexPath])
        }

    }
    
    
    // MARK: - UICollectionViewControllerDelegate
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        cell.textView.text = messages?[indexPath.item].text
        
        if let message = messages?[indexPath.item], let messageText = messages?[indexPath.item].text {
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14
                )], context: nil)

            if !message.isSender! {
                
                cell.textView.frame = CGRect(x: leadingOffset + bleeding, y: 5, width: estimatedFrame.width + bubbleWidthOffset, height: estimatedFrame.height + marginOffset)
                cell.bubbleView.frame = CGRect(x: leadingOffset - 10, y: 0, width: estimatedFrame.width + bubbleWidthOffset + bleeding + 16, height: estimatedFrame.height + marginOffset + 6)
                
                cell.profileImageView.isHidden = false
                cell.bubbleImageView.image = ChatLogMessageCell.grayBubbleImage
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.textView.textColor = .black
            } else {
                // Outgoing sending message
                
                cell.textView.frame = CGRect(x: view.frame.width - estimatedFrame.width - bubbleWidthOffset - bleeding - 8, y: 5, width: estimatedFrame.width + bubbleWidthOffset, height: estimatedFrame.height + marginOffset)
                cell.bubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - bubbleWidthOffset - bleeding*2 - 10, y: 0, width: estimatedFrame.width + bubbleWidthOffset + bleeding + 10, height: estimatedFrame.height + marginOffset + 6)
                
                cell.profileImageView.isHidden = true
                cell.bubbleImageView.image = ChatLogMessageCell.blueBubbleImage
                cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.textView.textColor = .white
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14
                )], context: nil)
        
            return CGSize(width: view.frame.width, height: estimatedFrame.height + marginOffset)
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
     */

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
