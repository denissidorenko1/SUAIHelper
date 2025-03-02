import Foundation

// MARK: - ToDoNetworkingService
final class TimetableService {

    // MARK: - Dependencies
    static let shared = TimetableService()

    // MARK: - Private properties
    private let networkingService: TimetableNetworkingServiceProtocol

    // MARK: - Initializer
    init(networkingService: TimetableNetworkingServiceProtocol = TimetableNetworkingService() ) {
        self.networkingService = networkingService
    }

    // MARK: - Public Methods
    func getLessonList(
        group: QueryType? = nil,
        teacher: QueryType? = nil,
        department: QueryType? = nil,
        room: QueryType? = nil
    ) async throws -> [Lesson] {
        return try await networkingService.getLessons(
            request: TimetableRequest(
                group: group,
                teacher: teacher,
                department: department,
                room: room
            )
        )
    }
    
    func getGroupList() async throws -> [Group] {
        return try await networkingService.getGroups(request: FilterRequest())
    }
    
    func getTeacherList() async throws -> [Teacher] {
        return try await networkingService.getTeachers(request: FilterRequest())
    }
    
    func getDepartmentList() async throws -> [Department] {
        return try await networkingService.getDepartments(request: FilterRequest())
    }
    
    func getRoomList() async throws -> [Room] {
        return try await networkingService.getRooms(request: FilterRequest())
    }
}
