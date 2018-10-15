//
//  CommentViewController.swift
//  Instagram
//
//  Created by 藤田和磨 on 2018/10/11.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class CommentViewController: UIViewController {

    var postData: PostData!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var postButton: UIButton!
    
    @IBAction func handlePostButton(_ sender: Any) {
        
        if let comment = commentTextField.text {
            
            // 表示名が入力されていない時はHUDを出して何もしない
            if comment.isEmpty {
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
                return
            }

            // 辞書を作成してFirebaseに保存する
            let time = Date.timeIntervalSinceReferenceDate
            let name = Auth.auth().currentUser?.displayName
            let commentRef = Database.database().reference().child(Const.CommentPath)
            let commentDic = ["comment": comment, "time": String(time), "name": name!]
            let key = commentRef.childByAutoId().key
            // commentRef.childByAutoId().setValue(commentDic)
            commentRef.child(key).setValue(commentDic)
            
            // 増えたCommentをFirebaseに保存する
            let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
            
            /*
            var comments :[String] = []
            postRef.observe(.value, with: { snapshot in
                let postDict = snapshot.value as! [String : AnyObject]
                // print(postDict)
                if postDict["comments"] != nil {
                    let post_comments = postDict["comments"] as! [String]
                    for comment_key in post_comments {
                        comments.append(comment_key)
                    }
                }
            })
            */
            
            var comments = postData.comments
            comments.append(key)
            let set_values = ["comments": comments]
            postRef.updateChildValues(set_values)
            
            // self.postButton.addTarget(self, action: #selector(PostTableViewCell.addCommentButton(_:forEvent:)), for: .touchUpInside)
            
            // HUDで完了を知らせる
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")

            // キーボードを閉じる
            self.view.endEditing(true)
            // 画面を閉じる
            dismiss(animated: true, completion: nil)

        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
