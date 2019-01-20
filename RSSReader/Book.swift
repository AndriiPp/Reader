//
//  Book.swift
//  RSSReader
//
//  Created by Andrii Pyvovarov on 1/20/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

class Book: NSObject {
        var title : String?
        var keyWords : String?
        var category : String?
        var creator : String?
        var descriptionBook : String?
        var pubDate : String?
        var url : String?
    
    init(title: String, keyWords: String, category: String, creator: String, descriptionBook: String, pubDate: String, url: String) {
        self.title = title
        self.keyWords = keyWords
        self.category = category
        self.creator = creator
        self.descriptionBook = descriptionBook
        self.pubDate = pubDate
        self.url = url
    }
}
