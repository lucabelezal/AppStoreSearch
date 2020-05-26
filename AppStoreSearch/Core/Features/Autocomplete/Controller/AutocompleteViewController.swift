import UIKit

protocol AutocompleteViewControllerProtocol {
    func showView(with terms: [Term])
    func showErrorView(with message: String)
    func showRetryView()
    func showEmptyView()
    func hideEmptyView()
    func hideRetryView()
}

class AutocompleteViewController: UIViewController {

    weak var delegate: SearchViewControllerProtocol?

    var autocompleteView: AutocompleteView {
        return view as! AutocompleteView
    }

    let presenter: AutocompletePresenterProtocol
    let searchedTerm: String

    init(searchedTerm: String, presenter: AutocompletePresenterProtocol = AutocompletePresenter()) {
        self.searchedTerm = searchedTerm
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
        self.autocompleteView.delegate = self
        self.presenter.fetchSuggestions(basedOn: searchedTerm)

        navigationController?.navigationBar.barTintColor = .white
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = AutocompleteView()
    }
}

extension AutocompleteViewController: AutocompleteViewControllerProtocol {
    func showView(with terms: [Term]) {
        autocompleteView.viewModel = AutocompleteViewModel(terms: terms, searchedTerm: searchedTerm)
    }

    func showErrorView(with message: String) {

    }

    func showRetryView() {

    }

    func showEmptyView() {

    }

    func hideEmptyView() {

    }

    func hideRetryView() {

    }
}

extension AutocompleteViewController: AutocompleteViewDelegate {

    func didSelect(suggestion: String) {
        delegate?.search(term: suggestion)
    }
}
