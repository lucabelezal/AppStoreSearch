import Foundation

protocol AppsServiceProtocol {
    func fetchApps(basedOn term: String, completion: @escaping (Result<AppResponse, Error>) -> Void)
    func cancelRequest()
}

class AppsService: AppsServiceProtocol {

    var dataTask: URLSessionDataTask?
    
    init() {}

    func fetchApps(basedOn term: String, completion: @escaping (Result<AppResponse, Error>) -> Void) {

        dataTask?.cancel()
        
        if let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {

            let baseURL = "https://itunes.apple.com/search?term="
            let url = URL(string: "\(baseURL)\(encodedTerm)&entity=software,iPadSoftware&limit=10")!

            dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(AppResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }

            dataTask?.resume()
        }

    }

    func cancelRequest() {
        dataTask?.cancel()
    }
}
