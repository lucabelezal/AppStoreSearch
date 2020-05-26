import UIKit

class AutocompleteCellView: UITableViewCell, Reusable {
    func set(term: String, searchedTerm: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 21),
            .foregroundColor: UIColor(white: 0.56, alpha: 1.0)
        ]
        let attributedString = NSAttributedString(
            string: term.lowercased(),
            attributes: attributes
        )
        let mutableAttributedString = NSMutableAttributedString(
            attributedString: attributedString
        )
        mutableAttributedString.setBold(text: searchedTerm.lowercased())
        textLabel?.attributedText = mutableAttributedString
        imageView?.image = UIImage(named: "search_term_icon")
    }
}

extension NSMutableAttributedString {
    public func setBold(text: String) {
        let foundRange = mutableString.range(of: text)
        if foundRange.location != NSNotFound {
            addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.black,
                range: foundRange
            )
        }
    }
}
