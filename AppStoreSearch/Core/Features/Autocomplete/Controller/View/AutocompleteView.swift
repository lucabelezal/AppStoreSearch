import UIKit

public protocol AutocompleteViewDelegate: class {
    func didSelect(suggestion: String)
}

class AutocompleteView: UIView {

    weak var delegate: AutocompleteViewDelegate?

    private let tableView: UITableView = UITableView()
    private var suggestions: [String] = []
    private var searchedTerm: String = String()

    public var viewModel: AutocompleteViewModelProtocol? {
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

    func updateView() {
        if let model = viewModel {
            suggestions = model.suggestions
            searchedTerm = model.searchedTerm

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension AutocompleteView: ViewCodable {
    func configure() {
        tableView.register(cellType: AutocompleteCellView.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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

extension AutocompleteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AutocompleteCellView = tableView.dequeueReusableCell(for: indexPath)
        cell.set(term: suggestions[indexPath.row], searchedTerm: searchedTerm)
        return cell
    }
}

extension AutocompleteView: UITableViewDelegate {

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(suggestion: suggestions[indexPath.row])
    }
}
