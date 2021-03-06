//
//  ViewController.swift
//  RSSReader
//
//  Created by Andrii Pyvovarov on 1/20/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit
import SafariServices

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var cellId = "cellId"
    let url = "https://www.wired.com/feed/rss"
    var searchActive : Bool = false
    private var books : [Book]?
    private var filteredBooks : [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DetailBookTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
        searchControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        navBar()
    }
    private func invalidAllertController(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    private func searchControl()  {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Feed Search"
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor.white
        definesPresentationContext = true
    }
    private func navBar(){
        navigationItem.title = "Reader"
        let nav = self.navigationController?.navigationBar
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "CourierNewPS-BoldItalicMT", size: 24)!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchData))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white

    }
    
    @objc func fetchData(){
        NetworkManager.isReachable { (_) in
            let bookParser = BookParser()
            bookParser.parseBook(url: self.url) { (books) in
                self.books = books
                OperationQueue.main.addOperation {
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
                }
            }
        }
        NetworkManager.isUnreachable { (_) in
            self.invalidAllertController(title: "Invalid Internet", message: "No internet access exist. Try again later")
        }
    }
    
    
    private func searchBarIsEmpty() -> Bool {
    // Returns true if the text is empty or nil
    return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredBooks = books?.filter({( book : Book) -> Bool in
            return book.title!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    private func arrayData() -> [Book]? {
        return isFiltering() ? filteredBooks : books
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books = books else {
            return 0
        }
        if isFiltering(){
            return filteredBooks!.count
        }
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! DetailBookTableViewCell
        if isFiltering(){
            if let item = filteredBooks?[indexPath.item] {
                cell.item = item
            }
        } else {
            if let item = books?[indexPath.item] {
                cell.item = item
               
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        let href = arrayData()![indexPath.row].url!

        let svc = SFSafariViewController(url: URL(string: href)!)

        DispatchQueue.main.async {
            tableView.reloadData()
        }

        self.present(svc, animated: true, completion: nil)
    }
  }

extension MainViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

