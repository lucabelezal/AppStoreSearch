import Foundation

public extension String {
    var toURL: URL? {
        return URL(string: self)
    }
}
