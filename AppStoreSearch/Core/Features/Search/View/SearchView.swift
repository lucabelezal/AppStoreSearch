import UIKit

protocol SearchViewDelegate: class {
    func didSelectSearch(term: String)
}

class SearchView: UIView {

    let tableView: UITableView = UITableView()

    weak var delegate: SearchViewDelegate?

    var terms: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView: ViewCodable {
    func configure() {
        tableView.register(cellType: SearchCellView.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
    }

    func buildHierarchy() {
        addView(tableView)

        let headerView = SearchHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: 60)))
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
    }

    func buildConstraints() {
        tableView.layout.makeConstraints { make in
            make.top.equalTo(layout.safeArea.top)
            make.bottom.equalTo(layout.safeArea.bottom)
            make.left.equalTo(layout.left)
            make.right.equalTo(layout.right)
        }
    }

    func render() {}
}

extension SearchView: UITableViewDataSource {

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return terms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchCellView = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.text = terms[indexPath.row]
        return cell
    }
}

extension SearchView: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSearch(term: terms[indexPath.row])
    }
}

