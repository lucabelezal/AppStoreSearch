import Kingfisher
import Foundation

protocol AppsPresenterProtocol: AnyObject {
    var view: AppsViewControllerProtocol? { get set }
    func search(term: String)
}

class AppsPresenter: AppsPresenterProtocol {

    var view: AppsViewControllerProtocol?

    private let service: AppsServiceProtocol

    init(service: AppsServiceProtocol =  AppsService()) {
        self.service = service
    }

    func search(term: String) {
        view?.showLoading(show: true)
        service.fetchApps(basedOn: term) { result in
            DispatchQueue.main.async {
                self.view?.hideLoading()
                switch result {
                case let .success(apps):

                    let mediaUrls = apps.results.flatMap { $0.media }.compactMap { URL(string: $0) }
                    let imagePrefetcher = ImagePrefetcher(urls: mediaUrls)
                    imagePrefetcher.start()

                    self.view?.showView(with: apps.results)

                case let .failure(error):
                    self.view?.showErrorView(with: error.localizedDescription)
                }
            }
        }
    }

}
