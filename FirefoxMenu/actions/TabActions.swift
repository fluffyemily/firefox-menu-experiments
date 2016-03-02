//
//  NewTabAction.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation


protocol TabAction: Action {
    func performActionWithTabManager(tabManager: TabManager)
}

struct NewTabAction: TabAction {
    init() { }

    func performActionWithTabManager(tabManager: TabManager) {
        print("Action: New Tab")
        tabManager.addNewTab(isPrivate: false)
    }
}

struct NewPrivateTabAction: TabAction {
    init() { }
    
    func performActionWithTabManager(tabManager: TabManager) {
        print("Action: New Private Tab")
        tabManager.addNewTab(isPrivate: true)
    }
}
