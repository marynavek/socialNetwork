//
//  SettingsViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    
    
    @IBOutlet weak var updateProfNtm: UIButton!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var updatePBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        buttonStyle(button: updatePBtn, color: .blue)
        buttonStyle(button: updateProfNtm, color: .blue)
        buttonStyle(button: logOutBtn, color: .blue)
        view.sendSubviewToBack(backgroundImg)
    }
    


    @IBAction func logOutBtn(_ sender: Any) {
        FireBaseManager.shared.signOut()
        let signIn = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.keyWindow?.rootViewController = signIn
        
    }
   
       

}
