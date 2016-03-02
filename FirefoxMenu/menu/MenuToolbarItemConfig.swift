//
//  MenuToolbarItemConfig.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

struct MenuToolbarItem {

    private let iconName: String
    private let selectedIconName: String

    let action: Action.Type
    let title: String
    let enabled: Bool

    var icon: UIImage? {
        return UIImage(named: iconName)
    }

    var selectedIcon: UIImage? {
        return UIImage(named: selectedIconName)
    }

    init(title: String, enabled: Bool, icon: String, selectedIcon: String, action: Action.Type) {
        self.action = action
        self.title = title
        self.enabled = enabled
        self.iconName = icon
        self.selectedIconName = selectedIcon
    }
}
