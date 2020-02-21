//
//  UsersViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import IHProgressHUD

class UsersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FriendsDelegate {
    
    var isFriend = [Bool]()
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var collView: UICollectionView!
    
    
    var arrUsers = [UserModel]()
    var arrOfFriends = [String]()
    
    
    override func viewDidLoad() {
        view.sendSubviewToBack(backgroundImg)
        super.viewDidLoad()
        collView.delegate = self
        collView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getAllUsers()
        getAllFriends()
        print(arrUsers.count)
    }
    
    func getAllUsers(){
        arrOfFriends = []
        IHProgressHUD.show()
        FireBaseManager.shared.getAllUsers { [weak self] (arrOfUsers) in
            guard let users = try? arrOfUsers else {
                IHProgressHUD.showError(withStatus: "Could not get users")
                IHProgressHUD.dismissWithDelay(1)
                print("Could not get users")
                return
            }
            self?.arrUsers = users
            print(self!.arrUsers.count)
            if self?.arrUsers.count == 0 {
                IHProgressHUD.showInfowithStatus("There is no users yet")
                IHProgressHUD.dismissWithDelay(1)
                print("No users were found")
            } else {
                IHProgressHUD.dismiss()
                self?.collView.reloadData()
            }
        }
    }
    
    func getAllFriends(){
        FireBaseManager.shared.getAllFriends { [weak self] (array) in
            guard let friends = try? array else {
                return
            }
            for friend in friends {
                if let friendId = friend.userId {
                    self?.arrOfFriends.append(friendId)
                }
            }
            DispatchQueue.main.async {
                self?.collView.reloadData()
            }
        }
    }
    
    func checkIfFriend(_ uid: String) -> Bool {
        if arrOfFriends.contains(uid){
            return true
        }
        return false
    }
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserCollectionViewCell
        
        let user = arrUsers[indexPath.row]
        
        
        cell.updateCell(img: (user.userImage ?? defaultUserModel.shared.userImage), name: (user.name ?? "") + " " +  (user.lastName ?? ""), sport: (user.sport ?? defaultUserModel.shared.sport), id: (user.userId ?? defaultUserModel.shared.userId))
        
        cell.addFriendBtn.isHidden = checkIfFriend(user.userId!)
        cell.delegate = self
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var arrayOfPosts = [PostModel]()
        let user = arrUsers[indexPath.row]
        
        
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
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
    func addFriend() {
        getAllFriends()
    }
    
    
    
}
