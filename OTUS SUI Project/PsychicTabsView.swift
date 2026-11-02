import SwiftUI

struct PsychicTabsView: View {
    @StateObject private var store = PsychicStore()

    var body: some View {
        TabView {
            NavigationStack {
                PsychicListView(store: store)
            }
            .tabItem {
                Label("Psychics", systemImage: "person.3")
            }

            NavigationStack {
                RandomPsychicView(store: store)
            }
            .tabItem {
                Label("Magician", systemImage: "wand.and.stars")
            }

            PsychicRandomizerView()
            .tabItem {
                Label("Рандомайзер", systemImage: "die.face.5")
            }
        }
    }
}

#Preview {
    PsychicTabsView()
}

