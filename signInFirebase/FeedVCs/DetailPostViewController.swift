//
//  DetailPostViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/30/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

class DetailPostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var backgroundView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    let dateNew = Date()
    let dateFormatter = DateFormatter()
    var dateId : String = ""
    let timestamp = NSDate().timeIntervalSince1970

    
    
    @IBOutlet weak var chooseImgBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var postBodyTxt: UITextView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var updatePostBtn: UIButton!
    @IBOutlet weak var postImgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var imgPost : UIImage?
    var imgUser : UIImage?
    var userName : String?
    var date : String?
    var postBody : String?
    var postId : String?
    var userId : String?
    var isCurrentUser : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonStyle(button: backBtn, color: .blue)
        testViewStyle(txtView: postBodyTxt, color: .blue)
        labelStyle(label: dateLbl, color: .blue)
        buttonStyle(button: updatePostBtn, color: .blue)
        labelStyle(label: userNameLbl, color: .blue)
        buttonStyle(button: deleteBtn, color: .blue)
        userImg.layer.borderWidth = 3
        userImg.layer.cornerRadius = userImg.frame.size.width / 2
        userImg.clipsToBounds = true


        view.sendSubviewToBack(backgroundView)
        postBodyTxt.delegate = self
        let fixedWidth = postBodyTxt.frame.size.width
        let newSize = postBodyTxt.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        postBodyTxt.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        
        
        
        checkIfCureent(userId: userId!)
        
        if isCurrentUser == true {
            postBodyTxt.isEditable = true
            setUpImagePicker()
            dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
            dateId = dateFormatter.string(from: dateNew)
        } else {
            deleteBtn.isHidden = true
            updatePostBtn.isHidden = true
            chooseImgBtn.isEnabled = false
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postImgView.image = imgPost
        userImg.image = imgUser
        userNameLbl.text = userName
        dateLbl.text = date
        postBodyTxt.text = postBody
    }
    
    @IBAction func goBackPosts(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updatePost(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        let postM = PostModel(timestamp: timestamp, userId: uid, postBody: postBodyTxt.text, date: dateId, postImage: nil, postId: postId)
        FireBaseManager.shared.updatePost(post: postM) { (error) in
            if error == nil {
                print("Succesfuly updated post")
            } else {
                print("Could not update the post")
            }
        }
        
        
        
    }
    @IBAction func deletePost(_ sender: Any) {
        FireBaseManager.shared.deletePost(postId: postId!) { (error) in
            if error == nil{
                print("Succesfully deleted post")
            } else {
                print(error?.localizedDescription ?? "Could not delete post")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func setUpImagePicker(){
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let addedImg = info[.editedImage] as? UIImage else {
            print("Error, image is not")
            return
        }
        
        FireBaseManager.shared.savePostImg(date: self.dateId, image: addedImg) { (error) in
            if error == nil {
                self.postImgView.image = addedImg
                print("Succesfully uploaded and updated image")
            } else {
                print(error?.localizedDescription ?? "Couldnt save image")
                }
            }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func checkIfCureent(userId: String){
        let currUserId = Auth.auth().currentUser?.uid
        if currUserId == userId {
            isCurrentUser = true
        } else {
            isCurrentUser = false
        }
    }
    
    @IBAction func goToFeed(_ sender: Any) {
        let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        ctrl.modalPresentationStyle = .fullScreen
        self.present(ctrl, animated: true, completion: nil)
    }
    
}
