//
//  PostData.swift
//  Instagram
//
//  Created by 藤田和磨 on 2018/10/10.
//  Copyright © 2018年 藤田和磨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var comment_keys: [String] = []
    var comments: [[String:Any]] = []
    var isLiked: Bool = false
    
    init(snapshot: DataSnapshot, myId: String) {
        
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
        
        if let comments = valueDictionary["comments"] as? [[String:Any]] {
            self.comments = comments
        }

        /*
        if let comment_keys = valueDictionary["comments"] as? [String] {
            self.comment_keys = comment_keys
        }
        
        super.init()
        
        if self.comment_keys.count > 0 {
            for comment_key in comment_keys {
                let commentRef = Database.database().reference().child(Const.CommentPath).child(comment_key)
                commentRef.observe(.value, with: { snapshot in
                // commentRef.observeSingleEvent(of: .value, with: { snapshot in
                    let commentDict = snapshot.value as! [String : AnyObject]
                    let comments :[String:String] = ["name":commentDict["name"] as! String, "comment":commentDict["comment"] as! String]
                    self.comments.append(comments)
                })
            }
        }
        */
        
    }
}
