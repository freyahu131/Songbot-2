//
//  RealmSwiftobject.swift
//  Songbot
//
//  Created by mac on 2017/9/3.
//  Copyright © 2017年 justwithin. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object{
    
    dynamic var senderName = ""
    dynamic var senderID = ""
    dynamic var senderMessage = ""
    
}
