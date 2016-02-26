//
//  MenuItemView.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/25/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

class MenuItemView: UIButton {

    lazy var menuItemImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    lazy var menuItemTitleLabel: UILabel = {
        let view = UILabel()
        view.lineBreakMode = NSLineBreakMode.ByWordWrapping
        view.numberOfLines = 2
        return view
    }()


    init() {
        super.init(frame: CGRectZero)

        self.addSubview(menuItemImageView)
        menuItemImageView.topAnchor.constraintEqualToAnchor(self.topAnchor)
        menuItemImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor)
        menuItemImageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor)
        menuItemImageView.heightAnchor.constraintEqualToConstant(30)
        
        self.addSubview(menuItemTitleLabel)
        menuItemTitleLabel.topAnchor.constraintEqualToAnchor(self.menuItemImageView.bottomAnchor)
        menuItemTitleLabel.leftAnchor.constraintEqualToAnchor(self.leftAnchor)
        menuItemTitleLabel.rightAnchor.constraintEqualToAnchor(self.rightAnchor)
        menuItemTitleLabel.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let imageHeight = menuItemImageView.image?.size.height {
            menuItemImageView.heightAnchor.constraintEqualToConstant(imageHeight)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
