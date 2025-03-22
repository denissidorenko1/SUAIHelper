import SwiftUI

struct SearchFilterView: View {
    @StateObject var viewModel: SearchFilterViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List {
                FilterPickerSection(
                    title: "Кафедра",
                    options: viewModel.filterOptions.departments,
                    selectedItem: $viewModel.selectedDepartment,
                    searchText: $searchText
                )

                FilterPickerSection(
                    title: "Аудитория",
                    options: viewModel.filterOptions.rooms,
                    selectedItem: $viewModel.selectedRoom,
                    searchText: $searchText
                )

                FilterPickerSection(
                    title: "Преподаватель",
                    options: viewModel.filterOptions.teachers,
                    selectedItem: $viewModel.selectedTeacher,
                    searchText: $searchText
                )

                FilterPickerSection(
                    title: "Группа",
                    options: viewModel.filterOptions.groups,
                    selectedItem: $viewModel.selectedGroup,
                    searchText: $searchText
                )
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Поиск")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Сброс") {
                        viewModel.resetFilters()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Применить") {
                        viewModel.applyFilters()
                        dismiss()
                    }
                }
            }
            .searchable(text: $searchText)
            .onAppear {
                Task {
                    do {
                        try await viewModel.getFilters()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}
#Preview {
    let vm = SearchFilterViewModel( department: .constant(nil), room: .constant(nil), teacher: .constant(nil), group: .constant(nil))
    SearchFilterView(viewModel: vm)
}
