//
//  MenuView.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

class MenuView: UIView {

    private var toolbar: UIToolbar
    private var menuPageController: UIPageViewController

    var toolbarDelegate: MenuToolbarItemDelegate? {
        didSet {

        }
    }
    var toolbarDataSource: MenuToolbarDataSource? {
        didSet {

        }
    }

    var menuItemDelegate: MenuItemDelegate? {
        didSet {

        }
    }
    var menuItemDataSource: MenuItemDataSource? {
        didSet {

        }
    }

    var toolbarHeight: Float = 20.0 {
        didSet {
            self.setNeedsLayout()
        }
    }

    var menuRowHeight: Float = 40.0 {
        didSet {
            self.setNeedsLayout()
        }
    }

    private var selectedToolbarItemIndex: Int?
    var selectedToolbarItem: UIBarButtonItem? {
        get {
            return nil
        }
    }

    private var selectedMenuItemIndex: Int?
    var selectedMenuItem: MenuItemView? {
        get {
            return nil
        }
    }

    var itemPadding: CGFloat = 5.0

    var currentPageIndex: Int = 0
    var nextPageIndex: Int?

    private var needsReload: Bool = true

    private var cachedItems = [NSIndexPath: MenuItemView]()
    private var reusableItems = [MenuItemView]()
    private var toolbarItems = [UIBarButtonItem]()

    override init(frame: CGRect) {

        toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        menuPageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)

        toolbarDelegate = nil
        toolbarDataSource = nil
        menuItemDelegate = nil
        menuItemDataSource = nil
        super.init(frame: frame)


        menuPageController.delegate = self
        menuPageController.dataSource = self

        self.backgroundColor = UIColor.cyanColor()
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(toolbar)

        toolbar.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        toolbar.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        toolbar.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        toolbar.heightAnchor.constraintEqualToConstant(40)
        let pageControllerView = menuPageController.view
        pageControllerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageControllerView)
        pageControllerView.topAnchor.constraintEqualToAnchor(toolbar.bottomAnchor).active = true
        pageControllerView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        pageControllerView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        pageControllerView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        reloadDataIfNeeded()
        layoutToolbar()
        layoutMenu()
        super.layoutSubviews()
    }

    func reloadData() {
        cachedItems.keys.forEach { path in
            cachedItems[path]?.removeFromSuperview()
        }
        cachedItems.removeAll()

        reusableItems.forEach {
            $0.removeFromSuperview()
        }
        reusableItems.removeAll()

        toolbarItems.removeAll()
        toolbar.items?.removeAll()

        selectedMenuItemIndex = nil
        selectedToolbarItemIndex = nil

        loadToolbar()
        loadMenu()

        needsReload = false
    }

    func dequeueReusableMenuItemViewForIndexPath(indexPath: NSIndexPath) -> MenuItemView {
        if let existingView = cachedItems[indexPath] {
            return existingView
        }

        let view = reusableItems.last == nil ? MenuItemView() : reusableItems.removeLast()
        cachedItems[indexPath] = view
        return view
    }

    private func loadToolbar() {
        guard let toolbarDataSource = toolbarDataSource else { return }
        let numberOfToolbarItems = toolbarDataSource.numberOfToolbarItemsInMenuView(self)
        for index in 0..<numberOfToolbarItems {
            let toolbarButton = toolbarDataSource.menuView(self, buttonForItemAtIndex: index)
            toolbarButton.target = self
            toolbarButton.action = "toolbarButtonSelected:"
            toolbarItems.append(toolbarButton)
        }
    }

    private func loadMenu() {
        let lastPageIndex = currentPageIndex - 1
        if lastPageIndex >= 0 {
            loadMenuForPageIndex(lastPageIndex)
        }

        loadMenuForPageIndex(currentPageIndex)

        let nextPageIndex = currentPageIndex + 1
        if nextPageIndex < menuItemDataSource?.numberOfPagesInMenuView(self) ?? 0 {
            loadMenuForPageIndex(nextPageIndex)
        }
    }

    private func loadMenuForPageIndex(pageIndex: Int) {
        guard let itemDataSource = menuItemDataSource else { return }

        let numberOfItemsForPage = itemDataSource.menuView(self, numberOfItemsForPage: pageIndex)
        for index in 0..<numberOfItemsForPage {
            let indexPath = NSIndexPath(forItem: index, inSection: pageIndex)
            cachedItems[indexPath] = itemDataSource.menuView(self, viewForItemAtIndexPath: indexPath)
        }

    }

    func setNeedsReload() {
        needsReload = true
        setNeedsLayout()
    }

    private func reloadDataIfNeeded() {
        if needsReload {
            reloadData()
        }
    }

    private func layoutToolbar() {
        var displayToolbarItems = [UIBarButtonItem]()
        for (index, item) in toolbarItems.enumerate() {
            displayToolbarItems.append(item)
            if index < toolbarItems.count-1 {
                displayToolbarItems.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
            }
        }
        toolbar.setItems(displayToolbarItems, animated: false)
    }


    private func layoutMenu() {
        // if there is only 1 page in our menu, disable scrolling
        if menuItemDataSource?.numberOfPagesInMenuView(self) ?? 0 > 1 {
            menuPageController.getScrollView()?.scrollEnabled = true
        } else {
            menuPageController.getScrollView()?.scrollEnabled = false
        }

        // make a copy of cached items
        var availableItems = cachedItems
        cachedItems.removeAll()

        // get views for the previous page, if there is one
        for pageIndex in currentPageIndex-1...currentPageIndex+1 {
            layoutPage(pageIndex, availableItems: &availableItems)
        }
        
        menuPageController.setViewControllers([menuViewControllerForPageIndex(currentPageIndex)], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)

        // add any unused views to reusable items
        for item in availableItems.values {
            item.prepareForReuse()
            reusableItems.append(item)
        }
        availableItems.removeAll()
    }

    private func layoutPage(pageIndex: Int, inout availableItems: [NSIndexPath: MenuItemView]) {
        guard let itemDataSource = menuItemDataSource else { return }

        let numberOfPages = itemDataSource.numberOfPagesInMenuView(self)

        if pageIndex < 0 || pageIndex >= numberOfPages { return }

        let numberOfItemsForPage = itemDataSource.menuView(self, numberOfItemsForPage: pageIndex)

        for index in 0..<numberOfItemsForPage {
            let indexPath = NSIndexPath(forItem: index, inSection: pageIndex)
            guard let item = availableItems[indexPath] else { continue }
            cachedItems[indexPath] = item
            availableItems.removeValueForKey(indexPath)
        }

    }

    @objc private func toolbarButtonSelected(sender: UIBarButtonItem) {
        guard let selectedButtonIndex = toolbarItems.indexOf(sender) else { return }
        toolbarDelegate?.menuView(self, didSelectItemAtIndex: selectedButtonIndex)
    }

    func indexPathForView(itemView: MenuItemView) -> NSIndexPath? {
        return (cachedItems as NSDictionary).allKeysForObject(itemView).first as? NSIndexPath
    }
}

extension  MenuView: MenuItemViewControllerDelegate {
    func menuItemViewController(menuItemViewController: MenuItemViewController, didSelectMenuItem menuItem: MenuItemView) {
        guard let indexOfSelectedView = indexPathForView(menuItem) else { return }
        menuItemDelegate?.menuView(self, didSelectItemAtIndexPath: indexOfSelectedView)
    }
}

extension MenuView: UIPageViewControllerDataSource {

    func menuViewControllerForPageIndex(pageIndex: Int) -> MenuItemViewController {
        let menuVC = MenuItemViewController()
        menuVC.items = itemsForPageIndex(pageIndex)
        menuVC.indexNumber = pageIndex
        menuVC.delegate = self
        menuVC.numberOfItemsPerRow = MenuConfiguration.MaxNumberOfMenuItemsPerRow
        menuVC.itemPadding = MenuConfiguration.MenuPaddingBetweenItems
        return menuVC
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let nextPageIndex = (viewController as! MenuItemViewController).indexNumber + 1
        if nextPageIndex < (menuItemDataSource?.numberOfPagesInMenuView(self) ?? 0) {
            return menuViewControllerForPageIndex(nextPageIndex)
        }
        return nil
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let previousPageIndex = (viewController as! MenuItemViewController).indexNumber - 1
        if previousPageIndex >= 0 {
            return menuViewControllerForPageIndex(previousPageIndex)
        }
        return nil
    }

    private func itemsForPageIndex(pageIndex: Int) -> [MenuItemView] {

        var itemsForPageIndex = [MenuItemView]()
        let numberOfItemsForPage = menuItemDataSource?.menuView(self, numberOfItemsForPage: pageIndex) ?? 0
        for index in 0..<numberOfItemsForPage {
            let indexPath = NSIndexPath(forItem: index, inSection: pageIndex)
            if let view = cachedItems[indexPath] ?? menuItemDataSource?.menuView(self, viewForItemAtIndexPath: indexPath) {
                if cachedItems[indexPath] == nil {
                    cachedItems[indexPath] = view
                }

                itemsForPageIndex.append(view)
            }
        }

        return itemsForPageIndex
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return (menuItemDataSource?.numberOfPagesInMenuView(self) ?? 0)
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentPageIndex + 1
    }
}

extension MenuView: UIPageViewControllerDelegate {

    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        guard let nextVC = pendingViewControllers.first as? MenuItemViewController else { return }
        nextPageIndex = nextVC.indexNumber
    }

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        defer {
            nextPageIndex = nil
        }

        guard completed, let nextIndex = nextPageIndex else { return }
        currentPageIndex = nextIndex
    }

}

extension UIPageViewController {
    func getScrollView() -> UIScrollView? {
        for subview in view.subviews {
            if subview is UIScrollView {
                return subview as? UIScrollView
            }
        }

        return nil
    }
}
