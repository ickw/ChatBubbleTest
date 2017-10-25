//
//  Friend.swift
//  ChatBubbleTest
//
//  Created by daiki ichikawa on 2017/10/24.
//  Copyright © 2017年 Daiki Ichikawa. All rights reserved.
//

import Foundation

class Friend: NSObject {
    var name: String?
    var profileImageName: String?
    var messages: NSSet?
    
    init(name: String, profileImageName: String, messages: NSSet?) {
        self.name = name
        self.profileImageName = profileImageName
        self.messages = messages
    }
}
