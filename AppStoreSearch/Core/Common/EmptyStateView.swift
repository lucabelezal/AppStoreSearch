import UIKit

public final class EmptyStateView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .darkGray
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()

    public init(frame: CGRect = .zero, respondsToKeyboard: Bool = true) {
        super.init(frame: frame)
        setupView()
        if respondsToKeyboard {
            registerKeyboardNotification()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup(image: UIImage?, title: String? = nil, message: String? = nil) {
        imageView.isHidden = false
        imageView.image = image
        titleLabel.text = title
        messageLabel.text = message
    }

    public func setup(title: String? = nil, message: String? = nil) {
        imageView.isHidden = true
        titleLabel.text = title
        messageLabel.text = message
    }

    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    func keyboardWillShow(notification _: NSNotification) {
        if transform.ty == 0 {
            let moveY = stackView.frame.minY - 15
            transform = CGAffineTransform(translationX: 0, y: -moveY)
        }
    }

    @objc
    func keyboardWillHide(notification _: NSNotification) {
        if transform.ty != 0 {
            transform = .identity
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension EmptyStateView: ViewCodable {
    public func configure() {}

    public func buildHierarchy() {
        stackView.addArrangedSubview(imageView)
        addView(stackView, titleLabel, messageLabel)
    }

    public func buildConstraints() {
        stackView.layout.makeConstraints { make in
            make.height.equalTo(constant: 180)
            make.width.equalTo(constant: 180)
            make.centerX.equalTo(layout.centerX)
            make.centerY.equalTo(layout.centerY, constant: -100)
        }

        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(stackView.layout.bottom, constant: 30)
            make.left.equalTo(layout.left, constant: 30)
            make.right.equalTo(layout.right, constant: -30)
        }

        messageLabel.layout.makeConstraints { make in
            make.top.equalTo(titleLabel.layout.bottom, constant: 15)
            make.left.equalTo(layout.left, constant: 30)
            make.right.equalTo(layout.right, constant: -30)
        }
    }

    public func render() {
        backgroundColor = .clear
    }
}
