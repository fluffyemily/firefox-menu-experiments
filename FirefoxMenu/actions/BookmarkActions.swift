//
//  AddBookmarkAction.swift
//  FirefoxMenu
//
//  Created by Emily Toop on 2/26/16.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation

protocol BookmarkAction: Action {
    func performActionWithProfile(profile: Profile)
}

struct AddBookmarkAction: BookmarkAction {
    init() { }
    func performActionWithProfile(profile: Profile) {
        print("Action: Add Bookmark")
        profile.addBookmark()
    }
}

struct RemoveBookmarkAction: Action {
    init() { }
    
    func performActionWithProfile(profile: Profile) {
        print("Action: Remove Bookmark")
        profile.removeBookmark()
    }
}
