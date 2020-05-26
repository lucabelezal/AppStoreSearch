import Foundation

protocol SearchServiceProtocol {
    func fetchTerms(completion: @escaping (Result<[String], Error>) -> Void)
    func cancelRequest()
}

struct SearchService: SearchServiceProtocol {

    init() {}

    func fetchTerms(completion: @escaping (Result<[String], Error>) -> Void) {
        let terms = ["instagram", "snapchat", "twitter", "design+code", "amazon", "tinder", "ted"]
        completion(.success(terms))
    }

    func cancelRequest() {}
}
