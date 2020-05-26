import Foundation

public protocol AutocompleteViewModelProtocol {
    var suggestions: [String] { get }
    var searchedTerm: String { get }
}

struct AutocompleteViewModel: AutocompleteViewModelProtocol {

    var suggestions: [String]
    var searchedTerm: String
    
    init(terms: [Term], searchedTerm: String) {
        self.searchedTerm = searchedTerm
        self.suggestions = AutocompleteViewModel.namesWith(terms: terms, prefix: searchedTerm)
    }

    private static func namesWith(terms: [Term], prefix: String) -> [String] {
        return terms
                .filter { $0.name.hasCaseInsensitivePrefix(string: prefix) }
                .sorted { $0.popularity > $1.popularity }
                .map { $0.name }
    }
}
