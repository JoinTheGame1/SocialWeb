import UIKit

final class MyFriendsViewController: UIViewController{
    @IBOutlet private var tableView: UITableView!
    @IBOutlet weak var lettersControl: LettersControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sortedFriends = [[FriendModel]]()
    var searchFriends = [FriendModel]()
    var firstLetters = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLettersControl()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FriendTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FriendTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func scrollToCity() {
        let letter = lettersControl?.selectedLetter
        guard let firstFriendIndex = sortedFriends.firstIndex(where: {String($0.first?.lastName.prefix(1) ?? "") == letter})
        else { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: firstFriendIndex),
                              at: .top, animated: true)
    }
    
    private func addLettersControl() {
        let friends = FriendStorage.shared.friends.sorted(by: {$0.lastName < $1.lastName})
        getFirstLetters(friends)
        lettersControl.setLetters(firstLetters)
        lettersControl.addTarget(self, action: #selector(scrollToCity), for: .valueChanged)
        sortedFriends = sortByLetter(friends, firstLetters: firstLetters)
        
    }
    
    func getFirstLetters(_ friends: [FriendModel]){
        let friendsNames = friends.map{$0.lastName}
        self.firstLetters = Array(Set(friendsNames.map{String($0.prefix(1))})).sorted()
    }
    
    func sortByLetter(_ friends: [FriendModel], firstLetters: [String]) -> [[FriendModel]]{
        var sortedFriends: [[FriendModel]] = []
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
