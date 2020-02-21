//
//  resetPassViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 2/9/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import IHProgressHUD

class resetPassViewController: UIViewController {

    @IBOutlet weak var backgroungImg: UIImageView!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    
    let viewModel = SignViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(backgroungImg)
        buttonStyle(button: resetBtn, color: .blue)
        buttonStyle(button: backBtn, color: .blue)
        textFieldStyle(txtField: emailTxt, color: .blue)

    }
    
    @IBAction func goBackToSignIn(_ sender: Any) {
        let ctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        ctrl.modalPresentationStyle = .fullScreen
        self.present(ctrl, animated: true, completion: nil)
    }
    
    @IBAction func resetPass(_ sender: Any) {
        viewModel.resetPassword(email: emailTxt.text) { (error) in
            if error != nil {
                IHProgressHUD.showSuccesswithStatus("The link to reset the password is sent to the email")
            } else {
                IHProgressHUD.showError(withStatus: "Could not provide the reset link")
            }
            self.emailTxt.text = ""
            IHProgressHUD.dismissWithDelay(1)
        }
    }
    
}
