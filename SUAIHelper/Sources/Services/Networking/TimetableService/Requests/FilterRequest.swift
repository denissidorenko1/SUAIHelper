import Foundation

struct FilterRequest: NetworkRequest {
    var endPoint: URL? { Endpoint.filter.url }
    var httpMethod: HTTPMethod = .get
}
