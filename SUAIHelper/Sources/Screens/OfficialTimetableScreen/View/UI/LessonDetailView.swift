import SwiftUI

struct LessonDetailView: View {
    let lesson: Lesson

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                
                Text(lesson.title)
                    .font(.system(size: 28, weight: .semibold))
                    .padding(.top, 5)
                Text(lesson.lessonType)
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 5)
                    .foregroundStyle(.orange)
                if let lessonNumber = lesson.lessonNumber, let lessonTime = lesson.lessonTime {
                    Text("\(lessonNumber) пара, \(lessonTime)")
                        .padding(.top, 5)
                } else {
                    Text("Вне сетки расписания")
                        .padding(.top, 5)
                }
                Text(lesson.address + ", " + lesson.room)
                    .padding(.top, 5)
                if let teachers = lesson.teachers {
                    // да, я в курсе что можно через локализацию, это временное решение
                    if teachers.count == 1 {
                        Text("Преподаватель: " + teachers[0])
                            .padding(.top, 5)
                    } else {
                        Text("Преподаватель: " + teachers.joined(separator: ", "))
                            .padding(.top, 5)
                    }
                }
                weekView
                    .padding(.top, 5)
                
            }
            .padding()
        }

    }

    var weekView: some View {
        switch lesson.weekType {
        case .red:
            return Text("Верхняя неделя")
                .foregroundStyle(.red)
        case .blue:
            return Text("Нижняя неделя")
                .foregroundStyle(.blue)
        case .universal:
            return Text("Общая неделя")
                .foregroundStyle(.black)
        }
    }

}

#Preview {
    LessonDetailView(
        lesson: Lesson(
            id: UUID(),
            day: "Понедельник",
            title: "Основы программирования",
            room: "22-09",
            address: "Большая Морская",
            teachers: ["Сидоренко Д.А.", "Туманова А.В."],
            groupList: ["4431", "4433"],
            weekType: .universal,
            lessonNumber: 3,
            lessonTime: "13:00-14:30",
            lessonType: "Лабораторная работа"
        )
    )
}
