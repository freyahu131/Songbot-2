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
    
    
    let user1 = User (id : "1", name: "Vince")
    let user2 = User (id: "2", name : "bot")
   
    var currentUser: User {
        return user1
    }
}


extension ViewController {
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
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
    
    override    func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!)-> NSAttributedString! {
        
        let message = messages [indexPath.row]
        let messageUserName = message.senderDisplayName
        return NSAttributedString(string: messageUserName!)
    }
    
     func collectionView(_ collectionView: JSQMessagesViewController,layout collectionCiewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!)-> CGFloat {
        return 15
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!{
    return nil
    }
      func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!)-> JSQMessageAvatarImageDataSource!{
      
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        let message = messages [indexPath.row]
        if currentUser.id == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .green) as! JSQMessageAvatarImageDataSource
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: .blue) as! JSQMessageAvatarImageDataSource
        }
}
       func collection(_ collectionView: UICollectionView, numberOfItemSection sectioni: Int)-> Int {
          return messages.count
    }
    
       override func collectionView (_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt: IndexPath!)-> JSQMessageData!{
        return messages[messageDataForItemAt.row]
        }
}


