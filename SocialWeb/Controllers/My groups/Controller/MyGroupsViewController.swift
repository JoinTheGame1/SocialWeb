import UIKit

final class MyGroupsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    let groupsAPI = GroupsAPI()
    let myId = MySession.shared.userId
    var myGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsAPI.getGroups(whom: self.myId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(.decodeError):
                print("Decode error...")
            case .failure(.notData):
                print("Have no data...")
            case .failure(.serverError):
                print("Server error...")
            case .success(let groups):
                self.myGroups = groups
                self.tableView.reloadData()
            }
        }
        
        tableView.register(UINib(nibName: GroupCell.identifier, bundle: nil), forCellReuseIdentifier: GroupCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func unfollowGroup(_ row: Int) {
        myGroups.remove(at: row)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        cell.configure(myGroups[indexPath.row])
        cell.buttonUnfollowGroup = { _ in
            self.unfollowGroup(indexPath.row)
        }
        return cell
    }
}
