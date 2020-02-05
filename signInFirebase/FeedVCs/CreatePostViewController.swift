//
//  SinglePostViewController.swift
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

class CreatePostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    let dateId = generateDate()
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var imgBtn: UIButton!
    
    @IBOutlet weak var postTxt: UITextView!
    @IBOutlet weak var postImgView: UIImageView!
    
    let timestamp = NSDate().timeIntervalSince1970
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.sendSubviewToBack(backgroundView)
        
        //set up imagePicker
        imagePicker.delegate = self
        setUpImagePicker()
        testViewStyle(txtView: postTxt, color: .blue)
        postImgView.image = UIImage(named: "camera")
        
        //set up the textView
        postTxt.delegate = self
        postTxt.text = "Is there anything you want to share? That's the place..."
        postTxt.textColor = .lightGray
        let fixedWidth = postTxt.frame.size.width
        let newSize = postTxt.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        postTxt.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
    }
    
    @IBAction func addImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion:  nil)
    }
    @IBAction func createPost(_ sender: Any) {
        savePost()
        navigationController?.popViewController(animated: true)
    }
    
    func savePost(){
        let user = Auth.auth().currentUser
        let postM = PostModel(timestamp: timestamp, userId: user?.uid, postBody: postTxt.text, date: dateId, postImage: nil, postId: nil)
        FireBaseManager.shared.savePost(post: postM) { (error) in
            if error == nil {
                print("Succesfully created post")
                return
            } else {
                print(error?.localizedDescription ?? "Could not create a post")
            }
        }
    }
    
    //placeholder functionality
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            postTxt.text = "Is there anything you want to share? That's the place..."
            postTxt.textColor = .lightGray
        } else {
            if textView.textColor == .lightGray {
                textView.text = nil
                textView.textColor = .black
            }
        }
        
    }
    
    
   
    //imagePicker set up
    func setUpImagePicker() {
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
            print("Error, image is not found")
            return
        }
        FireBaseManager.shared.savePostImg(date: dateId, image: addedImg) { (error) in
            if error == nil {
                self.postImgView.image = addedImg
                print("Succesfully saved image")
            } else {
                print(error?.localizedDescription ?? "Couldnt save image")
            }
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }


}
