import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ViewFactory.makeOfficialTimetableView()
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }
            ViewFactory.makeCustomTimetableView()
                .tabItem {
                    Label("Доп. расписание", systemImage: "gyroscope")
                }
                
            ViewFactory.makeAssignmentView()
                .tabItem {
                    Label("Личный кабинет", systemImage: "person.crop.circle")
                }
            
            ViewFactory.makeNavigatorView()
                .tabItem {
                    Label("Навигатор", systemImage: "map")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}
