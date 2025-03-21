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
                }
                
            }
            .navigationTitle("Расписание")
            .listStyle(.plain)
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
