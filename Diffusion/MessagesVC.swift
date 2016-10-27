//
//  MessagesVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/18/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import Messages
import Firebase
import JSQMessagesViewController

class MessagesVC: JSQMessagesViewController {
    
    // MARK: Properties
    var messages = [JSQMessage]()
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    
    var userIsTypingRef: FIRDatabaseReference!
    fileprivate var localTyping = false
    var isTyping: Bool{
        get {
            return localTyping
        } set {
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
}
