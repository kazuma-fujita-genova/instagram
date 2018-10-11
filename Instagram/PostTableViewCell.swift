//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 藤田和磨 on 2018/10/10.
//  Copyright © 2018年 藤田和磨. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // var parentViewController: UIViewController?
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!

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
    }
}
