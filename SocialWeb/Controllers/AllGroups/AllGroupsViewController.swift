//
//  AllGroupsViewController.swift
//  SocialWeb
//
//  Created by Никитка on 11.06.2021.
//

import UIKit
import RealmSwift

final class AllGroupsViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let searchGroupsService = GroupsService()
    private let realm = RealmService.shared.realm
    private var searchGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: AllGroupsCell.identifier, bundle: nil), forCellReuseIdentifier: AllGroupsCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func followGroup(_ row: Int) {
        guard let realm = self.realm else { return }
        let group = searchGroups.remove(at: row)
        do {
            realm.beginWrite()
            realm.add(group)
            try realm.commitWrite()
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: AllGroupsCell.identifier, for: indexPath) as! AllGroupsCell
        cell.configure(searchGroups[indexPath.row])
        cell.buttonFollowGroup = { _ in
            self.followGroup(indexPath.row)
        }
        return cell
    }
}

extension AllGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchGroups = []
            self.tableView.reloadData()
        }
        else {
            searchGroupsService.getSearchGroups(with: searchText) { result in
                switch result {
                case .failure(.decodeError):
                    print("Decode error...")
                case .failure(.notData):
                    print("Have no data...")
                case .failure(.serverError):
                    print("Server error...")
                case .success(let groups):
                    self.searchGroups = groups
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}


