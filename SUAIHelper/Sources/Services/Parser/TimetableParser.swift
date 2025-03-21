import Foundation
import SwiftSoup

// MARK: - TimetableParser
class TimetableParser: TimetableParserProtocol, @unchecked Sendable {
    // MARK: - CSS Selectors
    private enum CSSQuery {
        static let day = "h4.text-danger.border-bottom"
        static let time = "div.mt-3.text-danger"
        static let lesson = "div.mb-3.py-2.d-flex.gap-2"
        static let title = "div.lead.lh-sm"
        static let room = "a[href^='?ad=']"
        static let address = "a[href^='?ch=']"
        static let teacher = "a[href^='?pr=']"
        static let groups = "a[href^='?gr=']"
        static let lessonType = "div.fs-6.lh-sm.opacity-50"
        static let selector = "select.form-select.guap-tom-select"
        static let row = "div.row"
        static let redWeek = "week1"
        static let blueWeek = "week2"
    }
    
    // MARK: - Public methods
    func parseTimetable(data: Data) throws -> [Lesson] {
        do {
            let document = try SwiftSoup.parse(String(decoding: data, as: UTF8.self))
            
            var lessons: [Lesson] = []
            var nextElement = try document.select(CSSQuery.day).first()
            var day: String?
            var lessonNumber: Int?
            var lessonTime: String?
            
            while let element = nextElement {
                switch true {
                case try element.iS(CSSQuery.time):
                    (lessonNumber, lessonTime) = try extractTime(from: element)
                    nextElement = try element.nextElementSibling()

                case try element.iS(CSSQuery.lesson):
                    let lesson = try extractLesson(
                        from: element,
                        day: day,
                        lessonNumber: lessonNumber,
                        lessonTime: lessonTime
                    )
                    lessons.append(lesson)
                    nextElement = try element.nextElementSibling()

                case try element.iS(CSSQuery.day):
                    day = try element.text()
                    nextElement = try element.nextElementSibling()

                default:
                    nextElement = nil
                }
            }
            
            return lessons
        } catch {
            throw NetworkingServiceError.parsingError
        }
    }
    
    func parseTeachers(data: Data) throws -> [Teacher] {
        do {
            let document = try SwiftSoup.parse(String(decoding: data, as: UTF8.self))
            
            let elements = try extractFormElements(document: document, position: 1, subPosition: 1)
            
            return try elements.mapToType(Teacher.self)
        } catch {
            throw NetworkingServiceError.parsingError
        }
    }
    
    func parseGroups(data: Data) throws -> [Group] {
        do {
            let document = try SwiftSoup.parse(String(decoding: data, as: UTF8.self))
            
            let elements = try extractFormElements(document: document, position: 1, subPosition: 0)
            
            return try elements.mapToType(Group.self)
        } catch {
            throw NetworkingServiceError.parsingError
        }
    }
    
    func parseRooms(data: Data) throws -> [Room] {
        do {
            let document = try SwiftSoup.parse(String(decoding: data, as: UTF8.self))
            
            let elements = try extractFormElements(document: document, position: 2, subPosition: 1)
            
            return try elements.mapToType(Room.self)
        } catch {
            throw NetworkingServiceError.parsingError
        }
    }
    
    func parseDepartments(data: Data) throws -> [Department] {
        do {
            let document = try SwiftSoup.parse(String(decoding: data, as: UTF8.self))
            
            let elements = try extractFormElements(document: document, position: 2, subPosition: 0)
            
            return try elements.mapToType(Department.self)
        } catch {
            throw NetworkingServiceError.parsingError
        }
    }
    
    // MARK: - Helper Methods
    private func extractLesson(from element: Element, day: String?, lessonNumber: Int?, lessonTime: String?) throws -> Lesson {
        guard let day else { throw NetworkingServiceError.parsingError }
        
        let title = try element.select(CSSQuery.title).text()
        let room = try element.select(CSSQuery.room).text()
        let address = try element.select(CSSQuery.address).text()
        let teachers = try element.select(CSSQuery.teacher).compactMap { try? $0.text() }
        let groups = try element.select(CSSQuery.groups).compactMap { try? $0.text() }
        let weekType = determineWeekType(for: element)
        let lessonType = try determineLessonType(for: element)
        
        return Lesson(
            id: UUID(),
            day: day,
            title: title,
            room: room,
            address: address,
            teachers: teachers,
            groupList: groups,
            weekType: weekType,
            lessonNumber: lessonNumber,
            lessonTime: lessonTime,
            lessonType: lessonType
        )
    }
    
    private func extractTime(from element: Element) throws -> (Int?, String?) {
        let text = try element.text().components(separatedBy: " ")
        let lessonNumber = Int(text.first ?? "")
        let lessonTime = text.dropFirst(2).joined(separator: " ").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        return (lessonNumber, lessonTime)
    }
    
    private func determineWeekType(for element: Element) -> WeekType {
        if element.children().first()?.hasClass(CSSQuery.redWeek) == true { return .red }
        if element.children().first()?.hasClass(CSSQuery.blueWeek) == true { return .blue }
        return .universal
    }
    
    private func determineLessonType(for element: Element) throws -> String {
        try element.select(CSSQuery.lessonType).text()
    }
    
    private func extractFormElements(document: Document, position: Int, subPosition: Int) throws -> Elements {
        return try document
            .select(CSSQuery.row)
            .get(position)
            .children()
            .get(subPosition)
            .select(CSSQuery.selector)
            .get(0)
            .children()
    }
}


extension Elements {
    func mapToType<T: QueryType>(_ type: T.Type) throws -> [T] {
        return try self.compactMap { elem in
            guard let id = Int(try elem.val()) else { return nil }
            let name = try elem.text()
            return T(id: id, name: name)
        }
    }
}
