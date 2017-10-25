//
//  Message.swift
//  ChatBubbleTest
//
//  Created by daiki ichikawa on 2017/10/24.
//  Copyright © 2017年 Daiki Ichikawa. All rights reserved.
//

import Foundation

class Message: NSObject {
    var isSender: Bool?
    var text: String?
    var date: NSDate?
    var friend: Friend?
    
    init(text: String, date: NSDate, friend: Friend?, isSender: Bool = false) {
        self.isSender = isSender
        self.text = text
        self.date = date
        self.friend = friend
    }
}
