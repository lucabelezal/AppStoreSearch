import UIKit

extension UIViewController {
    func addChildViewController(_ child: UIViewController) {
        addChild(child)
        child.view.centerIn(view: view)
        child.didMove(toParent: self)
    }

    func removeChildViewController() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

//public class ViewController: UIViewController {
//    private var currentController: UIViewController?
//
//    public func show(childViewController viewController: UIViewController) {
//        if let lastController = currentController {
//            remove(asChildViewController: lastController)
//        }
//
//        addChild(viewController)
//        view.addSubview(viewController.view)
//
//        viewController.view.frame = view.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        viewController.didMove(toParent: self)
//
//        currentController = viewController
//    }
//
//    public func remove(asChildViewController viewController: UIViewController) {
//        viewController.willMove(toParent: nil)
//        viewController.view.removeFromSuperview()
//        viewController.removeFromParent()
//    }
//}
