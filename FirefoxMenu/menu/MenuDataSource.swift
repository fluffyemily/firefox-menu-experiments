//
//  MenuDataSource.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit


// toolbar
protocol MenuToolbarDataSource {
    // how many items we will be displaying in our toolbar
    func numberOfToolbarItemsInMenuView(menuView: MenuView) -> Int

    // the button that we should display at this point in the toolbar
    func menuView(menuView: MenuView, buttonForItemAtIndex index: Int) -> UIBarButtonItem
}

// menu items
protocol MenuItemDataSource {
    // how many pages we should provide in our menu
    func numberOfPagesInMenuView(menuView: MenuView) -> Int

    func numberOfItemsPerRowInMenuView(menuView: MenuView) -> Int

    // for this page, the number of items that we will display
    func menuView(menuView: MenuView, numberOfItemsForPage page: Int) -> Int

    // get the menu item for this page item
    func menuView(menuView: MenuView, viewForItemAtIndexPath indexPath: NSIndexPath) -> MenuItemView
}
