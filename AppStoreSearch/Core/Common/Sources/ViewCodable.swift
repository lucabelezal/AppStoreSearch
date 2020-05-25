import UIKit

public protocol ViewCodable {
    func setupView()
    func configure()
    func buildHierarchy()
    func buildConstraints()
    func render()
    func bindComponents()
    func setupAcessibilityIdentifiers()
}

extension ViewCodable {

    public func setupView() {
        configure()
        buildHierarchy()
        buildConstraints()
        render()
        bindComponents()
        setupAcessibilityIdentifiers()
    }

    public func bindComponents() { }

    public func setupAcessibilityIdentifiers() { }
}
