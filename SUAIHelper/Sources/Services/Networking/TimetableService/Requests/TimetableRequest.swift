import Foundation

struct TimetableRequest: NetworkRequest {
    let group: QueryType?
    let teacher: QueryType?
    let department: QueryType?
    let room: QueryType?
    
    var endPoint: URL? { Endpoint.timetable(group: group, teacher: teacher, department: department, room: room).url }
    var httpMethod: HTTPMethod = .get
}
