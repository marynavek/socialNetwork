//
//  FeedCollectionViewCell.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var postLBl: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var postImg: UIImageView!
    
    var postId : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelStyle(label: userNameLbl, color: .blue)
        labelStyle(label: postLBl, color: .blue)
        labelStyle(label: dateLbl, color: .blue)
        
        userImg.layer.borderWidth = 3
        userImg.layer.cornerRadius = userImg.frame.size.width / 2
        userImg.clipsToBounds = true
        postImg.clipsToBounds = true
    }
    
    func updateCellWOImg(userImg: UIImage, userName: String, postBody: String, date: String){
        self.userImg.image = userImg
        self.postImg.isHidden = true
        self.postLBl.isHidden = false
        self.userNameLbl.text = userName
        self.postLBl.text = postBody
        self.dateLbl.text = date
    }
    func updateCellWOText(userImg: UIImage, postImg: UIImage, userName: String, date: String){
        self.userImg.image = userImg
        self.postImg.image = postImg
        self.userNameLbl.text = userName
        self.postLBl.isHidden = true
        self.postImg.isHidden = false
        self.dateLbl.text = date
    }
    func updateCell(userImg: UIImage, postImg: UIImage, userName: String, postBody: String, date: String){
        self.postImg.isHidden = false
        self.postLBl.isHidden = false
        self.userImg.image = userImg
        self.postImg.image = postImg
        self.userNameLbl.text = userName
        self.postLBl.text = postBody
        self.dateLbl.text = date
    }
}
