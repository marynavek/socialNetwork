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

class signUpViewController: UIViewController {

   
    
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
        if let email = emailTxt.text, !email.isEmpty, let password = passwordTxt.text, !password.isEmpty, let name = nameTxt.text, !name.isEmpty, let sport = sportTxt.text, !sport.isEmpty, let gender = genderDD.text, !gender.isEmpty, let lastName = lastNameTxt.text, !lastName.isEmpty, let confPass = confirmPasTxt.text, !confPass.isEmpty{
            if password == confPass {
                let user = UserModel(userId: nil, email: email, password: password, userImage: nil, name: name, lastName: lastName, sport: sport, gender: gender)
                FireBaseManager.shared.createUser(user: user) { (error) in
                    if error == nil {
                        print("Created a user")
                        let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                        ctrl.modalPresentationStyle = .fullScreen
                        self.present(ctrl, animated: true, completion: nil)
                    } else {
                        print("Could not create a user")
                    }
                }
            } else {
                print("Passwords do not match")
            }
        } else {
            print("Fill out all fields")
        }
    }
}
