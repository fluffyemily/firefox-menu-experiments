//
//  MenuDelegate.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

protocol MenuToolbarItemDelegate {
    func menuView(menuView: MenuView, didSelectItemAtIndex index: Int)
}

protocol MenuItemDelegate {
    func menuView(menuView: MenuView, didSelectItemAtIndexPath indexPath: NSIndexPath)
}
