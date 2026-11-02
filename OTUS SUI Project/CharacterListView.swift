import SwiftUI

struct AllCharactersView: View {
    @ObservedObject var store: CharacterStore
    @State private var searchText: String = ""

    private var filteredCharacters: [RMCharacter] {
        guard !searchText.isEmpty else { return store.characters }
        return store.characters.filter { character in
            character.name.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        Group {
            if store.isLoading && store.characters.isEmpty {
                VStack(spacing: 12) {
                    ProgressView(value: store.progress) {
                        Text("загружаем телепортатор...")
                    } currentValueLabel: {
                        Text("\(Int(store.progress * 100))%")
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = store.errorMessage {
                VStack(spacing: 12) {
                    Text("Не удалось загрузить персонажей")
                        .font(.headline)
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Button("Повторить") {
                        Task {
                            await store.reloadCharacters()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(filteredCharacters) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        CharacterRowView(character: character)
                    }
                }
            }
        }
        .navigationTitle("Characters")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Поиск персонажа")
    }
}

struct CharacterRowView: View {
    let character: RMCharacter

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                ProgressView()
                    .frame(width: 60, height: 60)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.headline)
                Text("\(character.species) • \(character.status)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        let store = CharacterStore()
        AllCharactersView(store: store)
    }
}

