import Foundation

protocol ViewFactoryProtocol {
    static func makeOfficialTimetableView() -> OfficialTimetableView
    static func makeNavigatorView() -> NavigatorView
    static func makeCustomTimetableView() -> CustomTimetableView
    static func makeAssignmentView() -> AssignmentView
}
