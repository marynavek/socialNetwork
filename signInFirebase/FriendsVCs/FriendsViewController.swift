//
//  FriendsViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import IHProgressHUD

class FriendsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FriendDelDelegate {
    
    var userId: String?
    
    var userName: String?
    
    var userImgName: UIImage?
    

    var isFriend = [Bool]()
    var arrFriends = [UserModel]()

    @IBOutlet weak var colView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllFriends()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllFriends()
        
    }
    
    func getAllFriends(){
        IHProgressHUD.show()
        FireBaseManager.shared.getAllFriends { [weak self] (arrOfFriends) in
            guard let array = try? arrOfFriends else {
                IHProgressHUD.showError(withStatus: "Could not get friends")
                IHProgressHUD.dismiss()
                print("Could not get Friends")
                self!.arrFriends = []
                return
            }
            self?.arrFriends = array
            if self?.arrFriends.count == 0 {
                IHProgressHUD.showInfowithStatus("You don't have any friends yet")
                IHProgressHUD.dismissWithDelay(2)
                print("No Friends were found")
            } else {
                self?.colView.reloadData()
                IHProgressHUD.dismiss()
            }
        }
        IHProgressHUD.dismiss()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFriends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FriendCollectionViewCell
        let friend = arrFriends[indexPath.row]
        let defaultImage = defaultImg(gender: (friend.gender!))
        cell.userId = friend.userId
        cell.userImgName = friend.userImage ?? UIImage(named: "camera")
        cell.userName = (friend.name ?? "") + " " +  (friend.lastName ?? "")
        
        cell.updateCell(img: friend.userImage ?? defaultImg(gender: friend.gender!), name: friend.name! + " " +  friend.lastName!, id: friend.userId!)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var arrayOfPosts = [PostModel]()
        let user = arrFriends[indexPath.row]
        
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "FriendsDetailViewController") as! FriendsDetailViewController
        vc.user = user
        vc.fullName = (user.name ?? "") + " " +  (user.lastName ?? "")
        FireBaseManager.shared.getAllPostsByUserId(id: user.userId!) { (array) in
            guard let postsArr = array else { return }
            arrayOfPosts = postsArr
            DispatchQueue.main.async {
                vc.arrPosts = arrayOfPosts
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:  true)
            }

        }
    }

    func deleteFriend() {
        arrFriends = []
        getAllFriends()
        colView.reloadData()
    }
    
    func openConversation() {
        let st = UIStoryboard(name: "Main", bundle: nil)
                let vc = st.instantiateViewController(withIdentifier: "ChatSharedViewController") as! ChatSharedViewController
                vc.userId = userId!
                vc.userName = userName!
                vc.userImg = userImgName
                vc.getAllMessages(userId: userId!)
        present(vc, animated: true)
    }
}
