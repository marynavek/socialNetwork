//
//  signUpViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/26/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import iOSDropDown
import SVProgressHUD
import TWMessageBarManager
import IHProgressHUD

class signUpViewController: UIViewController {

    let signViewModel = SignViewModel()
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var confirmPasTxt: UITextField!
    
    @IBOutlet weak var genderDD: DropDown!
    @IBOutlet weak var sportTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderDD.optionArray = ["Male", "Female"]
        
        buttonStyle(button: backBtn, color: .blue)
        textFieldStyle(txtField: nameTxt, color: .blue)
        textFieldStyle(txtField: sportTxt, color: .blue)
        textFieldStyle(txtField: emailTxt, color: .blue)
        textFieldStyle(txtField: passwordTxt, color: .blue)
        textFieldStyle(txtField: confirmPasTxt, color: .blue)
        textFieldStyle(txtField: genderDD, color: .blue)
        textFieldStyle(txtField: lastNameTxt, color: .blue)


        buttonStyle(button: signUpBtn, color: .blue)
        
        view.sendSubviewToBack(backgroundImg)
    }
    


    @IBAction func signUpBtn(_ sender: Any) {
        if signViewModel.validateSignUp(email: emailTxt.text, password: passwordTxt.text, name: nameTxt.text, sport: sportTxt.text, gender: genderDD.text, lastName: lastNameTxt.text, confirmPassword: confirmPasTxt.text){
            IHProgressHUD.show()
            let user = UserModel(userId: nil, email: emailTxt.text ?? defaultUserModel.shared.email, password: passwordTxt.text ?? defaultUserModel.shared.password, userImage: nil, name: nameTxt.text ?? defaultUserModel.shared.name, lastName: lastNameTxt.text ?? defaultUserModel.shared.lastName, sport: sportTxt.text ?? defaultUserModel.shared.sport, gender: genderDD.text ?? defaultUserModel.shared.gender)
            
            signViewModel.signUp(user: user) { (error) in
                if error == nil{
                    IHProgressHUD.dismiss()
                    let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    ctrl.modalPresentationStyle = .fullScreen
                    self.present(ctrl, animated: true, completion: nil)
                }
                else {
                    IHProgressHUD.dismiss()
                }
            }
        }
    }
    
    @IBAction func backToSignIn(_ sender: Any) {
        let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        ctrl.modalPresentationStyle = .fullScreen
        self.present(ctrl, animated: true, completion: nil)
    }
    
}
