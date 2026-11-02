import SwiftUI

struct RickAndMortyTabsView: View {
    @StateObject private var characterStore = CharacterStore()

    var body: some View {
        TabView {
            NavigationStack {
                RandomCharacterView(store: characterStore)
            }
            .tabItem {
                Label("Random", systemImage: "person")
            }

            NavigationStack {
                AllCharactersView(store: characterStore)
            }
            .tabItem {
                Label("Characters", systemImage: "list.bullet")
            }
        }
        .task {
            await characterStore.loadCharactersIfNeeded()
        }
    }
}

#Preview {
    RickAndMortyTabsView()
}

