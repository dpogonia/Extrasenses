import SwiftUI

struct RandomPsychicView: View {
    @ObservedObject var store: PsychicStore
    @State private var currentPsychic: Psychic?

    var body: some View {
        VStack {
            if let psychic = currentPsychic ?? store.psychics.randomElement() {
                PsychicDetailView(psychic: psychic)
            } else {
                Text("Нет данных об экстрасенсах")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            Button("Показать другого экстрасенса") {
                pickRandomPsychic()
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .navigationTitle("Random")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if currentPsychic == nil {
                pickRandomPsychic()
            }
        }
    }

    private func pickRandomPsychic() {
        currentPsychic = store.psychics.randomElement()
    }
}

#Preview {
    NavigationStack {
        RandomPsychicView(store: PsychicStore())
    }
}

