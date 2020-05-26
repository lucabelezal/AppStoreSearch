import UIKit

class ResultsContainerViewController: ContentStateViewController {

    weak var delegate: SearchViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func handle(term: String, searchType: SearchType) {
        switch searchType {
        case .suggestions:
            let suggestionsViewController = AutocompleteViewController(searchedTerm: term)
            suggestionsViewController.delegate = delegate
            transition(to: .render(viewController: suggestionsViewController))

        case .apps:
            let appsListViewController = AppsViewController(searchedTerm: term)
            transition(to: .render(viewController: appsListViewController))
        }
    }
}
