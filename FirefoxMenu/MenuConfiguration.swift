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
    static let menuItems: [MenuItem] = [
        MenuItem(displayLocations: [.Browser, .TabsTray, .HomePanel], states: [MenuItemState(name: "NewTab", title: "New Tab", enabled: true, icon: "add", selectedIcon: "add", action: NewTabAction.self)]),
        MenuItem(displayLocations: [.Browser, .TabsTray, .HomePanel], states: [MenuItemState(name: "NewPrivateTab", title: "New Private Tab", enabled: true, icon: "smallPrivateMask", selectedIcon: "smallPrivateMask", action: NewPrivateTabAction.self)]),
        MenuItem(displayLocations: [.Browser], states: [MenuItemState(name: "AddBookmark", title: "Add Bookmark", enabled: true, icon: "bookmark", selectedIcon: "bookmarkHighlighted", action: AddBookmarkAction.self), MenuItemState(name: "RemoveBookmark", title: "Remove Bookmark", enabled: true, icon: "bookmarked", selectedIcon: "bookmarkHighlighted", action: AddBookmarkAction.self)]),
        MenuItem(displayLocations: [.Browser], states: [MenuItemState(name: "FindInPage", title: "Find In Page", enabled: true, icon: "shareFindInPage", selectedIcon: "shareFindInPage", action: FindInPageAction.self)]),
        MenuItem(displayLocations: [.Browser], states: [MenuItemState(name: "ViewDesktopSite", title: "View Desktop Site", enabled: true, icon: "shareRequestDesktopSite", selectedIcon: "shareRequestDesktopSite", action: ViewDesktopSiteAction.self), MenuItemState(name: "ViewMobileSite", title: "View Mobile Site", enabled: true, icon: "shareRequestMobileSite", selectedIcon: "shareRequestMobileSite", action: ViewMobileSiteAction.self)]),
        MenuItem(displayLocations: [.Browser, .TabsTray, .HomePanel], states: [MenuItemState(name: "Settings", title: "Settings", enabled: true, icon: "settings", selectedIcon: "settings", action: OpenSettingsAction.self)]),
    ]


    // specify the display order based on where the item appears in the menu
    static let menuToolbarItems: [MenuToolbarItem] = [
        MenuToolbarItem(title: "Top Sites", enabled: true, icon: "panelIconTopSites", selectedIcon: "panelIconTopSitesSelected", action: ViewTopSitesAction.self),
        MenuToolbarItem(title: "Bookmarks", enabled: true, icon: "panelIconBookmarks", selectedIcon: "panelIconBookmarksSelected", action: ViewBookmarksAction.self),
        MenuToolbarItem(title: "History", enabled: true, icon: "panelIconHistory", selectedIcon: "panelIconHistorySelected", action: ViewHistoryAction.self),
        MenuToolbarItem(title: "Reading List", enabled: true, icon: "panelIconReadingList", selectedIcon: "panelIconReadingListSelected", action: ViewReadingListAction.self),
    ]

    // specify the display properties of the menu itself
    static let MenuFont: UIFont = UIFont.systemFontOfSize(14)
    static let MenuFontColor: UIColor = UIColor.blackColor()
    static let MenuBackgroundColor: UIColor = UIColor.grayColor()
    static let MaxNumberOfItemsInMenuPage = 6
    static let MaxNumberOfMenuItemsPerRow = 3
    static let MenuPaddingBetweenItems: CGFloat = 5.0

}

enum DisplayLocation {
    case Browser
    case TabsTray
    case HomePanel
}
