import UIKit

final class MyGroupsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    let groupsAPI = GroupsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsAPI.getGroups()
        
        tableView.register(UINib(nibName: GroupCell.identifier, bundle: nil), forCellReuseIdentifier: GroupCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GroupStorage.myGroups.sort(by: {$0.name < $1.name})
        self.tableView.reloadData()
    }
    
    func unfollowGroup(_ row: Int) {
        GroupStorage.myGroups.remove(at: row)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GroupStorage.myGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        cell.configure(GroupStorage.myGroups[indexPath.row])
        cell.buttonUnfollowGroup = { _ in
            self.unfollowGroup(indexPath.row)
        }
        return cell
    }
}
