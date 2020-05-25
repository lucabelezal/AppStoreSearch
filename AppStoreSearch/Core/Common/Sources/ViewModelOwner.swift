import Foundation

public protocol ViewModelOwner {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
    var isSelected: Bool { get set }
}
