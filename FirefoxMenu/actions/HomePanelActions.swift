//
//  HomePanelActions.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation

protocol HomePanelAction: Action {
    func performActionWithBrowserViewController(bvc: BrowserViewController)
}

struct ViewTopSitesAction: HomePanelAction {
    init() { }

    func performActionWithBrowserViewController(bvc: BrowserViewController) {
        bvc.openHomePanels()
        bvc.openTopSitesPanel()
    }
}

struct ViewBookmarksAction: HomePanelAction {
    init() { }

    func performActionWithBrowserViewController(bvc: BrowserViewController) {
        bvc.openHomePanels()
        bvc.openBookmarksPanel()
    }
}

struct ViewHistoryAction: HomePanelAction {
    init() { }

    func performActionWithBrowserViewController(bvc: BrowserViewController) {
        bvc.openHomePanels()
        bvc.openHistoryPanel()
    }
}

struct ViewReadingListAction: HomePanelAction {
    init() { }

    func performActionWithBrowserViewController(bvc: BrowserViewController) {
        bvc.openHomePanels()
        bvc.openReadingListPanel()
    }
}
