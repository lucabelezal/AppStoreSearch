import UIKit

public protocol SearchViewControllerProtocol: class {
    func showView(with terms: [String])
    func showErrorView(with message: String)
    func showRetryView()
    func showEmptyView()
    func hideEmptyView()
    func hideRetryView()

    func search(term: String)
}

class SearchViewController: UITableViewController, LoadingPresentable {

//    var searchView: SearchView {
//        return view as! SearchView
//    }

    var searchView = SearchView(frame: CGRect(x: .zero, y: .zero,
                                              width: UIScreen.main.bounds.width,
                                              height:  UIScreen.main.bounds.height))

    private var searchController: UISearchController?
    private let resultsContainerViewController =  ResultsContainerViewController()

    private var searchType: SearchType = .apps
    private var presenter: SearchPresenterProtocol

    init(presenter: SearchPresenterProtocol = SearchPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
        self.searchView.delegate = self
        self.presenter.fetchTerms()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        //view = SearchView()
        view.backgroundColor = .white
        tableView.tableHeaderView = searchView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSearchController()
    }

    private func setSearchController() {
        resultsContainerViewController.delegate = self

        searchController = UISearchController(searchResultsController: resultsContainerViewController)
        searchController?.searchBar.delegate = self
        searchController?.searchBar.placeholder = "Search"
        searchController?.searchResultsUpdater = self

        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true

        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.setShadow(hidden: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = "Search"

        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        searchType = searchText.isEmpty ? .apps : .suggestions
        navigationController?.navigationBar.setShadow(hidden: searchText.isEmpty)
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        navigationController?.navigationBar.setShadow(hidden: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        search(term: text)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        resultsContainerViewController.handle(term: text, searchType: searchType)
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    func showView(with terms: [String]) {
        searchView.terms = terms
    }

    func showErrorView(with message: String) {}

    func showRetryView() {}

    func showEmptyView() {}

    func hideEmptyView() {}

    func hideRetryView() {}

    func search(term: String) {
        searchController?.searchBar.text = term
        searchType = .apps
        searchController?.isActive = true
        searchController?.searchBar.resignFirstResponder()
        navigationController?.navigationBar.setShadow(hidden: false)
    }
}

extension SearchViewController: SearchViewDelegate {
    func didSelectSearch(term: String) {
        search(term: term)
    }
}
