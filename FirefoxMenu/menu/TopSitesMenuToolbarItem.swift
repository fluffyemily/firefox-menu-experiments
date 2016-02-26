//
//  TopSitesMenuToolbarItem.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/24/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import UIKit

class TopSitesMenuToolbarItem: NSObject, MenuToolbarItem {

    var config: MenuToolbarItemConfig
    var delegate: MenuToolbarItemDelegate?

    lazy var title: String = {
        return "Top Sites"
    }()

    required init(config: MenuToolbarItemConfig, delegate: MenuToolbarItemDelegate?) {
        self.config = config
        self.delegate = delegate
    }

    func menuToolbarItem() -> UIView? {
        if !config.enabled {
            return nil
        }
        let view = UIButton(frame: CGRectMake(0, 0, 50, 50))
        view.backgroundColor = UIColor.darkGrayColor()
        view.setTitle(title, forState: UIControlState.Normal)
        view.addTarget(self, action: "onClick:", forControlEvents: UIControlEvents.TouchUpInside)

        view.heightAnchor.constraintEqualToConstant(20)
        view.widthAnchor.constraintEqualToConstant(20)
        return view
    }

    func onClick(sender: UIButton) {
        print("user has tapped on a menu bar item")
        delegate?.menuToolbarItemWasPressed(self)
    }
}
