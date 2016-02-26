//
//  MenuToolbarItemConfig.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

protocol MenuToolbarItem {

    var title: String { get }
    var icon: UIImage { get }
    var selectedIcon: UIImage { get }
    var config: MenuToolbarItemConfig { get set }
    var delegate: MenuToolbarItemDelegate? { get set }

    init(config: MenuToolbarItemConfig, delegate: MenuToolbarItemDelegate?)

    func menuToolbarItem() -> UIView?

}

extension MenuToolbarItem {

    var icon: UIImage {
        return UIImage(named: self.config.icon)!
    }

    var selectedIcon: UIImage {
        return UIImage(named: self.config.selectedIcon)!
    }
}

protocol MenuToolbarItemDelegate {
    func menuToolbarItemWasPressed(menuToolbarItem: MenuToolbarItem)
}

struct MenuToolbarItemConfig {

    let type: MenuToolbarItem.Type
    let enabled: Bool
    let icon: String
    let selectedIcon: String

    init(type: MenuToolbarItem.Type, enabled: Bool, icon: String, selectedIcon: String) {
        self.type = type
        self.enabled = enabled
        self.icon = icon
        self.selectedIcon = selectedIcon
    }
}
