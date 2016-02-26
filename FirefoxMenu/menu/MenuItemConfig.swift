//
//  MenuItemConfig.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

typealias ItemDisplayConfig = (title: String, icon: String, selectedIcon: String)

enum DisplayLocation {
    case Browser
    case TabsTray
    case HomePanel
}

protocol MenuItem {

    var title: String { get }
    var icon: UIImage? { get }
    var selectedIcon: UIImage? { get }
    var config: MenuItemConfig { get set }
    var delegate: MenuItemDelegate? { get set }

    init(config: MenuItemConfig, delegate: MenuItemDelegate?)

    func menuItemForLocation(location: DisplayLocation) -> UIView?

}

extension MenuItem {

    var title: String {
        return self.config.states.first?.title ?? ""
    }

    var icon: UIImage? {
        guard let iconName = self.config.states.first?.icon else { return nil }
        return UIImage(named: iconName)
    }

    var selectedIcon: UIImage? {
        guard let iconName = self.config.states.first?.selectedIcon else { return nil }
        return UIImage(named: iconName)
    }
}

protocol MenuItemDelegate {
    func menuItemWasPressed(menuItem: MenuItem)
}


struct MenuItemConfig {

    static let MenuItemWidth = 90
    static let MenuItemHeight = 90
    static let MenuItemIconHeight = 18
    static let MenuItemIconWidth = 18

    let type: MenuItem.Type
    let enabled: Bool
    let displayLocations: [DisplayLocation]
    let states: [ItemDisplayConfig]

    init(type: MenuItem.Type, enabled: Bool, displayLocations: [DisplayLocation] , states: [ItemDisplayConfig]) {
        self.type = type
        self.enabled = enabled
        self.displayLocations = displayLocations
        self.states = states
    }
}
