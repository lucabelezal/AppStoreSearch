import Kingfisher
import UIKit

class AppCellView: UITableViewCell, Reusable {

    let iconImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let genreLabel: UILabel = UILabel()
    let downloadButton: UIButton = UIButton()
    let screenshotLeftImageView: UIImageView = UIImageView()
    let screenshotCenterImageView: UIImageView = UIImageView()
    let screenshotRightImageView: UIImageView = UIImageView()
    let screenshotStackView: UIStackView = UIStackView()

    var screenshotImageViews: [UIImageView]? {
        return screenshotStackView.arrangedSubviews as? [UIImageView]
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(app: App?) {
        if let app = app {
            nameLabel.text = app.name
            genreLabel.text = app.genre
            iconImageView.kf.setImage(with: URL(string: app.icon))
            for (index, screenshot) in app.screenshots.enumerated() {
                screenshotImageViews?[safe: index]?.kf.setImage(with: URL(string: screenshot))
            }
        }
    }

    func cancel() {
        iconImageView.kf.cancelDownloadTask()
        screenshotImageViews?.forEach { $0.kf.cancelDownloadTask() }
    }
}

extension AppCellView: ViewCodable {

    func configure() {
        screenshotStackView.contentMode = .scaleToFill
        screenshotStackView.axis = .horizontal
        screenshotStackView.alignment = .center
        screenshotStackView.distribution = .fillEqually
        screenshotStackView.spacing = 10
        selectionStyle = .none
    }

    func buildHierarchy() {
        addView(iconImageView, nameLabel, genreLabel, downloadButton, screenshotStackView)
        screenshotStackView.addArrangedSubview(screenshotLeftImageView)
        screenshotStackView.addArrangedSubview(screenshotCenterImageView)
        screenshotStackView.addArrangedSubview(screenshotRightImageView)
    }

    func buildConstraints() {

        iconImageView.layout.makeConstraints { make in
            make.top.equalTo(layout.top, constant: 16)
            make.left.equalTo(layout.left, constant: 16)
            make.width.equalTo(constant: 60)
            make.height.equalTo(constant: 60)
        }

        nameLabel.layout.makeConstraints { make in
            make.top.equalTo(layout.top, constant: 16)
            make.left.equalTo(iconImageView.layout.right, constant: 16)
            make.right.equalTo(downloadButton.layout.left, constant: -16)
            make.height.equalTo(constant: 21)
        }

        genreLabel.layout.makeConstraints { make in
            make.top.equalTo(nameLabel.layout.bottom)
            make.left.equalTo(nameLabel.layout.left)
            make.right.equalTo(nameLabel.layout.right)
        }

        downloadButton.layout.makeConstraints { make in
            make.centerY.equalTo(iconImageView.layout.centerY)
            make.right.equalTo(layout.right, constant: -16)
            make.width.equalTo(constant: 65)
            make.height.equalTo(constant: 30)
        }

        screenshotStackView.layout.makeConstraints { make in
            make.top.equalTo(iconImageView.layout.bottom, constant: 16)
            make.left.equalTo(layout.left, constant: 32)
            make.right.equalTo(layout.right, constant: -32)
            make.bottom.equalTo(layout.bottom)
            make.height.equalTo(constant: 200)
        }

        screenshotLeftImageView.layout.makeConstraints { make in
            make.width.equalTo(constant: 100)
            make.height.equalTo(constant: 200)
        }

        screenshotCenterImageView.layout.makeConstraints { make in
            make.width.equalTo(constant: 100)
            make.height.equalTo(constant: 200)
        }

        screenshotRightImageView.layout.makeConstraints { make in
            make.width.equalTo(constant: 100)
            make.height.equalTo(constant: 200)
        }
    }

    func render() {
        screenshotLeftImageView.layer.cornerRadius = 6
        screenshotLeftImageView.clipsToBounds = true
        screenshotCenterImageView.layer.cornerRadius = 6
        screenshotCenterImageView.clipsToBounds = true
        screenshotRightImageView.layer.cornerRadius = 6
        screenshotRightImageView.clipsToBounds = true

        iconImageView.layer.cornerRadius = 15
        iconImageView.clipsToBounds = true
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        genreLabel.textColor = .lightGray
        genreLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)

        downloadButton.layer.cornerRadius = 15
        downloadButton.setTitle("GET", for: .normal)
        downloadButton.setTitleColor(.link, for: .normal)
        downloadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        downloadButton.backgroundColor = UIColor(red: 238/255, green: 241/255, blue: 249/255, alpha: 1)
    }
}
