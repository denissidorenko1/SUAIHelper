import Foundation
import SwiftSoup

struct TimetableNetworkingService: TimetableNetworkingServiceProtocol {
    // MARK: - Dependencies
    private let session: URLSession
    private let parser: TimetableParserProtocol
    
    // MARK: - Initializer
    init(
        session: URLSession = .shared,
        parser: TimetableParserProtocol = TimetableParser()
    ) {
        self.session = session
        self.parser = parser
    }
    
    // MARK: - Public Methods
    func send(request: NetworkRequest) async throws -> Data {
        guard let urlRequest = createRequest(from: request) else {
            throw NetworkingServiceError.urlSessionError
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkingServiceError.httpStatusCode((response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        return data
    }
    
    func getLessons(request: NetworkRequest) async throws -> [Lesson] {
        let data = try await send(request: request)
        return try parser.parseTimetable(data: data)
    }
    
    func getGroups(request: any NetworkRequest) async throws -> [Group] {
        let data = try await send(request: request)
        return try parser.parseGroups(data: data)
    }
    
    func getTeachers(request: any NetworkRequest) async throws -> [Teacher] {
        let data = try await send(request: request)
        return try parser.parseTeachers(data: data)
    }
    
    func getDepartments(request: any NetworkRequest) async throws -> [Department] {
        let data = try await send(request: request)
        return try parser.parseDepartments(data: data)
    }
    
    func getRooms(request: any NetworkRequest) async throws -> [Room] {
        let data = try await send(request: request)
        return try parser.parseRooms(data: data)
    }
    
    func getSearchFilterOptions(request: any NetworkRequest) async throws -> SearchFilterOptions {
        let data = try await send(request: request)
        let departments = try parser.parseDepartments(data: data)
        let rooms = try parser.parseRooms(data: data)
        let teachers = try parser.parseTeachers(data: data)
        let groups = try parser.parseGroups(data: data)
        
        return SearchFilterOptions(
            departments: departments,
            rooms: rooms,
            teachers: teachers,
            groups: groups
        )
    }
    
    // MARK: - Private Methods
    private func createRequest(from request: NetworkRequest) -> URLRequest? {
        guard let url = request.endPoint else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.name
        
        return urlRequest
    }
    
    
}
