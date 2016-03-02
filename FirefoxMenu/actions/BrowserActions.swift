//
//  RemoveBookmark.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation

protocol BrowserAction: Action {
    func performActionWithBrowserViewController(bvc: BrowserViewController)
}

struct FindInPageAction: BrowserAction {
    init() { }

    func performActionWithBrowserViewController(bvc: BrowserViewController) {
        print("Action: Find In Page")
        bvc.findInPage()
    }
}

struct ViewDesktopSiteAction: BrowserAction {
    init() { }

    func performActionWithBrowserViewController(bvc: BrowserViewController) {
        print("Action: View Desktop Site")
        bvc.switchSiteMode(desktop: true)
    }
}

struct ViewMobileSiteAction: BrowserAction {
    init() { }

    func performActionWithBrowserViewController(bvc: BrowserViewController) {
        print("Action: View Mobile Site")
        bvc.switchSiteMode(desktop: false)
    }
}

