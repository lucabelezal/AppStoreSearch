import Kingfisher
import UIKit

class AppsTableViewController: UITableViewController, LoadingPresentable {
    var apps = [App]()
    var dataTask: URLSessionDataTask?
    var imagePrefetcher: ImagePrefetcher?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: AppTableViewCell.self)
        tableView.separatorStyle = .none
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return apps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AppTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(app: apps[indexPath.row])
        return cell
    }

    override func tableView(_: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt _: IndexPath) {
        guard let cell = cell as? AppTableViewCell else { return }
        cell.cancel()
    }

    func search(term: String) {
        showLoading(show: true)
        dataTask?.cancel()
        if let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {

            let baseURL = "https://itunes.apple.com/search?term="
            let url = URL(string: "\(baseURL)\(encodedTerm)&entity=software,iPadSoftware&limit=10")!

            dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(AppResponse.self, from: data)
                    self.handle(response: response)
                } catch {
                    print(error)
                }
            }

            dataTask?.resume()
        }
    }

    private func handle(response: AppResponse) {
        apps = response.results
        let mediaUrls = apps.flatMap { $0.media }.compactMap { URL(string: $0) }
        imagePrefetcher = ImagePrefetcher(urls: mediaUrls)
        imagePrefetcher?.start()

        DispatchQueue.main.async {
            self.hideLoading()
            self.tableView.reloadData()
        }
    }
}
