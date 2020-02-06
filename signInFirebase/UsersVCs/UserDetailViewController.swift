//
//  UserDetailViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/31/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import  IHProgressHUD

class UserDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var postsTbl: UITableView!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    
    var userImage : UIImage?
    var arrPosts = [PostModel]()
    var fullName : String?
    var user : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(backgroundImg)
        userImg.layer.borderWidth = 3
        userImg.layer.cornerRadius = userImg.frame.size.width / 2
        userImg.clipsToBounds = true

        labelStyle(label: userName, color: .blue)
        buttonStyle(button: msgBtn, color: .blue)
        buttonStyle(button: backBtn, color: .blue)
                let defaultImage = defaultImg(gender: (user?.gender ?? defaultUserModel.shared.gender))
        let imgDef = user?.userImage ?? defaultImage
        userImg.image = imgDef ?? defaultUserModel.shared.userImage
        userName.text = fullName ?? (defaultUserModel.shared.name + defaultUserModel.shared.lastName)
        postsTbl.reloadData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        IHProgressHUD.show()
        postsTbl.reloadData()
        IHProgressHUD.dismiss()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = arrPosts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = post.postBody ?? defaultPostModel.shared.postBody
        cell.imageView?.image = post.postImage ?? defaultPostModel.shared.postImage
        cell.detailTextLabel?.text = post.date ?? ""
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Posts By \(user?.name! ?? defaultUserModel.shared.name)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = arrPosts[indexPath.row] 
        let userM = user
        let postId = post.postId
        var postImg : UIImage?
        var postBody : String?
        var date : String?
        var userImg : UIImage?
        var userName : String?
        let userId  = userM?.userId ?? defaultUserModel.shared.userId
        let defaultImage = defaultImg(gender: (user?.gender ?? defaultUserModel.shared.gender))
        userImg = userM?.userImage ?? defaultImage
        userName = "\(userM!.name ?? "") \(userM!.lastName ?? "")"
        postImg = post.postImage ?? UIImage()
        postBody = post.postBody ?? ""
        date = post.date ?? ""
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailPostViewController") as! DetailPostViewController
        vc.imgPost = postImg
        vc.imgUser = userImg
        vc.userName = userName
        vc.date = date
        vc.postBody = postBody
        vc.userId = userId
        vc.postId = postId!
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func openChat(_ sender: Any) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "ChatSharedViewController") as! ChatSharedViewController
        vc.userId = user?.userId ?? defaultUserModel.shared.userId
        vc.userName = fullName ?? defaultUserModel.shared.userId
        vc.userImg = userImg.image ?? defaultUserModel.shared.userImage
        vc.getAllMessages(userId: (user?.userId) ?? defaultUserModel.shared.userId)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goBackToUsers(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
