//
//  NewPrivateTabMenuItem.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

class NewPrivateTabMenuItem: NSObject, MenuItem {

    var config: MenuItemConfig
    var delegate: MenuItemDelegate?

    required init(config: MenuItemConfig, delegate: MenuItemDelegate?) {
        self.config = config
        self.delegate = delegate
    }

    func menuItemForLocation(location: DisplayLocation) -> UIView? {
        if !config.enabled || !config.displayLocations.contains(location) {
            return nil
        }
        let view = UIButton()
        view.backgroundColor = UIColor.blueColor()
        view.setTitle(title, forState: UIControlState.Normal)
        view.addTarget(self, action: "onClick:", forControlEvents: UIControlEvents.TouchUpInside)
        return view
    }

    @objc
    private func onClick() {
        delegate?.menuItemWasPressed(self)
    }
}
