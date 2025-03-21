import SwiftUI

struct NavigatorView: View {
    var body: some View {
        VStack {
            WebView(URL(string: "https://guap.ru/map_bm")!)
        }
    }
}

#Preview {
    NavigatorView()
}
