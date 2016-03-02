//
//  ViewController.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.magentaColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let menuVC = segue.destinationViewController as? MenuViewController {
            menuVC.setMenuItems(MenuConfiguration.menuItems, toolbarItems: MenuConfiguration.menuToolbarItems, forLocation: .TabsTray)
            
        }
    }
}

