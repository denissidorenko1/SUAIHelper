import SwiftUI

final class SearchFilterViewModel: ObservableObject {
    private let service: TimetableService
    
    @Binding var selectedDepartment: Department?
    @Binding var selectedRoom: Room?
    @Binding var selectedTeacher: Teacher?
    @Binding var selectedGroup: Group?
    
    @Published var filterOptions: SearchFilterOptions
    
    init(timetableService: TimetableService = TimetableService(),
         department: Binding<Department?>,
         room: Binding<Room?>,
         teacher: Binding<Teacher?>,
         group: Binding<Group?>
         
    ) {
        self.service = timetableService
        self.filterOptions = .init(departments: [], rooms: [], teachers: [], groups: [])
        self._selectedDepartment = department
        self._selectedRoom = room
        self._selectedTeacher = teacher
        self._selectedGroup = group
    }
    
    func applyFilters() {
        
    }
    
    func resetFilters() {
        selectedDepartment = nil
        selectedRoom = nil
        selectedTeacher = nil
        selectedGroup = nil
    }
    
    func getFilters() async throws {
        let filters = try await service.getSearchFilterOptions()
        print(filters)
        filterOptions = filters
    }
}
