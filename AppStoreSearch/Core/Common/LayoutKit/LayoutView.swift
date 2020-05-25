import UIKit

public extension LayoutView {

    var layout: LayoutViewConstraint {
        return LayoutViewConstraint(view: self)
    }

    @available(*, deprecated)
    func add(_ subviews: UIView...) {
        subviews.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func addView(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

}
