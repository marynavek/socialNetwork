//
//  changePassViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/9/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import IHProgressHUD

class changePassViewController: UIViewController {

    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var oldPassTxt: UITextField!
    @IBOutlet weak var newPassTxt: UITextField!
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var instructionTxt: UITextView!
    @IBOutlet weak var passwordTxt: UITextView!
    @IBOutlet weak var changePassBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(backgroundImg)
        textFieldStyle(txtField: emailTxt, color: .blue)
        textFieldStyle(txtField: oldPassTxt, color: .blue)
        textFieldStyle(txtField: newPassTxt, color: .blue)
        textFieldStyle(txtField: confirmPassTxt, color: .blue)
        buttonStyle(button: changePassBtn, color: .blue)

    }
    



    @IBAction func changePassword(_ sender: Any) {
        if let email = emailTxt.text, !email.isEmpty, let oldPass = oldPassTxt.text, !oldPass.isEmpty, let newPass = newPassTxt.text, !newPass.isEmpty, let confirmPass = confirmPassTxt.text, !confirmPass.isEmpty {
            if email.isValidEmail {
                if newPass == confirmPass {
                    FireBaseManager.shared.changePassword(email: email, oldPass: oldPass, password: newPass) { (error) in
                        if error == nil {
                            IHProgressHUD.showSuccesswithStatus("Succesfully changed the password")
                        } else {
                            IHProgressHUD.showError(withStatus: "Could not change password")
                        }
                    }
                } else {
                    IHProgressHUD.showInfowithStatus("Passwords do not match")
                }
            } else {
                IHProgressHUD.showInfowithStatus("Email is invalid")
            }
        } else {
            IHProgressHUD.showInfowithStatus("Fill out all fields")
        }
        IHProgressHUD.dismissWithDelay(1)
    }
    
}
