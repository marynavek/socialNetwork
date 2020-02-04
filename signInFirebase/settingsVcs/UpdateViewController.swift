//
//  UpdateViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/26/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import iOSDropDown


class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgContainer: UIView!
    var currentUser : UserModel?

    @IBOutlet weak var backgroundImg: UIImageView!

    var gender : String?
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var sportTxt: UITextField!
    
    @IBOutlet weak var genderDD: DropDown!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setting up picker for image
        imgView.contentMode = .scaleAspectFill
        imgContainer.contentMode = .scaleAspectFill
        view.sendSubviewToBack(backgroundImg)
        imagePicker.delegate = self
        setupImagePicker()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textFieldStyle(txtField: nameTxt, color: .blue)
        textFieldStyle(txtField: sportTxt, color: .blue)
        textFieldStyle(txtField: lastNameTxt, color: .blue)
        textFieldStyle(txtField: genderDD, color: .blue)
        genderDD.optionArray = ["Male", "Female"]
        buttonStyle(button: updateBtn, color: .blue)
        buttonStyle(button: deleteBtn, color: .blue)
        getUserInfo()
        
        
    }
  

    
    @IBAction func updateUser(_ sender: Any) {
        let newUserData = UserModel(userId: currentUser?.userId, email: currentUser?.email, password: currentUser?.password, userImage: imgView.image, name: nameTxt.text, lastName: lastNameTxt.text, sport: sportTxt.text, gender: genderDD.text)
        FireBaseManager.shared.updateUser(user: newUserData) { (error) in
            if error == nil {
                print("Succesfully updated user")
            } else {
                print(error?.localizedDescription ?? "Could not update user")
            }
        }
    }
    
    func getUserInfo(){
        FireBaseManager.shared.getUserData { (user) in
            if user != nil {
                self.currentUser = user 
                self.nameTxt.text = user?.name
                self.lastNameTxt.text = user?.lastName
                self.sportTxt.text = user?.sport
                self.genderDD.text = user?.gender
                self.gender = user?.gender
                
                self.getImage()
                
            } else {
                print("Error hapened")
            }
        }
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        
        FireBaseManager.shared.deleteUser { (error) in
            if error != nil {
                print("Could not delete user")
            } else {
                print("user deleted succesfully")
            }
        }
        let signIn = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.keyWindow?.rootViewController = signIn
  
    }
    
    
    
    
    @IBAction func pickImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let fetchedImage = info[.editedImage] as? UIImage else {
            print("Error, image is not found")
            return
            }
        FireBaseManager.shared.saveUserImg(image: fetchedImage) { (error) in
            if error == nil {
                self.imgView.image = fetchedImage
                print("Succesfully updated image")
            } else {
                print(error?.localizedDescription ?? "couldnt save image")
            }
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func getImage(){
        FireBaseManager.shared.getUserImg { (data, error) in
            if error == nil {
                self.imgView.image = UIImage(data: data!) ?? UIImage()
            } else {
                self.imgView.image = defaultImg(gender: self.gender!)
                print( error?.localizedDescription ?? "Could not fetch image")
            }
        }
    }
    
    


}


