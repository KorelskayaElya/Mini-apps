//
//  ViewController.swift
//  Joke
//
//  Created by Эля Корельская on 17.11.2023.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    private var activityIndicator: UIActivityIndicatorView!
    private var searchResults: [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chuck Norris Jokes"
        searchBar.placeholder = "Search Jokes"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        
        setupActivityIndicator()
    }
    
    // MARK: - Private
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    @objc private func handleTap() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        
        cell.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1.0
        }
        
        return cell
    }
    
    // MARK: - Search bar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text, !query.isEmpty else {
            searchResults.removeAll()
            tableView.reloadData()
            return
        }
    }
    
    // MARK: - Perform search
    private func performSearch() {
        guard let query = searchBar.text, !query.isEmpty else {
            searchResults.removeAll()
            tableView.reloadData()
            return
        }
        
        activityIndicator.startAnimating()
        
        let model = Model()
        model.searchJokes(query: query) { [weak self] jokes in
            guard let self = self else { return }
            self.searchResults = jokes
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
