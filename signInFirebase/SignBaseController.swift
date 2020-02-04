//
//  SignBaseController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/29/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit

class SignBaseController: UIViewController {

    var backgroundImgView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackground()
    }
    

    func setBackground() {
        backgroundImgView.image = UIImage(named: "signIn")
        backgroundImgView.contentMode = .scaleAspectFit
        view.addSubview(backgroundImgView)
        view.sendSubviewToBack(backgroundImgView)
        
        backgroundImgView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImgView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImgView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImgView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
