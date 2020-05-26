import Foundation

protocol AutocompleteServiceProtocol {
    func fetchSuggestions(basedOn searchText: String, completion: @escaping (Result<[Term], Error>) -> Void)
    func cancelRequest()
}

class AutocompleteService: AutocompleteServiceProtocol {

    init() {}

    func fetchSuggestions(basedOn searchText: String, completion: @escaping (Result<[Term], Error>) -> Void) {

        guard let terms: [Term] = Bundle.main.loadJSONFile(named: "terms") else {
            fatalError("Error loadJSONFile()")
        }

        completion(.success(terms))
    }

    func cancelRequest() {

    }
}
