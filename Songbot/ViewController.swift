//
//  ViewController.swift
//  Songbot
//
//  Created by mac on 2017/9/3.
//  Copyright © 2017年 justwithin. All rights reserved.
//

import UIKit
import RealmSwift
import JSQMessagesViewController
import ApiAI

struct User{
    let id: String
    let name: String
 
}


class ViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage] ()
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    let user1 = User (id : "1", name: "Vince")
    let user2 = User (id: "2", name : "bot")
   
    var currentUser: User {
        return user1
    }
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
}


extension ViewController {
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    }
    
}

extension ViewController{
    func addMessage(_senderName:String,_senderID:String,senderMessage: String){
        let message = Message ()
        message.senderID = senderId
        message.senderName = _senderName
        message.senderMessage = senderMessage
        // write to Realm
        let realm = try! Realm ()
        try! realm.write{
            realm.add(message)
            
        }
    }
}


extension ViewController {
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        self.addMessage(_senderName: senderDisplayName, _senderID: senderId, senderMessage: text)
        let message = JSQMessage (senderId:senderId, displayName:senderDisplayName,text: text)
        messages.append (message!)
        
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!)-> NSAttributedString! {
        // V row
        let message = messages [indexPath.item]
        
        let messageUserName = message.senderDisplayName
        return NSAttributedString(string: messageUserName!)
    }
    
     func collectionView(_ collectionView: JSQMessagesViewController,layout collectionCiewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!)-> CGFloat {
        return 15
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!{
    return nil
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!)-> JSQMessageBubbleImageDataSource! {
      
        
        // V row
        let message = messages[indexPath.item]
        if currentUser.id == message.senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
}
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
   
}


