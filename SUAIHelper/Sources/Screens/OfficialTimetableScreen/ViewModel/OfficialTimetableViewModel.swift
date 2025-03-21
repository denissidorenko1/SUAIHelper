import SwiftUI

final class OfficialTimetableViewModel: ObservableObject {
    private let timetableService: TimetableService
    
    // MARK: - Public properties
    @Published var lessons: [Lesson] = []
    @Published var selectedLesson: Lesson?

    
    init(timetableService: TimetableService = TimetableService()) {
        self.timetableService = timetableService
    }
    
    
    func fetchLessons() async throws {
        let lessons = try await timetableService.getLessonList(group: Group(id: 5949, name: "4431"))
        
        self.lessons = lessons
    }
}
