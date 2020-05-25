import Foundation

extension String {

    func hasCaseInsensitivePrefix(string: String) -> Bool {
        return prefix(string.count).caseInsensitiveCompare(string) == .orderedSame
    }
}
