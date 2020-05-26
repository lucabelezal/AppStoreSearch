import UIKit

class SearchHeaderView: UIView {

    let titleLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchHeaderView: ViewCodable {
    func configure() {

    }

    func buildHierarchy() {
        addView(titleLabel)
    }

    func buildConstraints() {
        titleLabel.layout.makeConstraints { make in
            make.centerY.equalTo(layout.centerY)
            make.left.equalTo(layout.left, constant: 16)
        }
    }

    func render() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.text = "Trending"
    }
}
