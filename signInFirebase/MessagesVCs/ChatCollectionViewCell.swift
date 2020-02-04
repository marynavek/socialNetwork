//
//  ChatCollectionViewCell.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/2/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var receivedMsf: UITextView!
    @IBOutlet weak var sentMsg: UITextView!
    
    //Sent constraint
    @IBOutlet weak var leadingS: NSLayoutConstraint!
    @IBOutlet weak var trailingS: NSLayoutConstraint!
    @IBOutlet weak var bottomS: NSLayoutConstraint!
    @IBOutlet weak var topS: NSLayoutConstraint!
    
    //received conts
    @IBOutlet weak var leadingR: NSLayoutConstraint!
    @IBOutlet weak var topR: NSLayoutConstraint!
    @IBOutlet weak var trailingR: NSLayoutConstraint!
    @IBOutlet weak var bottomR: NSLayoutConstraint!
    
    override func awakeFromNib() {
        testViewStyle(txtView: receivedMsf, color: .blue)
        testViewStyle(txtView: sentMsg, color: .blue)
    }
   
    func updateCell(msgBody: String, status: String){
        if status == "send"{
            sentMsg.isHidden = false
            receivedMsf.isHidden = true
            sentMsg.text = msgBody
        } else {
            receivedMsf.isHidden = false
            sentMsg.isHidden = true
            receivedMsf.text = msgBody
        }
    }
}
