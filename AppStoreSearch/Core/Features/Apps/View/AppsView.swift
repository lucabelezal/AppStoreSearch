import UIKit

protocol AppsViewDelegate: class {

}

class AppsView: UIView {

    weak var delegate: AppsViewDelegate?
    
    private let tableView: UITableView = UITableView()

    var apps: [App]? {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        addView(tableView)
    }

    func buildConstraints() {
        tableView.layout.makeConstraints { make in
            make.top.equalTo(layout.safeArea.top)
            make.bottom.equalTo(layout.safeArea.bottom)
            make.left.equalTo(layout.left)
            make.right.equalTo(layout.right)
        }
    }

    func render() {
         backgroundColor = .white
    }
}

extension AppsView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return apps?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AppCellView = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(app: apps?[indexPath.row])
        return cell
    }

    func tableView(_: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt _: IndexPath) {
        guard let cell = cell as? AppCellView else { return }
        cell.cancel()
    }
}

extension AppsView: UITableViewDelegate {}

