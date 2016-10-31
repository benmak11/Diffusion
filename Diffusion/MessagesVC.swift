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
    
    
    var userIsTypingRef: FIRDatabaseReference!          // 1
    fileprivate var localTyping = false                 // 2
    var isTyping: Bool{
        get {
            return localTyping
        } set {
            // 3
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    fileprivate func observeTyping() {
        //let typingIndicatorRef = rootRef.child("typingIndicator")
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    fileprivate func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        incomingBubbleImageView = factory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
}
