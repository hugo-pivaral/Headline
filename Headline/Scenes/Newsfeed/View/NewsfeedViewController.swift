//
//  NewsfeedNewsfeedViewController.swift
//  Headline
//
//  Created by Hugo Pivaral on 03/06/2022.
//  Copyright © 2022 Hugop.dev. All rights reserved.
//

import UIKit
import UITabControl

class NewsfeedViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var imageLoader: ImageLoader!
    var output: NewsfeedViewOutput!
    
    var articlesList: [ArticleViewModel] = [] {
        didSet {
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    var categories: [String] {
        Category.allCases.map { $0.rawValue.capitalized }
    }

    
    // MARK: Views
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.style = .large
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = UIColor(color: .contentSecondary)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.sectionHeaderTopPadding = 0
            tableView.contentInsetAdjustmentBehavior = .always
            tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
            
            let refreshControl = UIRefreshControl()
            tableView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        }
    }
    
    var tabControl: UITabControl! {
        didSet {
            tabControl.backgroundColor = UIColor(color: .backgroundPrimary)
            tabControl.addTarget(self, action: #selector(didTapTabControlTab(_:)), for: .valueChanged)
        }
    }
    
    
    // MARK: Actions
    
    @objc func didPullToRefresh() {
        output.didPullToRefresh()
    }
    
    @objc func didTapTabControlTab(_ sender: UITabControl) {
        guard let index = sender.selectedTabIndex,
              let category = Category(rawValue: categories[index].lowercased() ) else { return }
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 0.8
        }
        
        output.didSelectNewTab(with: category)
    }
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoader = ImageLoader()
        tabControl = UITabControl(tabs: Category.allCases.map { $0.rawValue.capitalized })
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = UIColor(color: .backgroundPrimary)
        output.viewIsReady()
    }
}


// MARK: Tableview Protocol

extension NewsfeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        25.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        output.willDisplayRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        return output.didSelectRow(with: articlesList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        
        let articleViewModel = articlesList[indexPath.row]
        cell.configure(with: articleViewModel, loader: imageLoader)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tabControl
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
        
        let dot = UIView()
        dot.translatesAutoresizingMaskIntoConstraints = false
        dot.backgroundColor = UIColor(color: .backgroundPrimary)
        
        return footer
    }
}

// MARK: NewsfeedView Input

extension NewsfeedViewController: NewsfeedViewInput {
    
    func setupInitialState() {
    }
    
    func showActivityIndicatorView() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicatorView() {
        activityIndicator.stopAnimating()
    }
    
    func setArticles(with list: [ArticleViewModel]) {
        UIView.transition(with: tableView,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            self?.articlesList = list
            self?.tableView.alpha = 1.0
        })
    }
    
    func appendArticles(with list: [ArticleViewModel]) {
        articlesList.append(contentsOf: list)
    }
}
