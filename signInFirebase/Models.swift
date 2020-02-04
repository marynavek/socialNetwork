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



