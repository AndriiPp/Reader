//
//  DetailBookTableViewCell.swift
//  RSSReader
//
//  Created by Andrii Pyvovarov on 1/20/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class DetailBookTableViewCell : UITableViewCell {
    private var  url : String?
    var item : Book! {
        didSet{
            title.text = item.title
            keyWords.text = item.keyWords
            category.text = item.category
            publisher.text = item.creator
            descriptionBook.text = item.descriptionBook
            dateOfRelease.text = item.pubDate
            url = item.url
        }
    }
    let title : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdasdfs WEJKQ jfwei jwe fjw ed"
        return label
    }()
    let keyWords : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdasdfs FAJFI OAF AO  OFQW OQEDFQWE"
        return label
    }()
    let category : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdasdfs "
        return label
    }()

    let publisher : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdasdfs"
        return label
    }()
    
    let descriptionBook : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdasdfs wjed jwed jwed wejd wejdw edje qdjqd"
        return label
    }()
    let dateOfRelease : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdasdfs"
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        addSubview(publisher)
        addSubview(dateOfRelease)
        addSubview(keyWords)
        addSubview(descriptionBook)
        addSubview(category)
        
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        keyWords.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        keyWords.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        keyWords.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        keyWords.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        category.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        category.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        category.topAnchor.constraint(equalTo: keyWords.bottomAnchor, constant: 8).isActive = true
        category.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        publisher.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        publisher.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        publisher.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 8).isActive = true
        publisher.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        descriptionBook.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -26).isActive = true
        descriptionBook.topAnchor.constraint(equalTo:publisher.bottomAnchor, constant : 10).isActive = true
        descriptionBook.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        descriptionBook.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        dateOfRelease.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        dateOfRelease.topAnchor.constraint(equalTo: descriptionBook.bottomAnchor, constant: 8).isActive = true
        dateOfRelease.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


