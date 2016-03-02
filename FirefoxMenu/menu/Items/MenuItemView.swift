//
//  MenuItemView.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/25/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import UIKit

public class MenuItemView: UIControl {

    private(set) public var imageView: UIImageView
    private(set) public var titleLabel: UILabel

    private var previousLocation: CGPoint?

    public init() {
        imageView = UIImageView()
        titleLabel = UILabel()

        super.init(frame: CGRectZero)

        self.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = NSTextAlignment.Center

        self.addSubview(imageView)

        self.addSubview(titleLabel)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        let imageHeight = self.bounds.height * 0.5
        let x = (self.bounds.width - (imageView.image?.size.width ?? 0)) / 2
        let y = (imageHeight - (imageView.image?.size.width ?? 0)) / 2
        imageView.frame = CGRectMake(x, y, imageView.image?.size.width ?? self.bounds.width, imageView.image?.size.height ?? imageHeight)
        titleLabel.frame = CGRectMake(0, imageHeight, self.bounds.width, self.bounds.height - (imageHeight + 5))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
    }

    public func setTitle(title: String) {
        titleLabel.text = title
    }

    public func setImage(image: UIImage) {
        imageView.image = image
    }

    public func setHighlightedImage(image: UIImage) {
        imageView.highlightedImage = image
    }

    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        // work out whether or not the touch happened inside this item
        // return true if so, false otherwise
        if !self.bounds.contains(touch.locationInView(self)) {
            return false
        }

        imageView.highlighted = true
        return true
    }

    public override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        if !self.bounds.contains(touch.locationInView(self)) {
            imageView.highlighted = false
            return false
        }
        return true
    }

    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        imageView.highlighted = false
    }
}
