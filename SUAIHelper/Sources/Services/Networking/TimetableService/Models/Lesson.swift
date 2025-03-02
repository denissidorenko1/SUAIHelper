import Foundation

struct Lesson: Decodable {
    let day: String
    let title: String
    let room: String
    let address: String
    let teachers: [String]?
    let groupList: [String]
    let weekType: WeekType
    let lessonNumber: Int?
    let lessonTime: String?
    let lessonType: String
}
