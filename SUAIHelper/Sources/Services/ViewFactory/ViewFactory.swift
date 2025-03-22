import Foundation

final class ViewFactory: ViewFactoryProtocol {
    
    static func makeOfficialTimetableView() -> OfficialTimetableView {
        let vm = OfficialTimetableViewModel()
        return OfficialTimetableView(viewModel: vm)
    }
    
    static func makeCustomTimetableView() -> CustomTimetableView {
        return CustomTimetableView()
    }
    
    static func makeNavigatorView() -> NavigatorView {
        NavigatorView()
    }
    
    static func makeAssignmentView() -> AssignmentView {
        AssignmentView()
    }
    
    static func makeLessonDetailView(with lesson: Lesson) -> LessonDetailView {
        LessonDetailView(lesson: lesson)
    }
}
