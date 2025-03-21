import SwiftUI

struct LessonCell: View {
    private let lesson: Lesson
    
    init(lesson: Lesson) {
        self.lesson = lesson
    }
    
    var body: some View {
        
        HStack {
            VStack {
                Text("\(lesson.lessonNumber ?? 0)")
                    .foregroundStyle(.red)
                    .font(.system(size: 32, weight: .bold))
                if let time = lesson.lessonTime, time.split(separator: "—").count == 2 {
                    let timeComponents = time.split(separator: "—").map {String($0)}
                    VStack {
                        Text(timeComponents[0])
                        Text(timeComponents[1])
                    }
                    .font(.system(size: 12, weight: .regular))
                    
                }
            }
            
            VStack(alignment: .leading) {
                Text(lesson.title)
                Text(lesson.lessonType)
                HStack {
                    Text(lesson.room + ",")
                    Text(lesson.address)
                }
            }
            Spacer()
        }
        
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(alignment: .center) {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray)
        }
    }
        
}


#Preview {
    let lesson = Lesson(
        id: UUID(),
        day: "Понедельник",
        title: "Основы программирования",
        room: "23—09",
        address: "Большая Морская",
        teachers: ["Сидоренко Д. А."],
        groupList: ["4431"],
        weekType: .universal,
        lessonNumber: 3,
        lessonTime: "13:00-14:30",
        lessonType: "Лабораторная работа"
    )
    LessonCell(lesson: lesson)
    
}
