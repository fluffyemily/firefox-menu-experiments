//
//  MenuViewController.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var menuLocation: DisplayLocation = .Browser
    var menuLocationURL: NSURL?

    private var menuView: MenuView!

    private var menuToolbarItems: [MenuToolbarItem]!

    private var menuItems: [MenuItemState]!

    func setMenuItems(items: [MenuItem], toolbarItems: [MenuToolbarItem], forLocation location: DisplayLocation, url: NSURL? = nil) {
        self.menuLocation = location
        self.menuToolbarItems = toolbarItems.filter { $0.enabled }
        let validMenuItemsForLocation = items.filter { $0.displayLocations.contains(location) }
        self.menuItems = validMenuItemsForLocation.flatMap { menuItem in
            return menuItem.states.filter { $0.isVisible(url) }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        menuView = MenuView()
        menuView.menuItemDelegate = self
        menuView.menuItemDataSource = self
        menuView.toolbarDelegate = self
        menuView.toolbarDataSource = self

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.yellowColor()

        view.addSubview(menuView)
        menuView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        menuView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        menuView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        menuView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    func performAction(action: Action) {
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

extension MenuViewController: MenuItemDelegate {
    func menuView(menu: MenuView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let item = menuItems[indexPath.getMenuItemIndex()]
        let action = item.action.init()
        performAction(action)
    }
}

extension MenuViewController: MenuItemDataSource {
    func numberOfPagesInMenuView(menuView: MenuView) -> Int {
        return Int(ceil(Double(self.menuItems.count) / Double(MenuConfiguration.MaxNumberOfItemsInMenuPage)))
    }

    func numberOfItemsPerRowInMenuView(menuView: MenuView) -> Int {
        return 3
    }

    func menuView(menuView: MenuView, numberOfItemsForPage page: Int) -> Int {
        let pageStartIndex = page * MenuConfiguration.MaxNumberOfItemsInMenuPage
        if (pageStartIndex + MenuConfiguration.MaxNumberOfItemsInMenuPage) > menuItems.count {
            return menuItems.count - pageStartIndex
        }
        return MenuConfiguration.MaxNumberOfItemsInMenuPage
    }

    func menuView(menuView: MenuView, viewForItemAtIndexPath indexPath: NSIndexPath) -> MenuItemView {
        let menuItemView = menuView.dequeueReusableMenuItemViewForIndexPath(indexPath)
        let menuItem = menuItems[indexPath.getMenuItemIndex()]

        menuItemView.setTitle(menuItem.title)
        menuItemView.titleLabel.font = MenuConfiguration.MenuFont
        menuItemView.titleLabel.textColor = MenuConfiguration.MenuFontColor
        if let icon = menuItem.icon {
            menuItemView.setImage(icon)
        }
        if let selectedIcon = menuItem.selectedIcon {
            menuItemView.setHighlightedImage(selectedIcon)
        }

        return menuItemView
    }
}

extension MenuViewController: MenuToolbarDataSource {
    func numberOfToolbarItemsInMenuView(menuView: MenuView) -> Int {
        return menuToolbarItems.count
    }

    func menuView(menuView: MenuView, buttonForItemAtIndex index: Int) -> UIBarButtonItem {
        let item = menuToolbarItems[index]
        let toolbarItemView = UIBarButtonItem(image: item.icon, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        return toolbarItemView
    }
}

extension MenuViewController: MenuToolbarItemDelegate {
    func menuView(menuView: MenuView, didSelectItemAtIndex index: Int) {
        let item = menuToolbarItems[index]
        let action = item.action.init()
        performAction(action)
    }
}

extension NSIndexPath {
    func getMenuItemIndex() -> Int {
        return (section * MenuConfiguration.MaxNumberOfItemsInMenuPage) + row
    }
}
