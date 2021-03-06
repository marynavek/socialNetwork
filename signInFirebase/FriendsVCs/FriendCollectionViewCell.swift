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
import IHProgressHUD

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
        roundedImg(image: userImg)
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
        IHProgressHUD.show()
        guard  let id = userId else {
            return
        }
        FireBaseManager.shared.deleteFriend(friendId: id) { (error) in
            if error != nil {
                IHProgressHUD.showError(withStatus: "Could not delete a friend")
                print(error?.localizedDescription ?? "Could not delete a friend")
            } else {
                IHProgressHUD.showSuccesswithStatus("Successfully removed a friend")
                print("Succesfully removed a friend")
            }
            IHProgressHUD.dismiss()
            self.delegate?.deleteFriend()
        }
    }
}

