//
//  MenuConfiguration.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

struct MenuConfiguration {
    
    // specify the display order based on where the item appears in the menu
    static let menuItems: [MenuItemConfig] = [
        MenuItemConfig(type: NewTabMenuItem.self, enabled: true, displayLocations: [.Browser, .TabsTray, .HomePanel], states: [(title: "New Tab", icon: "add", selectedIcon: "addSelected")]),
        MenuItemConfig(type: NewPrivateTabMenuItem.self, enabled: true, displayLocations: [.Browser, .TabsTray, .HomePanel], states: [(title: "New Private Tab", icon: "newPrivateTab", selectedIcon: "newPrivateTabSelected")]),
        MenuItemConfig(type: BookmarkMenuItem.self, enabled: true, displayLocations: [.Browser], states: [(title: "Add Bookmark", icon: "bookmark", selectedIcon: "addBookmarkSelected"), (title: "Remove Bookmark", icon: "bookmarked", selectedIcon: "removeBookmarkSelected")]),
        MenuItemConfig(type: FindInPageMenuItem.self, enabled: true, displayLocations: [.Browser], states: [(title: "Find In Page", icon: "findInPage", selectedIcon: "findInPageSelected")]),
        MenuItemConfig(type: SwitchSiteTypeMenuItem.self, enabled: true, displayLocations: [.Browser], states: [(title: "View Desktop Site", icon: "viewDesktopSite", selectedIcon: "viewDekstopSiteSelected"), (title: "View Mobile Site", icon: "viewMobileSite", selectedIcon: "viewMobileSiteSelected")]),
        MenuItemConfig(type: SettingsMenuItem.self, enabled: true, displayLocations: [.Browser, .TabsTray, .HomePanel], states: [(title: "Settings", icon: "settings", selectedIcon: "settingsSelected")]),
    ]


    // specify the display order based on where the item appears in the menu
    static let menuToolbarItems: [MenuToolbarItemConfig] = [
        MenuToolbarItemConfig(type: TopSitesMenuToolbarItem.self, enabled: true, icon:"panelIconTopSites", selectedIcon: "panelIconTopSitesSelected"),
        MenuToolbarItemConfig(type: BookmarksMenuToolbarItem.self, enabled: true, icon:"Bookmarks", selectedIcon: "BookmarksSelected"),
        MenuToolbarItemConfig(type: HistoryMenuToolbarItem.self, enabled: true, icon:"History", selectedIcon: "HistorySelected"),
        MenuToolbarItemConfig(type: ReadingListMenuToolbarItem.self, enabled: true, icon:"ReadingList", selectedIcon: "ReadingListSelected"),
    ]

    // specify the display properties of the menu itself
    static let menuFont: UIFont = UIFont.systemFontOfSize(17)
    static let menuFontColor: UIColor = UIColor.blackColor()
    static let menuBackgroundColor: UIColor = UIColor.grayColor()

}
