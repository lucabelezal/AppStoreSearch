import UIKit

class ContentStateViewController: UIViewController {
    private var state: State?
    var shownViewController: UIViewController?

    func transition(to newState: State) {
        shownViewController?.remove()
        let viewController = createViewController(for: newState)
        add(viewController)
        shownViewController = viewController
        state = newState
        view.backgroundColor = .lightGray
    }
}

private extension ContentStateViewController {
    func createViewController(for state: State) -> UIViewController {
        switch state {
        case .loading:
            let loadingViewController = UIViewController()
            loadingViewController.title = "loading"
            loadingViewController.view.backgroundColor = .green
            return loadingViewController

        case let .render(viewController):
            return viewController
        case .error:
            return UIViewController()
        case .empty:
            return UIViewController()
        }
    }
}

extension ContentStateViewController {
    enum State {
        case loading
        case error
        case empty
        case render(UIViewController)
    }
}
