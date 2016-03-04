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
        NewTabMenuItem,
        NewPrivateTabMenuItem,
        BookmarkMenuItem,
        FindInPageMenuItem,
        SiteModeMenuItem,
        SettingsMenuItem,
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


    private static var NewTabMenuItem: MenuItem {
        return MenuItem(displayLocations: [.Browser, .TabsTray, .HomePanel], states: [MenuItemState(name: "NewTab", title: "New Tab", enabled: true, icon: "add", selectedIcon: "add", action: NewTabAction.self, longPressAction: OpenTabsTrayAction.self)])
    }

    private static var NewPrivateTabMenuItem: MenuItem {
        return MenuItem(displayLocations: [.Browser, .TabsTray, .HomePanel], states: [MenuItemState(name: "NewPrivateTab", title: "New Private Tab", enabled: true, icon: "smallPrivateMask", selectedIcon: "smallPrivateMask", action: NewPrivateTabAction.self, longPressAction: OpenTabsTrayAction.self)])
    }

    private static var BookmarkMenuItem: MenuItem {
        var addBookmarkItemState = MenuItemState(name: "AddBookmark", title: "Add Bookmark", enabled: true, icon: "bookmark", selectedIcon: "bookmarkHighlighted", action: AddBookmarkAction.self)
        addBookmarkItemState.isVisible = { (state: AppState) -> Bool in
            switch state {
            case .BrowserState(_, let isBookmarked, _, _):
                return !isBookmarked && addBookmarkItemState.enabled
            default:
                return addBookmarkItemState.enabled

            }
        }
        var removeBookmarkItemState = MenuItemState(name: "AddBookmark", title: "Add Bookmark", enabled: true, icon: "bookmark", selectedIcon: "bookmarkHighlighted", action: AddBookmarkAction.self)
        removeBookmarkItemState.isVisible = { (state: AppState) -> Bool in
            switch state {
            case .BrowserState(_, let isBookmarked, _, _):
                return isBookmarked && removeBookmarkItemState.enabled
            default:
                return removeBookmarkItemState.enabled

            }
        }
        return MenuItem(displayLocations: [.Browser], states: [addBookmarkItemState, removeBookmarkItemState])
    }

    private static var FindInPageMenuItem: MenuItem {
        return MenuItem(displayLocations: [.Browser], states: [MenuItemState(name: "FindInPage", title: "Find In Page", enabled: true, icon: "shareFindInPage", selectedIcon: "shareFindInPage", action: FindInPageAction.self)])
    }

    private static var SiteModeMenuItem: MenuItem {
        var requestDesktopItemState = MenuItemState(name: "ViewDesktopSite", title: "View Desktop Site", enabled: true, icon: "shareRequestDesktopSite", selectedIcon: "shareRequestDesktopSite", action: ViewDesktopSiteAction.self)
        requestDesktopItemState.isVisible = { (state: AppState) -> Bool in
            switch state {
            case .BrowserState(_, _, let isDesktopSite, _):
                return !isDesktopSite && requestDesktopItemState.enabled
            default:
                return requestDesktopItemState.enabled
            }
        }
        var requestMobileItemState = MenuItemState(name: "ViewMobileSite", title: "View Mobile Site", enabled: true, icon: "shareRequestMobileSite", selectedIcon: "shareRequestMobileSite", action: ViewMobileSiteAction.self)
        requestMobileItemState.isVisible = { (state: AppState) -> Bool in
            switch state {
            case .BrowserState(_, _, let isDesktopSite, _):
                return isDesktopSite && requestMobileItemState.enabled
            default:
                return requestMobileItemState.enabled

            }
        }
        return MenuItem(displayLocations: [.Browser], states: [requestDesktopItemState, requestMobileItemState])
    }

    private static var SettingsMenuItem: MenuItem {
        return MenuItem(displayLocations: [.Browser, .TabsTray, .HomePanel], states: [MenuItemState(name: "Settings", title: "Settings", enabled: true, icon: "settings", selectedIcon: "settings", action: OpenSettingsAction.self)])
    }

}

enum DisplayLocation {
    case Browser
    case TabsTray
    case HomePanel
}
