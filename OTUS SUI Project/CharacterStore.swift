import SwiftUI
import Combine

@MainActor
final class CharacterStore: ObservableObject {
    @Published var characters: [RMCharacter] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var progress: Double = 0.0

    func loadCharactersIfNeeded() async {
        guard !isLoading, characters.isEmpty else { return }
        await loadCharacters()
    }

    func reloadCharacters() async {
        await loadCharacters()
    }

    private func loadCharacters() async {
        isLoading = true
        errorMessage = nil
        progress = 0.0

        do {
            let loaded = try await RickAndMortyAPI.shared.fetchAllCharacters { [weak self] value in
                Task { @MainActor in
                    self?.progress = value
                }
            }
            characters = loaded
            isLoading = false
            progress = 1.0
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}

