//
//  MenuItemViewController.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/29/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

protocol MenuItemViewControllerDelegate {
    func menuItemViewController(menuItemViewController: MenuItemViewController, didSelectMenuItem menuItem: MenuItemView)
}

class MenuItemViewController: UIViewController {

    var items = [MenuItemView]()
    var numberOfItemsPerRow = 0
    var itemPadding: CGFloat = 0.0
    var rowHeight: CGFloat = 91
    var indexNumber = 0
    var delegate: MenuItemViewControllerDelegate?

    override func viewDidLoad() {

        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.orangeColor()
        // Do any additional setup after loading the view.
        layoutPage()
        super.viewDidLoad()
    }

    let colours = [UIColor.cyanColor(), UIColor.brownColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.redColor(), UIColor.yellowColor()]

    private func layoutPage() {
        var x = itemPadding
        var y = itemPadding
        for (index, item) in items.enumerate() {
            item.frame = CGRectMake(x, y, rowHeight, rowHeight)
            item.addTarget(self, action: "menuItemWasSelected:", forControlEvents: UIControlEvents.TouchUpInside)
            item.backgroundColor = colours[index]
            view.addSubview(item)

            // work out the position of the next item
            if (index + 1) % numberOfItemsPerRow == 0 {
                x = itemPadding
                y += itemPadding + rowHeight
            } else {
                x += rowHeight + itemPadding
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func menuItemWasSelected(sender: MenuItemView) {
        print("Menu item selected")
        delegate?.menuItemViewController(self, didSelectMenuItem: sender)
    }

}
