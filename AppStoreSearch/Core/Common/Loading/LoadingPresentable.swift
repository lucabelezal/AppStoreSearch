import UIKit

public protocol LoadingPresentable {
    func showLoading(show: Bool)
    func hideLoading()
}

public extension LoadingPresentable where Self: UIViewController {
    func showLoading(show: Bool) {
        if show {
            LoadingView.show(in: view, withBackgroundColor: .white)
        } else {
            LoadingView.hide(from: view)
        }
    }

    func hideLoading() {
        LoadingView.hide(from: view)
    }
}

public extension LoadingPresentable where Self: UIView {
    func showLoading(show: Bool) {
        if show {
            LoadingView.show(in: self, withBackgroundColor: .white)
        } else {
            LoadingView.hide(from: self)
        }
    }

    func hideLoading() {
        LoadingView.hide(from: self)
    }
}

public final class LoadingView: UIView {

    let indicatorView = UIActivityIndicatorView(style: .large)
    let messageLabel = UILabel()

    public init(view: UIView) {
        super.init(frame: view.bounds)
        setupView()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(indicatorView)
        addSubview(messageLabel)

        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicatorView.startAnimating()

        messageLabel.topAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: 16).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: indicatorView.centerXAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        messageLabel.text = "LOADING"
        messageLabel.textColor = .lightGray
        messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)

        backgroundColor = .white
    }

    @discardableResult
    public static func show(in view: UIView, withBackgroundColor backgroundColor: UIColor) -> LoadingView {

        let hud = LoadingView(view: view)
        view.addSubview(hud)
        view.bringSubviewToFront(hud)
        hud.translatesAutoresizingMaskIntoConstraints = false


        hud.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        hud.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        hud.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hud.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hud.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hud.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        hud.backgroundColor = backgroundColor
        return hud
    }

    public static func hide(from view: UIView) {
        guard let loading = findLoading(for: view) else { return }
        loading.removeFromSuperview()
    }

    private static func findLoading(for view: UIView) -> LoadingView? {
        let subviews = view.subviews.reversed()

        for view in subviews {
            if view.isKind(of: LoadingView.self) {
                return view as? LoadingView
            }
        }

        return nil
    }
}
