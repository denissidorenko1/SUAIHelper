import Foundation

// MARK: - TimetableService
final class TimetableService {

    // MARK: - Dependencies
    static let shared = TimetableService()

    // MARK: - Private properties
    private let timetableService: TimetableNetworkingServiceProtocol

    // MARK: - Initializer
    init(timetableService: TimetableNetworkingServiceProtocol = TimetableNetworkingService() ) {
        self.timetableService = timetableService
    }

    // MARK: - Public Methods
    func getLessonList(
        group: QueryType? = nil,
        teacher: QueryType? = nil,
        department: QueryType? = nil,
        room: QueryType? = nil
    ) async throws -> [Lesson] {
        return try await timetableService.getLessons(
            request: TimetableRequest(
                group: group,
                teacher: teacher,
                department: department,
                room: room
            )
        )
    }
    
    func getGroupList() async throws -> [Group] {
        return try await timetableService.getGroups(request: FilterRequest())
    }
    
    func getTeacherList() async throws -> [Teacher] {
        return try await timetableService.getTeachers(request: FilterRequest())
    }
    
    func getDepartmentList() async throws -> [Department] {
        return try await timetableService.getDepartments(request: FilterRequest())
    }
    
    func getRoomList() async throws -> [Room] {
        return try await timetableService.getRooms(request: FilterRequest())
    }
    
    func getSearchFilterOptions() async throws -> SearchFilterOptions {
        return try await timetableService.getSearchFilterOptions(request: FilterRequest())
    }
}
