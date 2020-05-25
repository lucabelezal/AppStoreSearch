import UIKit

class SearchViewController: UITableViewController, LoadingPresentable {

//    private lazy var searchController: UISearchController = {
//        let controller = UISearchController(searchResultsController: resultsContainerViewController)
//        resultsContainerViewController.didSelect = search
//        controller.searchBar.delegate = self
//        controller.searchBar.placeholder = "Search"
//        controller.searchResultsUpdater = self
//        return controller
//    }()

    private var searchController: UISearchController!

    private let resultsContainerViewController =  ResultsContainerViewController()

    private var searchType: SearchType = .apps
    private let terms = ["instagram", "snapchat", "twitter", "design+code", "amazon", "tinder", "ted"]

    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        setSearchController()
        navigationController?.navigationBar.setShadow(hidden: true)

        tableView.register(cellType: SearchViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self

        let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: 60)))
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.text = "Trending"
        headerView.addView(titleLabel)
        titleLabel.layout.makeConstraints { make in
            make.centerY.equalTo(headerView.layout.centerY)
            make.left.equalTo(headerView.layout.left, constant: 16)
        }

        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()

        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.automaticallyAdjustsScrollIndicatorInsets = false


        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.largeTitleDisplayMode = .always

        navigationController?.navigationBar.topItem?.title = "Search"
        navigationItem.largeTitleDisplayMode = .automatic
        //navigationItem.hidesSearchBarWhenScrolling = true

        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }

    private func setSearchController() {
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        definesPresentationContext = true

        searchController = UISearchController(
            searchResultsController: resultsContainerViewController
        )
        resultsContainerViewController.didSelect = search
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func search(term: String) {
        searchController.searchBar.text = term
        searchType = .apps
        searchController.isActive = true
        searchController.searchBar.resignFirstResponder()
        navigationController?.navigationBar.setShadow(hidden: false)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        searchType = searchText.isEmpty ? .apps : .suggestions
        navigationController?.navigationBar.setShadow(hidden: searchText.isEmpty)
//        navigationController?.navigationBar.setShadow(hidden: true)
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.isTranslucent = true
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        navigationController?.navigationBar.setShadow(hidden: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        navigationController?.navigationBar.setShadow(hidden: true)
        guard let text = searchBar.text else { return }
        search(term: text)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        resultsContainerViewController.handle(
            term: text,
            searchType: searchType
        )
    }
}

// UITableViewDataSource
extension SearchViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return terms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.text = terms[indexPath.row]
        return cell
    }
}

// UITableViewDelegate
extension SearchViewController {
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        search(term: terms[indexPath.row])
    }
}

class SearchViewCell: UITableViewCell, Reusable {}
