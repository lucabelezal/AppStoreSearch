import UIKit

class ResultsContainerViewController: ContentStateViewController {
    private var suggestionsViewController = SuggestedTermsTableViewController(style: .plain)
    var didSelect: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        suggestionsViewController.didSelect = didSelect
    }

    func handle(term: String, searchType: SearchType) {
        switch searchType {
        case .suggestions:
            suggestionsViewController.searchedTerm = term
            transition(to: .render(suggestionsViewController))

        case .apps:
            let appsListViewController = AppsTableViewController()
            appsListViewController.search(term: term)
            transition(to: .render(appsListViewController))
        }
    }
}
