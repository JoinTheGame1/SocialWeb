//
//  AllGroupsViewController.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import UIKit

final class AllGroupsViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var allGroups = Array(Set(GroupStorage.allGroups).subtracting(GroupStorage.myGroups))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: AllGroupsCell.identifier, bundle: nil), forCellReuseIdentifier: AllGroupsCell.identifier)
        allGroups.sort(by: {$0.name < $1.name})
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func followGroup(_ row: Int) {
        let group = allGroups.remove(at: row)
        GroupStorage.myGroups.append(group)
        tableView.reloadData()
    }
}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllGroupsCell.identifier, for: indexPath) as! AllGroupsCell
        cell.configure(allGroups[indexPath.row])
        cell.buttonFollowGroup = { _ in
            self.followGroup(indexPath.row)
        }
        return cell
    }
}



