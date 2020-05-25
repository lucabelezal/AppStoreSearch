import Foundation

public protocol LayoutConstraintItemable { }

internal protocol LayoutConstraintItemConfigurable {
    var attribute: LayoutAttribute { get }
    var view: LayoutView { get }
    var isSafeArea: Bool { get }
}
