import UIKit
import RealmSwift

final class MyGroupsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    private let groupsService = GroupsService()
    private let realm = RealmService.shared.realm
    private let myId = MySession.shared.userId
    private var myGroups = [Group]()
    private var token: NotificationToken?
    private var realmGroups: Results<Group>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairTableAndRealm()
        tableView.register(UINib(nibName: GroupCell.identifier, bundle: nil), forCellReuseIdentifier: GroupCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    private func unfollowGroup(_ group: Group) {
        do {
            realm?.beginWrite()
            realm?.delete(group)
            try realm?.commitWrite()
        } catch {
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func pairTableAndRealm() {
        guard let realm = self.realm else { return }
        self.realmGroups = realm.objects(Group.self)
        self.token = realmGroups?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self,
                  let tableView = self.tableView
            else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realmGroups?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        guard let group = realmGroups?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configure(group)
        cell.buttonUnfollowGroup = { _ in
            self.unfollowGroup(group)
        }
        return cell
    }
}
