import Foundation

// MARK: - NetworkingService
protocol TimetableNetworkingServiceProtocol: Sendable {
    func send(request: NetworkRequest) async throws -> Data
    
    func getLessons(request: NetworkRequest) async throws -> [Lesson]
    func getGroups(request: NetworkRequest) async throws -> [Group]
    func getTeachers(request: NetworkRequest) async throws -> [Teacher]
    func getDepartments(request: NetworkRequest) async throws -> [Department]
    func getRooms(request: NetworkRequest) async throws -> [Room]
    func getSearchFilterOptions(request: NetworkRequest) async throws -> SearchFilterOptions
}
