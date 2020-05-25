import Foundation

public class LayoutConstraintItem: LayoutConstraintItemable, LayoutConstraintItemConfigurable {

    internal let attribute: LayoutAttribute
    internal let view: LayoutView
    internal let isSafeArea: Bool

    internal required init(view: LayoutView, attribute: LayoutAttribute) {
        self.view = view
        self.attribute = attribute
        self.isSafeArea = false
    }

}
