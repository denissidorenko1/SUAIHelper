import Foundation

// MARK: - Timetable Parser
protocol TimetableParserProtocol: AnyObject, Sendable {
    func parseTimetable(data: Data) throws -> [Lesson]
    func parseTeachers(data: Data) throws -> [Teacher]
    func parseGroups(data: Data) throws -> [Group]
    func parseRooms(data: Data) throws -> [Room]
    func parseDepartments(data: Data) throws -> [Department]
}
