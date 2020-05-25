import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        child.view.centerIn(view: view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
