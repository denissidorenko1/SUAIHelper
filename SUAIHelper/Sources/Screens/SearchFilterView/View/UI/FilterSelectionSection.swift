import SwiftUI

struct FilterPickerSection<T: QueryType & Hashable>: View {
    let title: String
    let options: [T]
    
    @Binding var selectedItem: T?
    @Binding var searchText: String
    
    var filteredOptions: [T] {
        guard !searchText.isEmpty else { return options }
        return options.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        Section(header: Text(title)) {
            Picker(title, selection: $selectedItem) {
                
                Text("Нет").tag(nil as T?)
                ForEach(filteredOptions, id: \.id) { option in
                    Text(option.name).tag(option as T?)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    let groups: [Group] = [
        Group(id: 1234, name: "4454"),
        Group(id: 1134, name: "4454"),
        Group(id: 1554, name: "4454"),
        Group(id: 4324, name: "4454"),
        Group(id: 4433, name: "4454"),
    ]
    FilterPickerSection(title: "Название фильтра", options: groups, selectedItem: .constant(nil), searchText: .constant(""))
}
