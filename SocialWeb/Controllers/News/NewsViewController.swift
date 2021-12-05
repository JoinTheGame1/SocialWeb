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
    }
    
    private func getNews() {
        self.newsService.getNews()
            .done { newsItem in
                self.news = newsItem.items
                self.profiles = newsItem.profiles
                self.groups = newsItem.groups
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
            let newsItem = news[indexPath.section]
            guard let image = newsItem.attachments?[0].photo else { return UITableView.automaticDimension}
            let size = image.sizes.last
            
            let imageWidth = CGFloat(size?.width ?? 0)
            let imageHeight = CGFloat(size?.height ?? 0)
            guard imageWidth > 0 && imageHeight > 0 else { return UITableView.automaticDimension }
            let requiredWidth = tableView.frame.width
            let widthRatio = requiredWidth / imageWidth
            let requiredHeight = imageHeight * widthRatio
            return requiredHeight
        }
        else { return UITableView.automaticDimension }
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
        let news = news[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAuthorAndDateCell", for: indexPath) as!
                NewsAuthorAndDateCell
            let date = news.getStringDate()
            let profiles: [ProfileRepresentable] = news.sourceId >= 0 ? profiles : groups
            let sourceId = news.sourceId >= 0 ? news.sourceId : -news.sourceId
            let profileRepresentable = profiles.first { profiles -> Bool in
                profiles.id == sourceId
            }
            
            cell.configure(profile: profileRepresentable, date: date)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
            cell.configure(with: news.text)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
            cell.configure(with: news.attachments?[0].photo)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomButtonsCell", for: indexPath) as! BottomButtonsCell
            cell.layer.cornerRadius = 25
            cell.layer.masksToBounds = true
            cell.configure(news: news)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
