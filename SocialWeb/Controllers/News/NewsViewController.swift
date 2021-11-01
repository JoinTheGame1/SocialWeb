//
//  NewsViewController.swift
//  SocialWeb
//
//  Created by Никитка on 30.10.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.identifier)
        table.register(NewsImageCell.self, forCellReuseIdentifier: NewsImageCell.identifier)
        table.estimatedRowHeight = 50
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 1 {
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
            cell.configure(with: "https://sun9-66.userapi.com/impf/c857528/v857528700/e204d/bklJmJGn0E4.jpg?size=2048x1444&quality=96&sign=b7850b084c197d27980a746de03ad04e&type=album")
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
            cell.configure(with: "HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!HELLO!")
            
            return cell
        }
    }
}

