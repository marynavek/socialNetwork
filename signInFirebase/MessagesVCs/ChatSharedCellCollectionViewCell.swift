//
//  ChatSharedCellCollectionViewCell.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/2/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit

class ChatSharedCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var receivedMsgTxt: UITextView!
    @IBOutlet weak var sentMsgTxt: UITextView!
    

    override func awakeFromNib() {
           testViewStyle(txtView: receivedMsgTxt, color: .blue)
        testViewStyle(txtView: sentMsgTxt, color: .blue)
        
    }
    func updateCell(msgBody: String, status: String){
        if status == "send"{
            receivedMsgTxt.isHidden = true
            sentMsgTxt.isHidden = false
            sentMsgTxt.text = msgBody
        }
        if status == "received"{
            sentMsgTxt.isHidden = true
            receivedMsgTxt.isHidden = false
            receivedMsgTxt.text = msgBody
        }
    }
}
