//
//  CommentData.swift
//  Instagram
//
//  Created by 藤田和磨 on 2018/10/11.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentData: NSObject {

    var id: String?
    var comment: String?
    var name: String?
    var date: Date?
    
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        self.comment = valueDictionary["comment"] as? String
        
        self.name = valueDictionary["name"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
    }
}
