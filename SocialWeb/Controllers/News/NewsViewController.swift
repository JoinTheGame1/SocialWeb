//
//  NewsViewController.swift
//  SocialWeb
//
//  Created by Никитка on 30.10.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let news: [NewsTestModel] = [
        NewsTestModel(authorName: "Nikita Rylskiy",
                      avatarImageUrl: "https://sun9-66.userapi.com/impf/c857528/v857528700/e204d/bklJmJGn0E4.jpg?size=2048x1444&quality=96&sign=b7850b084c197d27980a746de03ad04e&type=album",
                      image: "https://sun9-66.userapi.com/impf/c857528/v857528700/e204d/bklJmJGn0E4.jpg?size=2048x1444&quality=96&sign=b7850b084c197d27980a746de03ad04e&type=album",
                      date: "25.10.2020",
                      text: "HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!HELLLLLLLO!!!!",
                      like: TestLike(likes: 10, liked: true),
                      comment: 11,
                      repost: TestRepost(reposts: 12, reposted: false)),
        NewsTestModel(authorName: "Julia Sadrieva",
                      avatarImageUrl: "https://sun9-79.userapi.com/impg/A89QgnUnjTSTO4NSrFZCBp7ZglYLBJq7yJradg/mcHEGNMtFRo.jpg?size=853x1280&quality=96&sign=ecab7d4a462ac0210f454688bd13eab7&type=album",
                      image: "https://sun9-79.userapi.com/impg/A89QgnUnjTSTO4NSrFZCBp7ZglYLBJq7yJradg/mcHEGNMtFRo.jpg?size=853x1280&quality=96&sign=ecab7d4a462ac0210f454688bd13eab7&type=album",
                      date: "267.392.1002",
                      text: "JULIA",
                      like: TestLike(likes: 320, liked: true),
                      comment: 190,
                      repost: TestRepost(reposts: 129, reposted: true)),
        NewsTestModel(authorName: "CAMEN'",
                      avatarImageUrl: "https://sun9-3.userapi.com/impf/c855320/v855320277/b272a/KElX0FcI9Tk.jpg?size=1078x1078&quality=96&sign=64a6ccc43609c64dbd2af2adabe5afa2&type=album",
                      image: "https://sun9-3.userapi.com/impf/c855320/v855320277/b272a/KElX0FcI9Tk.jpg?size=1078x1078&quality=96&sign=64a6ccc43609c64dbd2af2adabe5afa2&type=album",
                      date: "37821.4128412.31289",
                      text: "dkwqlmdkqwmqwkqlwmdqkwmdlkqwmkdmqwmdkqklmwdmkqkmwdmkqkmwklmqklmwdlmkqlkmwdklmqlkmdkmqmwdkmlqwlmkdmklqwkmdmkqwklmdlmqkwmkdkmqwkmdmqklwdlkmklmqw",
                      like: TestLike(likes: 1000, liked: false),
                      comment: 1100,
                      repost: TestRepost(reposts: 1200, reposted: false))
    ]
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.identifier)
        table.register(NewsImageCell.self, forCellReuseIdentifier: NewsImageCell.identifier)
        table.register(NewsAuthorAndDateCell.self, forCellReuseIdentifier: NewsAuthorAndDateCell.identifier)
        table.register(BottomButtonsCell.self, forCellReuseIdentifier: BottomButtonsCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        table.separatorColor = UIColor.clear
        table.sectionFooterHeight = 20
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "loginBackground2")
        view.addSubview(tableView)
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 3 == 2 {
            let image = UIImage(named: "Einstein")
            
            let imageWidth = image?.size.width ?? 0
            let imageHeight = image?.size.height ?? 0
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
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsAuthorAndDateCell", for: indexPath) as! NewsAuthorAndDateCell
            let author = news[indexPath.section]
            cell.configure(with: author.avatarImageUrl, authorName: author.authorName, date: author.date)
            
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
            let author = news[indexPath.section]
            cell.configure(with: author.text)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
            let author = news[indexPath.section]
            cell.configure(with: author.image)
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomButtonsCell", for: indexPath) as! BottomButtonsCell
            let author = news[indexPath.section]
            cell.configure(with: author.like, comments: author.comment, repost: author.repost)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
