//
//  Models.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/26/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import Foundation
import UIKit

struct UserModel {
    let userId : String?
    let email : String?
    let password : String?
    var userImage : UIImage?
    var name : String?
    var lastName : String?
    var sport : String?
    var gender : String?
}

struct PostModel {
    let timestamp : Double?
    let userId : String?
    var postBody : String?
    let date : String?
    var postImage : UIImage?
    var postId : String?
}

struct MessageModel {
    let timestamp : Double?
    let recepientId : String?
    let date : String?
    var msgBody : String?
    let status : String?
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
