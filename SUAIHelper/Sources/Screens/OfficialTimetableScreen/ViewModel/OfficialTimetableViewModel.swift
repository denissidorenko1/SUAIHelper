import SwiftUI

final class OfficialTimetableViewModel: ObservableObject {
    private let timetableService: TimetableService
    
    // MARK: - Public properties
    @Published var selectedLesson: Lesson?
    @Published var isShowingSearchView: Bool = false
    
    @Published var selectedGroup: Group?
    @Published var selectedRoom: Room?
    @Published var selectedTeacher: Teacher?
    @Published var selectedDepartment: Department?

    var timetable: [DayLesson] {
        splitLessonsByDay(with: lessons)
    }
    
    // MARK: - Private properties
    @Published private var lessons: [Lesson] = []
    
    init(
        timetableService: TimetableService = TimetableService()
    ) {
        self.timetableService = timetableService
    }
    
    
    func fetchLessons() async throws {
        let fetchedLessons = try await timetableService.getLessonList(group: selectedGroup, teacher: selectedTeacher, department: selectedDepartment, room: selectedRoom)
        self.lessons = fetchedLessons
    }
    
    private func splitLessonsByDay(with lessons: [Lesson]) -> [DayLesson] {
        guard !lessons.isEmpty else { return [] }
        var result: [DayLesson] = []
        var currentDay = lessons[0].day
        var currentDayLessons: [Lesson] = []

        for lesson in lessons {
            if lesson.day != currentDay {
                result.append(DayLesson(day: currentDay, lessons: currentDayLessons))
                currentDay = lesson.day
                currentDayLessons = [lesson]
            } else {
                currentDayLessons.append(lesson)
            }
        }

        if !currentDayLessons.isEmpty {
            result.append(DayLesson(day: currentDay, lessons: currentDayLessons))
        }

        return result
    }
}
