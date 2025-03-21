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
                List(viewModel.lessons, id: \.id) { lesson in
                    LessonCell(lesson: lesson)
                        .frame(height: 80)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            viewModel.selectedLesson = lesson
                        }
                }
                
            }
            .navigationTitle("Расписание")
            .listStyle(.plain)
            .sheet(item: $viewModel.selectedLesson) { lesson in
                LessonDetailView(lesson: lesson)
            }

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
