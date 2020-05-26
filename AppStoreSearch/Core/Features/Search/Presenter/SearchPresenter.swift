import Foundation

protocol SearchPresenterProtocol {
    var view: SearchViewControllerProtocol? { get set }
    func fetchTerms()
}

class SearchPresenter: SearchPresenterProtocol {

    weak var view: SearchViewControllerProtocol?
    
    private let service: SearchServiceProtocol

    init(service: SearchServiceProtocol = SearchService()) {
        self.service = service
    }

    func fetchTerms() {
        service.fetchTerms { result in
            switch result {
            case let .success(terms):
                self.view?.showView(with: terms)
            case let .failure(error):
                self.view?.showErrorView(with: error.localizedDescription)
            }
        }
    }
}
