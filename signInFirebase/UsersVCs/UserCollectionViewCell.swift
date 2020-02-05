//
//  UserCollectionViewCell.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

protocol FriendsDelegate {
    func addFriend()
}



class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fullNameLbl: UILabel!
    
    @IBOutlet weak var addFriendBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var sportLbl: UILabel!
    
    var isFriend : Bool?
    
    var userId : String?
    var delegate : UsersViewController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelStyle(label: fullNameLbl, color: .blue)
        labelStyle(label: sportLbl, color: .blue)
        buttonStyle(button: addFriendBtn, color: .blue)
        frame.size.height = 119
        roundedImg(image: userImg)

    }
    
    func updateCell(img : UIImage, name: String, sport: String, id: String){
        fullNameLbl.text = name
        sportLbl.text = sport
        userImg.image = img
        userId = id
        
    }
    
    
    
    
    @IBAction func addFriend(_ sender: Any) {
        guard let id = userId else { return }
        FireBaseManager.shared.addFriend(friendId: id) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "Could not add a friend")
            } else {
                
                print("Succesfully added a friend")
            }
            self.delegate?.addFriend()
        }
    }
    
}
