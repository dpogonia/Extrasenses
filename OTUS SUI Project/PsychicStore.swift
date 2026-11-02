import SwiftUI
import Combine

@MainActor
final class PsychicStore: ObservableObject {
    @Published var psychics: [Psychic] = Psychic.all
}

