//
//  ChatLogControllerHelper.swift
//  ChatBubbleTest
//
//  Created by daiki ichikawa on 2017/10/24.
//  Copyright © 2017年 Daiki Ichikawa. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ChatLogControllerHelper {
    

    class func createData() -> [Message] {
        
        // Create Freind
        let jack = Friend(name: "jack", profileImageName: "profile_jack", messages: nil)
        

        // Create Messages
        let message_1 = Message(text: "Hello..", date: NSDate().addingTimeInterval(-6 * 60), friend: jack)
        let message_2 = Message(text: "Hello, how are you? Hope you are having a good morning!", date: NSDate().addingTimeInterval(-5 * 60), friend: jack)
        let message_3 = Message(text: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs.  Please make your purchase with us.", date: NSDate().addingTimeInterval(-4 * 60), friend: jack)
        let message_4 = Message(text: "Yes, totally looking to buy an iPhone 7.", date: NSDate().addingTimeInterval(-3 * 60), friend: jack, isSender: true)
        let message_5 = Message(text: "Totally understand that you want the new iPhone 7, but you'll have to wait until September fot the new release. Sorry but that's just how Apple do things", date: NSDate().addingTimeInterval(-3 * 60), friend: jack)
        let message_6 = Message(text: "Absolutely, I'll just use my gigantic iPhone 7 until then!!!", date: NSDate().addingTimeInterval(-3 * 60), friend: jack, isSender: true)
        let message_7 = Message(text: "Totally understand that you want the new iPhone 7, but you'll have to wait until September fot the new release. Sorry but that's just how Apple do things", date: NSDate().addingTimeInterval(-3 * 60), friend: jack)
        let message_8 = Message(text: "Absolutely, I'll just use my gigantic iPhone 7 until then!!!", date: NSDate().addingTimeInterval(-3 * 60), friend: jack, isSender: true)
        let message_9 = Message(text: "Totally understand that you want the new iPhone 7, but you'll have to wait until September fot the new release. Sorry but that's just how Apple do things", date: NSDate().addingTimeInterval(-3 * 60), friend: jack)
        let message_10 = Message(text: "Absolutely, I'll just use my gigantic iPhone 7 until then!!!", date: NSDate().addingTimeInterval(-2 * 60), friend: jack, isSender: true)
        
        let messages = [message_1, message_2, message_3, message_4, message_5, message_6, message_7, message_8, message_9, message_10]
    
        return messages
    }
    
    

    /*
    private func createMessageWithText(text: String, friend: Friend, minuteAgo: Double, context: NSManagedObjectContext) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minuteAgo * 60)
    }
    */
}
