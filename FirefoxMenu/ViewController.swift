//
//  ViewController.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

enum AppState {
    case BrowserState(url: NSURL, isBookmarked: Bool, isDesktopSite: Bool, hasAccount: Bool)
    case TabsTrayState
    case HomePanelState(homePanelIndex: Int)
}

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
            menuVC.setMenuItems(MenuConfiguration.menuItems, toolbarItems: MenuConfiguration.menuToolbarItems, forState: .BrowserState(url: NSURL(string: "http://google.co.uk")!, isBookmarked: false, isDesktopSite: false, hasAccount: true))
            menuVC.actionDelegate = self
        }
    }
}

extension ViewController: ActionDelegate {

    func performAction(action: Action, withState state: AppState?) {
        switch action {
        case is TabAction:
            (action as! TabAction).performActionWithTabManager(TabManager())
            break
        case is BookmarkAction:
            (action as! BookmarkAction).performActionWithProfile(Profile())
            break
        case is BrowserAction:
            (action as! BrowserAction).performActionWithBrowserViewController(BrowserViewController())
            break
        case is HomePanelAction:
            (action as! HomePanelAction).performActionWithBrowserViewController(BrowserViewController())
            break
        case is SettingsAction:
            (action as! SettingsAction).performActionWithRootViewController(self)
            break
        default:
            print("Unexpected action type")
            break
        }
    }
}

