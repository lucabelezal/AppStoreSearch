import UIKit

class SuggestedTermsTableViewController: UITableViewController {
    var searchedTerm = String() {
        didSet {
            currentNames = namesWith(prefix: searchedTerm)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.register(cellType: SuggestedTermTableViewCell.self)
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.barTintColor = .white
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var terms: [Term] = Bundle(for: SuggestedTermsTableViewController.self).loadJSONFile(named: "terms")
    private var currentNames = [String]()
    var didSelect: ((String) -> Void)?

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return currentNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SuggestedTermTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.set(term: currentNames[indexPath.row], searchedTerm: searchedTerm)
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(currentNames[indexPath.row])
    }

    func namesWith(prefix: String) -> [String] {
        return terms.filter { $0.name.hasCaseInsensitivePrefix(string: prefix) }
            .sorted { $0.popularity > $1.popularity }
            .map { $0.name }
    }
}

class SuggestedTermsTableViewPresenter {}
