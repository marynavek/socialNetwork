//
//  ConverstaionsViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/2/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit

class ConverstaionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrUserConvers = [[String : Any]]()
    
    @IBOutlet weak var backgroungImg: UIImageView!
    @IBOutlet weak var conversationColView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(backgroungImg)
        getUsersInfoWithConversations()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsersInfoWithConversations()
    }
    
    func getUsersInfoWithConversations(){
        arrUserConvers = [[String : Any]]()
        FireBaseManager.shared.getAllConversationsForUser { (arrOfUsersInfo) in
            if let array = arrOfUsersInfo {
                self.arrUserConvers = array
                self.conversationColView.reloadData()
            }
        }
    }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUserConvers.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ConversationCollectionViewCell
        let user = arrUserConvers[indexPath.row]
        var userImg : UIImage?
        let userName = "\(user["name"] as! String ?? "") \(user["lastName"] as! String ?? "")"
        if let image = user["userImg"] as? UIImage {
            userImg = image
        }
         else {
            userImg = UIImage(named: "camera")
        }
        
        cell.updateCell(name: userName, image: userImg!)
        return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = arrUserConvers[indexPath.row]
        let st = UIStoryboard(name: "Main", bundle: nil)
                let vc = st.instantiateViewController(withIdentifier: "ChatSharedViewController") as! ChatSharedViewController
        vc.userId = user["userId"] as? String
        vc.userName = "\(user["name"] as? String ?? "") \(user["lastName"] as? String ?? "")"
        if let image = user["userImg"] as? UIImage {
            vc.userImg = image ?? UIImage(named: "camera")
        }
//        } else {
//            vc.userImg = defaultImg(gender: user["gender"] as! String)
//        }
        vc.getAllMessages(userId: ((user["userId"] as? String)!))
        //        vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
        
    }

}
