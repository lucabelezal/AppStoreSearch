import Foundation

struct AppResponse: Decodable {
    var resultCount: Int
    var results: [App]
}
