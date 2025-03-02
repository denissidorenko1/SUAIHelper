import Foundation

enum Endpoint {
    case timetable(group: QueryType?, teacher: QueryType?, department: QueryType?, room: QueryType?)
    case filter
    
    static let baseURL: URL = URL(string: "https://guap.ru")!
    
    // TODO: пофиксить
    var path: String {
        "rasp"
    }
    
    var url: URL? {
        var components = URLComponents(url: Endpoint.baseURL.appending(path: self.path), resolvingAgainstBaseURL: false)
        switch self {
        case .timetable(let group, let teacher, let department, let room):
            var queryItems: [URLQueryItem] = []
            if let group {
                queryItems.append(URLQueryItem(name: "gr", value: String(group.id)))
            }
            if let teacher {
                queryItems.append(URLQueryItem(name: "pr", value: String(teacher.id)))
            }
            if let department {
                queryItems.append(URLQueryItem(name: "ch", value: String(department.id)))
            }
            if let room {
                queryItems.append(URLQueryItem(name: "ad", value: String(room.id)))
            }
            components?.queryItems = queryItems
            return components?.url
        case .filter:
            return components?.url
        }
    }
}
