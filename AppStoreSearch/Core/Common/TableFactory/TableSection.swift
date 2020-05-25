import UIKit

public protocol TableSection {

    typealias HeaderFactory = (UITableView) -> UIView?
    typealias CellFactory = ((UITableView, IndexPath) -> UITableViewCell)

    var title: String? { get }
    var numberOfRows: Int { get }
    var headerHeight: CGFloat { get }
    var headerFactory: HeaderFactory { get }
    var cellFactory: CellFactory { get }
    var registerCell: (UITableView) -> Void { get }

    func separatorInset(for indexPath: IndexPath) -> UIEdgeInsets
    func didSelectRow(for indexPath: IndexPath)
}

extension TableSection {

    // MARK: - Option Properties

    public var title: String? {
        return nil
    }

    public var headerHeight: CGFloat {
        return 0
    }

    public var headerFactory: HeaderFactory {
        return { _ in
            return nil
        }
    }

    // MARK: - Option Methods

    public func separatorInset(for indexPath: IndexPath) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    public func didSelectRow(for indexPath: IndexPath) {}
}
