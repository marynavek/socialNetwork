//
//  ChatSharedViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/2/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit

class ChatSharedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let timestamp = NSDate().timeIntervalSince1970
    let date = Date()
    let dateFormatter = DateFormatter()
    var dateId : String = ""
    
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var msgBodyTxt: UITextView!

    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var sendMsgBtn: UIButton!
    
    var userName : String?
    var userImg : UIImage?
    var userId : String?
    var arrMsgs = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.sendSubviewToBack(backgroundImg)
        testViewStyle(txtView: msgBodyTxt, color: .blue)
        labelStyle(label: userNameLbl, color: .blue)
        buttonStyle(button: sendMsgBtn, color: .blue)
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        
        userImage.image = userImg
        userNameLbl.text = userName

        dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
        dateId = dateFormatter.string(from: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getAllMessages(userId: String){
            arrMsgs = [[:]]
            FireBaseManager.shared.getAllMsgsForChat(recepientId: userId) { (arrayOfMsgs) in
                if arrayOfMsgs != nil {
                    self.arrMsgs = arrayOfMsgs!.sorted(by: { ($0["timestamp"] as! Double) < ($1["timestamp"] as! Double) })
                    
                } else {
                    print("No chats yet")
                }
                DispatchQueue.main.async {
                    self.colView.reloadData()
                }
            }
        }
    
    

    @IBAction func sendMsg(_ sender: Any) {
        if let txtBody = msgBodyTxt.text, !(txtBody.isEmpty){
            let msg = MessageModel(timestamp: timestamp, recepientId: userId, date: dateId, msgBody: txtBody, status: "send")
           FireBaseManager.shared.sendMessage(msgModel: msg) { (error) in
                if error != nil {
                    print("Could not send message")
                } else {
                    print("Succesfully sent message")
                    FireBaseManager.shared.getAllMsgsForChat(recepientId: msg.recepientId!) { (arrayOfMsgs) in
                        if arrayOfMsgs != nil {
                            self.arrMsgs = arrayOfMsgs!.sorted(by: { ($0["timestamp"] as! Double) < ($1["timestamp"] as! Double) })
                            DispatchQueue.main.async {
                                self.colView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        self.msgBodyTxt.text = ""
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMsgs.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChatSharedCellCollectionViewCell
           let msg = arrMsgs[indexPath.row]
           var msgBody : String?
           var msgStatus : String?
           let msgM = msg["msgModel"] as! MessageModel?
           if msgM != nil {
               msgBody = msgM?.msgBody
               msgStatus = msgM?.status
            cell.updateCell(msgBody: msgBody!, status: msgStatus!)
           }
           
           
           return cell
       }
    
}
