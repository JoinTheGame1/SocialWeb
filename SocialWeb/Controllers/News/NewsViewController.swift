//
//  NewsViewController.swift
//  SocialWeb
//
//  Created by Никитка on 30.10.2021.
//

import UIKit

class NewsViewController: UIViewController {
    private let newsService = NewsService()
    private var news = [NewsItem]()
    private var profiles = [Friend]()
    private var groups = [Group]()
    private var nextFrom = ""
    private var isLoading = false
    
    private let tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .insetGrouped)
        table.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.identifier)
        table.register(NewsImageCell.self, forCellReuseIdentifier: NewsImageCell.identifier)
        table.register(NewsAuthorAndDateCell.self, forCellReuseIdentifier: NewsAuthorAndDateCell.identifier)
        table.register(BottomButtonsCell.self, forCellReuseIdentifier: BottomButtonsCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .clear
        return table
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        view.addSubview(tableView)
        self.tableView.addSubview(self.refreshControl)
        setupTableView()
        getNews()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
    
    private func getNews() {
        self.newsService.getDataNews()
            .then(on: DispatchQueue.global(), newsService.getParsedData(_:))
            .get({ response in
                self.nextFrom = response.nextFrom ?? ""
            })
            .then(on: DispatchQueue.global(), newsService.getNews(_:))
            .done(on: DispatchQueue.main) { [weak self] news in
                guard let self = self else { return }
                self.news = news
                self.tableView.reloadData()
            }
            .catch { error in
                print(error.localizedDescription)
            }
    }
    
    @objc private func refresh() {
        self.getNews()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func setupTableView() {
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            guard
                let urls = news[indexPath.section].photosURL,
                !urls.isEmpty
            else {
                return 0
            }
            
            let width = view.frame.width
            let post = news[indexPath.section]
            let cellHeight = width * post.aspectRatio
            return cellHeight
        }
        else if indexPath.row == 1 {
            if news[indexPath.section].text.isEmpty {
                return 0
            }
            return UITableView.automaticDimension
        }
        else {
            return UITableView.automaticDimension
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        let post = news[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAuthorAndDateCell", for: indexPath) as!
                NewsAuthorAndDateCell
            let date = post.getStringDate()
            guard let urlImage = post.photoURL,
                  let authorName = post.authorName
            else { return UITableViewCell() }
            cell.configure(authorName: authorName, photoURL: urlImage, date: date)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
            cell.configure(with: post.text)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
            guard let photoURL = post.photosURL?.first else { return UITableViewCell() }
            cell.configure(with: photoURL)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomButtonsCell", for: indexPath) as! BottomButtonsCell
            cell.configure(news: post)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else {
            return
        }

        if maxSection > news.count - 3, !isLoading {
            isLoading = true

            self.newsService.getDataNews(self.nextFrom)
                .then(on: DispatchQueue.global(), newsService.getParsedData(_:))
                .get({ response in
                    self.nextFrom = response.nextFrom ?? ""
                })
                .then(on: DispatchQueue.global(), newsService.getNews(_:))
                .done(on: DispatchQueue.main) { [weak self] news in
                    guard let self = self else { return }
                    let indexSet = IndexSet(integersIn: self.news.count..<self.news.count + news.count)
                    self.news.append(contentsOf: news)
                    self.tableView.insertSections(indexSet, with: .automatic)
                }.ensure {
                    self.isLoading = false
                }.catch { error in
                    print(error)
                }
        }
    }
}
