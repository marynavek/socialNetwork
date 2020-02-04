//
//  FriendCollectionViewCell.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import FirebaseAuth
import  FirebaseDatabase

protocol FriendDelDelegate {
    func deleteFriend()
    func openConversation()
    var userId : String? {get set}
    var userName : String? {get set}
    var userImgName : UIImage? {get set}
}

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var friendNameLbl: UILabel!
    
    @IBOutlet weak var msgFriend: UIButton!
    
    @IBOutlet weak var deleteFriend: UIButton!
    
    var delegate : FriendsViewController?
    var userId : String?
    var userName : String?
    var userImgName : UIImage?
    
    var isFriend : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelStyle(label: friendNameLbl, color: .blue)
        buttonStyle(button: msgFriend, color: .blue)
        buttonStyle(button: deleteFriend, color: .blue)
        frame.size.height = 119
        userImg.clipsToBounds = true
        userImg.layer.cornerRadius = userImg.bounds.width / 2
        
    }
    
    func updateCell(img: UIImage, name: String, id: String){
        friendNameLbl.text = name
        userImg.image = img
        userId = id
    }
    
    
    @IBAction func openMsgScreen(_ sender: Any) {
        self.delegate?.userId = userId!
        self.delegate?.userName = userName!
        self.delegate?.userImgName = userImg.image!
        self.delegate?.openConversation() 
    }
    
    
    @IBAction func deleteFriend(_ sender: Any) {
        guard  let id = userId else {
            return
        }
        FireBaseManager.shared.deleteFriend(friendId: id) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "Could not delete a friend")
            } else {
                
                print("Succesfully removed a friend")
            }
            self.delegate?.deleteFriend()
        }
    }
}

