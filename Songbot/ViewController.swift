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


