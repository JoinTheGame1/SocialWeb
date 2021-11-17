import UIKit
import RealmSwift

final class MyFriendsViewController: UIViewController{
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet weak var lettersControl: LettersControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let friendsService = FriendsService()
    private let realm = RealmService.shared.realm
    private var friends = [Friend]()
    private var realmFriends: Results<Friend>?
    private var sortedFriends = [[Friend]]()
    private var searchFriends = [Friend]()
    private var firstLetters = [String]()
    private var token: NotificationToken?
    private let myId = MySession.shared.userId
    private var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pairTableAndRealm()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FriendTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FriendTableViewCell.identifier)
    }
    
    private func pairTableAndRealm() {
        guard let realm = self.realm else { return }
        self.realmFriends = realm.objects(Friend.self)
        self.token = realmFriends?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                self.setFriends()
            case .update(_, _, _ , _):
                self.setFriends()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    private func setFriends() {
        guard let realmFriends = self.realmFriends else { return }
        self.friends = Array(realmFriends)
        self.addLettersControl()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc private func scrollToFriend() {
        let letter = lettersControl?.selectedLetter
        guard let firstFriendIndex = sortedFriends.firstIndex(where: {String($0.first?.lastName.prefix(1) ?? "") == letter})
        else { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: firstFriendIndex),
                              at: .top, animated: true)
    }
    
    private func addLettersControl() {
        let friends = self.friends.sorted(by: {$0.lastName < $1.lastName})
        getFirstLetters(friends)
        lettersControl.setLetters(firstLetters)
        lettersControl.addTarget(self, action: #selector(scrollToFriend), for: .valueChanged)
        sortedFriends = sortByLetter(friends, firstLetters: firstLetters)
        
    }
    
    private func getFirstLetters(_ friends: [Friend]){
        let friendsNames = friends.map{$0.lastName}
        self.firstLetters = Array(Set(friendsNames.map{String($0.prefix(1))})).sorted()
    }
    
    private func sortByLetter(_ friends: [Friend], firstLetters: [String]) -> [[Friend]]{
        var sortedFriends: [[Friend]] = []
        firstLetters.forEach { letter in
            let friendsForLetter = friends.filter { String($0.lastName.prefix(1)) == letter }
            sortedFriends.append(friendsForLetter)
        }
        return sortedFriends
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriendCollection" {
            let collectionView = segue.destination as? FriendCollectionViewController
            let indexPath = sender as! IndexPath
            collectionView?.friend = sortedFriends[indexPath.section][indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showFriendCollection", sender: indexPath)
    }
}

extension MyFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        searching ? 1 : sortedFriends.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searching ? searchFriends.count : sortedFriends[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell
        else { return UITableViewCell() }
        cell.configure(searching ? searchFriends[indexPath.row] : sortedFriends[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searching ? "TOP NAME MATCHES" : firstLetters[section]  
    }
}

extension MyFriendsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFriends = []
        if searchText == "" {
            searching = false
            lettersControl.isHidden = false
        }
        else {
            searching = true
            for section in sortedFriends {
                for lastname in section {
                    if lastname.lastName.uppercased().contains(searchText.uppercased()) {
                        searchFriends.append(lastname)
                    }
                }
            }
            lettersControl.isHidden = true
        }
        tableView.reloadData()
    }
}
