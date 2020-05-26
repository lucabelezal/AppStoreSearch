import Foundation

protocol AutocompletePresenterProtocol: AnyObject {
    var view: AutocompleteViewControllerProtocol? { get set }
    func fetchSuggestions(basedOn searchText: String)
}

class AutocompletePresenter: AutocompletePresenterProtocol {

    var view: AutocompleteViewControllerProtocol?

    private let service: AutocompleteServiceProtocol

    init(service: AutocompleteServiceProtocol =  AutocompleteService()) {
        self.service = service
    }

    func fetchSuggestions(basedOn searchText: String) {
        service.fetchSuggestions(basedOn: searchText) { result in
            switch result {
            case let .success(terms):
                if terms.isEmpty {
                    self.view?.showEmptyView()
                } else {
                    self.view?.showView(with: terms)
                }
            case let .failure(error):
                self.view?.showErrorView(with: error.localizedDescription)
            }
        }
    }
}
