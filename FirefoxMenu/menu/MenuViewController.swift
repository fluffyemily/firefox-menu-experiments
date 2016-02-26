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
    var itemDelegate: MenuItemDelegate? = nil, toolbarItemDelegate: MenuToolbarItemDelegate? = nil

    lazy private var menuToolbarItems: [MenuToolbarItem] = {
        var toolbarItems = [MenuToolbarItem]()

        for toolbarItem in MenuConfiguration.menuToolbarItems {
            toolbarItems.append(toolbarItem.type.init(config: toolbarItem, delegate: self.toolbarItemDelegate))
        }

        return toolbarItems
    }()

    lazy private var menuItems: [MenuItem] = {
        var menuItems = [MenuItem]()

        for menuItem in MenuConfiguration.menuItems {
            menuItems.append(menuItem.type.init(config: menuItem, delegate: self.itemDelegate))
        }
        return menuItems
    }()

    lazy var toolbarStackView: UIStackView = {
        let toolbarButtons = self.menuToolbarItems.flatMap{ return $0.menuToolbarItem() }
        let stackView = UIStackView(arrangedSubviews: toolbarButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Horizontal
        stackView.distribution = .FillProportionally
        stackView.alignment = .LastBaseline
        stackView.spacing = 10

        return stackView
    }()

    lazy var menuItemsStackView: UIStackView = {
        let menuButtons = self.menuItems.flatMap{ return $0.menuItemForLocation(self.menuLocation) }

        let stackView = UIStackView(arrangedSubviews: menuButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Horizontal
        stackView.distribution = .FillEqually
        stackView.alignment = .Fill
        stackView.spacing = 5
        return stackView
    }()

    lazy var menuStackView: UIStackView = {
        let toolbar = self.toolbarStackView
        let menu = self.menuItemsStackView
        let stackView = UIStackView(arrangedSubviews: [toolbar, menu])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.distribution = .FillProportionally
        stackView.alignment = .LastBaseline
        stackView.spacing = 5

        stackView.backgroundColor = MenuConfiguration.menuBackgroundColor

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.yellowColor()
        view.addSubview(menuStackView)

        menuStackView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        menuStackView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        menuStackView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        menuStackView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
