import UIKit

protocol AppsViewControllerProtocol: LoadingPresentable {
    func showView(with apps: [App])
    func showErrorView(with message: String)
    func showRetryView()
    func showEmptyView()
    func hideEmptyView()
    func hideRetryView()
}

class AppsViewController: UITableViewController {

    var appsView: AppsView {
        return view as! AppsView
    }

    private let presenter: AppsPresenterProtocol
    private let searchedTerm: String

    init(searchedTerm: String, presenter: AppsPresenterProtocol = AppsPresenter()) {
        self.searchedTerm = searchedTerm
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.view = self
        self.appsView.delegate = self

        self.presenter.search(term: searchedTerm)

        navigationController?.navigationBar.barTintColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = AppsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
    }

}

extension AppsViewController: AppsViewControllerProtocol {
    func showView(with apps: [App]) {
        appsView.apps = apps
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

extension AppsViewController: AppsViewDelegate {

}
