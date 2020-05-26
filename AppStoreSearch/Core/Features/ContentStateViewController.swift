import UIKit

class ContentStateViewController: UIViewController {
    private var state: UIState?
    var shownViewController: UIViewController?

    func transition(to newState: UIState) {
        shownViewController?.removeChildViewController()
        let viewController = createViewController(for: newState)
        addChildViewController(viewController)
        shownViewController = viewController
        state = newState
        view.backgroundColor = .lightGray
    }
}

private extension ContentStateViewController {
    func createViewController(for state: UIState) -> UIViewController {
        switch state {
        case let .render(viewController):
            return viewController
        case let .retry(error):
            print(error)
            return UIViewController()
        case .empty:
            return UIViewController()
        case .notFound:
            return UIViewController()
        }
    }
}

extension ContentStateViewController {
    enum UIState {
        case render(viewController: UIViewController)
        case retry(message: String)
        case notFound
        case empty
    }
}

//case productList(viewModel: ProductListViewModel)
//case autocomplete(suggestions: [String])
//case retry(error: PrintableError)
//case empty
//case notFound
