//
//  XMLParser.swift
//  RSSReader
//
//  Created by Andrii Pyvovarov on 1/20/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

class BookParser : NSObject, XMLParserDelegate {
    private var books : [Book] = []
    private var currentElement = ""
    
    private var currentTitle : String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentKeyWords : String = ""{
        didSet {
            currentKeyWords = currentKeyWords.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentCategory : String = ""{
        didSet {
            currentCategory = currentCategory.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentCreator : String = ""{
        didSet {
            currentCreator = currentCreator.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescriptionBook : String = ""{
        didSet {
            currentDescriptionBook = currentDescriptionBook.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentImageUrl : String = ""{
        didSet {
            currentImageUrl = currentImageUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentUrl : String = ""{
        didSet {
            currentUrl = currentUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPubDate : String = ""{
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var parseCompletionHandler: (([Book]) -> Void)?
    
    
    func parseBook(url : String, completionHandler : (([Book]) -> Void)?){
        
        self.parseCompletionHandler = completionHandler
        let requestResource = Resource(baseURL: url, method: Method.GET){(response) -> Data? in
            return(response)
        }
        // Make the request
        let requestClient = HTTPClient()
        requestClient.apiRequest(resource: requestResource, failure: { (response, data) in
            print(response)
            
        }) { (response) in
            let parser = XMLParser(data: response)
            parser.delegate = self
            parser.parse()
        }

    }
    // MARK :- XML Parser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescriptionBook = ""
            currentUrl = ""
            currentPubDate = ""
            currentCategory = ""
            currentKeyWords = ""
            currentCreator = ""
                }
            }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescriptionBook += string
        case "link": currentUrl += string
        case "pubDate": currentPubDate += string
        case "category": currentCategory = "Category: " + string
        case "media:keywords": currentKeyWords += string
        case "dc:creator": currentCreator = "Author: " + string
        default: break

        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let book = Book(title: currentTitle, keyWords: currentKeyWords, category: currentCategory, creator: currentCreator, descriptionBook: currentDescriptionBook, pubDate: currentPubDate, url: currentUrl)
            self.books.append(book)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parseCompletionHandler?(books)
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
