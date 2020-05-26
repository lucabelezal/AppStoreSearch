import Foundation

protocol AutocompleteServiceProtocol {
    func fetchSuggestions(basedOn searchText: String, completion: @escaping (Result<[String], Error>) -> Void)
    func cancelRequest()
}

class AutocompleteService: AutocompleteServiceProtocol {

    init() {}

    func fetchSuggestions(basedOn searchText: String, completion: @escaping (Result<[String], Error>) -> Void) {


        guard let terms: [Term] = Bundle.main.loadJSONFile(named: "terms") else {
            fatalError("Error loadJSONFile()")
        }

        if let results = AutocompleteService.namesWith(terms: terms, prefix: searchText), !results.isEmpty {
            completion(.success(results))
        } else {
            completion(.success([]))
        }
    }

    func cancelRequest() {

    }
}


extension AutocompleteService {

    private static func namesWith(terms: [Term], prefix: String) -> [String]? {
        return terms
                .filter { $0.name.hasCaseInsensitivePrefix(string: prefix) }
                .sorted { $0.popularity > $1.popularity }
                .map { $0.name }
    }
}
