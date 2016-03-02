//
//  SettingsAction.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsAction: Action {
    func performActionWithRootViewController(rootViewController: UIViewController)
}

struct OpenSettingsAction: SettingsAction {
    init() { }
    
    func performActionWithRootViewController(rootViewController: UIViewController) {
        print("Action: OpenSettingsAction")
//        let settingsVC = UIViewController()
//        rootViewController.presentViewController(settingsVC, animated: true, completion: nil)
    }
}
