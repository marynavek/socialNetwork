//
//  Utilities:Defaults.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/4/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import Foundation
import UIKit

func roundedImg(image : UIImageView){
    image.clipsToBounds = true
    image.layer.borderWidth = 3
    image.layer.cornerRadius = image.bounds.width / 2
}

func textFieldStyle(txtField: UITextField, color: UIColor){
    let borderColor = color.cgColor
    txtField.layer.cornerRadius = 5.0
    txtField.clipsToBounds = true
    txtField.layer.borderColor = borderColor
}

func labelStyle(label: UILabel, color: UIColor){
    let borderColor = color.cgColor
    label.layer.cornerRadius = 5.0
    label.clipsToBounds = true
    label.layer.borderColor = borderColor
}

func buttonStyle(button: UIButton, color: UIColor){
    let borderColor = color.cgColor
    button.layer.cornerRadius = 5.0
    button.clipsToBounds = true
    button.layer.borderColor = borderColor
}

func testViewStyle(txtView: UITextView, color: UIColor){
    let borderColor = color.cgColor
    txtView.layer.cornerRadius = 5.0
    txtView.clipsToBounds = true
    txtView.layer.borderColor = borderColor
}

func defaultImg(gender: String) -> UIImage {
    var defaultImg : UIImage = UIImage()
    if gender == "Female" {
        defaultImg = UIImage(named: "femaleI")!
    } else if gender == "Male"{
        defaultImg = UIImage(named: "maleI")!
    }
    return defaultImg
}


class defaultUserModel {
    static let shared = defaultUserModel()
    private init(){}
    
    let userId = "1"
    let email = "email"
    let password = "pass"
    let userImage = defaultImg(gender: "Male")
    let name = "Rayan"
    let lastName = "Reynolds"
    let sport = "skiing"
    let gender = "Male"
    
}

class defaultPostModel {
    static let shared = defaultPostModel()
    private init(){}
    let timestamp = 0.0
    let userId = "1"
    let postBody = "Good Morning"
    let postImage = UIImage(named: "camera")
    let postId = "1"
}

