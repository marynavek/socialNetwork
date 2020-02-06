//
//  FeedCollectionViewCell.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    
    //constraints
    
    @IBOutlet weak var lblToImg: NSLayoutConstraint!
    
    @IBOutlet weak var lblTolbl: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    
    @IBOutlet weak var postTxt : UITextView!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var postImg: UIImageView!
    
    var postId : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        lblToImg.constant = 0
//        lblTolbl.constant = 0
        testViewStyle(txtView: postTxt, color: .blue)
        labelStyle(label: userNameLbl, color: .blue)
        labelStyle(label: dateLbl, color: .blue)
        
        roundedImg(image: userImg)
        postImg.clipsToBounds = true
        
        let fixedWidth = postTxt.frame.size.width
               let newSize = postTxt.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
               postTxt.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    }
    
    func updateCellWOImg(userImg: UIImage, userName: String, postBody: String, date: String){
        self.userImg.image = userImg
        self.userNameLbl.text = userName
        self.postTxt.text = postBody
        self.dateLbl.text = date
        
        self.postImg.isHidden = true
        self.postTxt.isHidden = false
        
    }
    func updateCellWOText(userImg: UIImage, postImg: UIImage, userName: String, date: String){
        self.userImg.image = userImg
        self.postImg.image = postImg
        self.userNameLbl.text = userName
        self.dateLbl.text = date
        
        self.postImg.isHidden = true
        self.postTxt.isHidden = false
    }
    func updateCell(userImg: UIImage, postImg: UIImage, userName: String, postBody: String, date: String){
        self.userImg.image = userImg
        self.postImg.image = postImg
        self.userNameLbl.text = userName
        self.postTxt.text = postBody
        self.dateLbl.text = date
        
        self.postImg.isHidden = false
        self.postTxt.isHidden = false
    }
}
