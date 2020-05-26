import UIKit

protocol AppsViewDelegate: class {

}

class AppsView: UIView {

    weak var delegate: AppsViewDelegate?
    
    private let tableView: UITableView = UITableView()
    private let emptyView: EmptyStateView = EmptyStateView()

    private var apps: [App] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView(with apps: [App]) {
        self.emptyView.isHidden = true
        self.apps = apps
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showEmptyView(title: String? = nil, message: String? = nil) {
        emptyView.setup(title: "Not found", message: message)
        emptyView.isHidden = false
    }

    func hideEmptyView() {
        emptyView.isHidden = true
    }
}

extension AppsView: ViewCodable {
    func configure() {
        tableView.register(cellType: AppCellView.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }

    func buildHierarchy() {
        addView(tableView, emptyView)
    }

    func buildConstraints() {
        tableView.layout.makeConstraints { make in
            make.top.equalTo(layout.safeArea.top)
            make.bottom.equalTo(layout.safeArea.bottom)
            make.left.equalTo(layout.left)
            make.right.equalTo(layout.right)
        }

        emptyView.layout.makeConstraints { make in
            make.top.equalTo(layout.safeArea.top)
            make.bottom.equalTo(layout.safeArea.bottom)
            make.left.equalTo(layout.left)
            make.right.equalTo(layout.right)
        }
    }

    func render() {
         backgroundColor = .white
        emptyView.isHidden = true
        emptyView.setup(title: "Not found", message: "Try other term")
    }
}

extension AppsView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return apps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AppCellView = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(app: apps[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt _: IndexPath) {
        guard let cell = cell as? AppCellView else { return }
        cell.cancel()
    }
}

extension AppsView: UITableViewDelegate {}

