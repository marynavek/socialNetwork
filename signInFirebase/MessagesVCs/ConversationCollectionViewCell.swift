//
//  ConversationCollectionViewCell.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/2/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit



class ConversationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        labelStyle(label: userName, color: .blue)
        roundedImg(image: userImg)
        

    }
    
    func updateCell(name : String, image: UIImage){
        userImg.image = image
        userName.text = name
    }
    
}
