import Foundation

struct DayLesson: Identifiable {
    let id = UUID()
    let day: String
    let lessons: [Lesson]
}
