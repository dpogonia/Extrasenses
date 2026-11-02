import SwiftUI

struct RandomCharacterView: View {
    @ObservedObject var store: CharacterStore
    @State private var currentCharacter: RMCharacter?

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
            } else if let character = currentCharacter {
                VStack {
                    CharacterDetailView(character: character)

                    Button("Показать другого персонажа") {
                        pickRandomCharacter()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom)
                }
            } else if let error = store.errorMessage {
                VStack(spacing: 12) {
                    Text("Не удалось загрузить персонажей")
                        .font(.headline)
                    Text(error)
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
                Text("Нет данных о персонажах")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Character")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if currentCharacter == nil {
                pickRandomCharacter()
            }
        }
        .onChange(of: store.characters.count) { _, newValue in
            if newValue > 0 && currentCharacter == nil {
                pickRandomCharacter()
            }
        }
    }

    private func pickRandomCharacter() {
        guard !store.characters.isEmpty else { return }
        currentCharacter = store.characters.randomElement()
    }
}

#Preview {
    let store = CharacterStore()
    return NavigationStack {
        RandomCharacterView(store: store)
    }
}

