//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 藤田和磨 on 2018/10/10.
//  Copyright © 2018年 藤田和磨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVGKit

class PostTableViewCell: UITableViewCell {

    // var parentViewController: UIViewController?
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    
    var isComment : Bool = false

/*
    @IBAction func handleCommentButton(_ sender: Any) {
        // コメントの画面を開く
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let commentViewController = storyboard.instantiateViewController(withIdentifier: "Comment") as! CommentViewController
        self.parentViewController?.present(commentViewController, animated: true, completion: nil)
    }
  */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let svgImage = SVGKImage(named: "comment")
        svgImage?.size = commentButton.bounds.size
        self.commentButton.setImage(svgImage?.uiImage, for: .normal)
        self.commentButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
        
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        
        // if self.isComment && !postData.comments.isEmpty {
        if !postData.comments.isEmpty {
            for comment_key in postData.comments {
                let commentRef = Database.database().reference().child(Const.CommentPath).child(comment_key)
                //commentRef.observe(.value, with: { snapshot in
                commentRef.observeSingleEvent(of: .value, with: { snapshot in
                    let commentDict = snapshot.value as! [String : AnyObject]
                    let commenter = commentDict["name"]
                    let comment = commentDict["comment"]
                    self.commentLabel.text?.append("\(commenter!) : \(comment!)\n")
                })
            }
        }
        else {
            self.commentLabel.text = "0件"
        }
        
        /*
        if postData.comment == nil || postData.comment!.isEmpty {
            self.commentLabel.text = "0件"
        }
        else {
            self.commentLabel.text = postData.comment
        }
         */
    }
    
    /*
    @objc func addCommentButton(_ sender: UIButton, forEvent event: UIEvent) {
        self.isComment = true
    }
     */
}
