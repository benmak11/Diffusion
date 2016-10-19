//
//  MessagesVC.swift
//  Diffusion
//
//  Created by Baynham Makusha on 10/18/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import UIKit
import Messages

class MessagesVC: MSMessagesAppViewController {
    
    // MARK: Properties
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        
        // Present the view controller appropriate for the conversation and presentation style.
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    // MARK: MSMessagesAppViewController
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }
        
        // Present the view controller appropriate for the conversation and presentation style.
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    // MARK: Child view controller presentation
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        // Determine the controller to present.
        let controller = UIViewController()
        /*if presentationStyle == .compact {
            // Show a list of previously created ice creams.
            //controller = instantiateIceCreamsController()
        }
        else {
            /*
             Parse an `IceCream` from the conversation's `selectedMessage` or
             create a new `IceCream` if there isn't one associated with the message.
             */
            let iceCream = IceCream(message: conversation.selectedMessage) ?? IceCream()
            
            if iceCream.isComplete {
                //controller = instantiateCompletedIceCreamController(with: iceCream)
            }
            else {
                //controller = instantiateBuildIceCreamController(with: iceCream)
            }
        }*/
        
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }

}
