//
//  MenuItemConfig.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

struct MenuItem {
    let displayLocations: [DisplayLocation]
    let states: [MenuItemState]

    init(displayLocations: [DisplayLocation] , states: [MenuItemState]) {
        self.displayLocations = displayLocations
        self.states = states
    }

    func stateWithName(name: String) -> MenuItemState? {
        return (states.filter { $0.name == name }).first
    }
}

struct MenuItemState {

    let name: String
    let title: String
    let enabled: Bool
    let action: Action.Type
    let longPressAction: Action.Type?

    // variable that can hold a function that will determine whether or not the
    var isVisible: (AppState) -> Bool

    private let iconName: String
    private let selectedIconName: String

    var icon: UIImage? {
        return UIImage(named: iconName)
    }

    var selectedIcon: UIImage? {
        return UIImage(named: selectedIconName)
    }

    init(name: String, title: String, enabled: Bool, icon: String, selectedIcon: String, action: Action.Type, longPressAction: Action.Type? = nil) {
        self.action = action
        self.longPressAction = longPressAction
        self.name = name
        self.title = title
        self.enabled = enabled
        self.iconName = icon
        self.selectedIconName = selectedIcon
        self.isVisible = { (state: AppState) -> Bool in
            return enabled
        }
    }

}
