//
//  OfficialTimetableView.swift
//  SUAIHelper
//
//  Created by Denis on 20.03.2025.
//

import SwiftUI

struct OfficialTimetableView: View {
    @StateObject var viewModel: OfficialTimetableViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    viewModel.isShowingSearchView = true
                } label: {
                    Text("Фильтры поиска")
                }
                if viewModel.timetable.isEmpty {
                    Text("Выберите группу, преподавателя, кафедру или аудиторию в форме поиска.")
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.timetable) { day in
                        Section(header: Text(day.day).font(.headline)) {
                            ForEach(day.lessons) { lesson in
                                LessonCell(lesson: lesson)
                                    .frame(height: 80)
                                    .listRowSeparator(.hidden)
                                    .onTapGesture {
                                        viewModel.selectedLesson = lesson
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Расписание")
            .listStyle(.plain)
            .sheet(item: $viewModel.selectedLesson) { lesson in
                ViewFactory.makeLessonDetailView(with: lesson)
            }
            .sheet(
                isPresented: $viewModel.isShowingSearchView ,
                onDismiss: {
                    Task {
                        do {
                            try await viewModel.fetchLessons()
                        } catch {
                            print("error: \(error.localizedDescription)")
                        }
                    }
                },
                content: {
                    SearchFilterView(
                        viewModel: SearchFilterViewModel(
                            department: $viewModel.selectedDepartment,
                            room: $viewModel.selectedRoom,
                            teacher: $viewModel.selectedTeacher,
                            group: $viewModel.selectedGroup
                        )
                    )
                })
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchLessons()
                    } catch {
                        print("error: \(error.localizedDescription)")
                    }
                }
            }
        }
        
    }
}

#Preview {
    OfficialTimetableView(viewModel: OfficialTimetableViewModel())
}
