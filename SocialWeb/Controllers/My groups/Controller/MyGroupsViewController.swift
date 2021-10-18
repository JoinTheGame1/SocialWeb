import UIKit
import RealmSwift

final class MyGroupsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    let groupsService = GroupsService()
    let realmService = RealmService()
    let myId = MySession.shared.userId
    var myGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsService.getGroups(whom: self.myId) { [weak self] in
            guard let self = self else { return }
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL!)
                self.myGroups = Array(realm.objects(Group.self).filter("ownerId == %D", Int(self.myId) ?? 0))
                self.tableView.reloadData()
            } catch {
                print(error)
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
