//
//  TabBarViewController.swift
//  signInFirebase
//
//  Created by Maryna Veksler on 1/28/20.
//  Copyright © 2020 Maryna Veksler. All rights reserved.
//

import UIKit
import SwipeableTabBarController


class TabBarViewController: SwipeableTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
    }
    
     private func setupCustomTabBar() {
            swipeAnimatedTransitioning?.animationType = SwipeAnimationType.overlap
        }

}
