//
//  FeedViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/26/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var noPostlbl: UILabel!
    var arrPosts = [[String : Any]]()
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var collView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(backgroundView)
        getPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getPosts()
    }

    @objc func getPosts(){
        arrPosts = [[String:Any]]()
        FireBaseManager.shared.getAllPosts{ (posts) in
                    if posts != nil {
                        self.arrPosts = posts!.sorted(by: { ($0["timestamp"] as! Double) > ($1["timestamp"] as! Double) })
                        self.collView.reloadData()
                    } else {
                        print("no posts yet")
                    }
                }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCollectionViewCell
        
        guard indexPath.row < arrPosts.count else { return FeedCollectionViewCell()}
        let post = arrPosts[indexPath.row]
        let userM = post["user"] as! UserModel?
        let postM = post["post"] as! PostModel?
        var postImg : UIImage?
        var postBody : String?
        var date : String?
        var userImg : UIImage?
        var userName : String?
        if userM != nil {
            userImg = userM!.userImage ?? defaultImg(gender: (userM?.gender)!)
            userName = "\(userM!.name ?? "") \(userM!.lastName ?? "")"
        }
        if postM != nil {
            date = postM?.date ?? ""
            if let img = postM?.postImage{
                postImg = img
            } else {
                postImg = nil
            }
            if let body = postM?.postBody {
                postBody = body
            } else {
                postBody = nil
            }
        }
        
        if !(postImg == nil) && !(postBody == nil){
            cell.updateCell(userImg: userImg ?? defaultUserModel.shared.userImage, postImg: postImg!, userName: userName ?? "John", postBody: postBody!, date: date ?? "")
        }
        if !(postImg == nil) && postBody == nil {
            cell.updateCellWOText(userImg: userImg ?? defaultUserModel.shared.userImage, postImg: postImg!, userName: userName ?? defaultUserModel.shared.name, date: date ?? "")
        }
        if postImg == nil && !(postBody == nil) {
            cell.updateCellWOImg(userImg: userImg ?? defaultUserModel.shared.userImage, userName: userName ?? defaultUserModel.shared.name, postBody: postBody!, date: date ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = arrPosts[indexPath.row]
        let userM = post["user"] as! UserModel?
        let postM = post["post"] as! PostModel?
        let postId = post["postId"] as! String?
        var postImg : UIImage?
        var postBody : String?
        var date : String?
        var userImg : UIImage?
        var userName : String?
        var userId : String?
        
        if userM != nil {
            let defaultImage = defaultImg(gender: (userM?.gender!)!)
            userId = userM?.userId!
            userImg = userM!.userImage ?? UIImage(named: "camera")
            userName = "\(userM!.name ?? "") \(userM!.lastName ?? "")"
        }
        if postM != nil {
            postImg = postM?.postImage ?? UIImage()
            postBody = postM?.postBody ?? ""
            date = postM?.date ?? ""
        }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailPostViewController") as! DetailPostViewController
        vc.imgPost = postImg
        vc.imgUser = userImg
        vc.userName = userName
        vc.date = date
        vc.postBody = postBody
        vc.userId = userId
        vc.postId = postId!
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
}
