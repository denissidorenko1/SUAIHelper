import Foundation

enum Endpoint {
    case timetable(group: QueryType?, teacher: QueryType?, department: QueryType?, room: QueryType?)
    case groups
    case teachers
    case departments
    case rooms
    
    static let baseURL: URL = URL(string: "https://guap.ru/rasp")!
    
    // TODO: пофиксить
    var path: String {
        return ""
    }
    
    var url: URL? {
        var components = URLComponents(url: Endpoint.baseURL.appending(path: self.path), resolvingAgainstBaseURL: false)
        switch self {
        case .timetable(let group, let teacher, let department, let room):
            var queryItems: [URLQueryItem] = []
            if let group {
                queryItems.append(URLQueryItem(name: "gr", value: group.name))
            }
            if let teacher {
                queryItems.append(URLQueryItem(name: "pr", value: teacher.name))
            }
            if let department {
                queryItems.append(URLQueryItem(name: "ch", value: department.name))
            }
            if let room {
                queryItems.append(URLQueryItem(name: "ad", value: room.name))
            }
            components?.queryItems = queryItems
            return components?.url
        case .groups:
            return components?.url
        case .teachers:
            return components?.url
        case .departments:
            return components?.url
        case .rooms:
            return components?.url
        }
    }
}
