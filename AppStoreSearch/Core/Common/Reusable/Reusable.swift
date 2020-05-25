import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public typealias NibReusable = Reusable & NibLoadable

extension Reusable {

    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
