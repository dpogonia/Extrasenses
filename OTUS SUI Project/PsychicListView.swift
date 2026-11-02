import SwiftUI

struct PsychicListView: View {
    @ObservedObject var store: PsychicStore
    @State private var searchText: String = ""

    private var filteredPsychics: [Psychic] {
        guard !searchText.isEmpty else { return store.psychics }
        return store.psychics.filter { psychic in
            psychic.name.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        List(filteredPsychics) { psychic in
            NavigationLink {
                PsychicDetailView(psychic: psychic)
            } label: {
                PsychicRowView(psychic: psychic)
            }
        }
        .listStyle(.plain)
        .padding(.top, -8)
        .navigationTitle("Экстрасенсы")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Поиск экстрасенса")
    }
}

struct PsychicRowView: View {
    let psychic: Psychic

    var body: some View {
        HStack(spacing: 16) {
            Image(psychic.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(psychic.name)
                    .font(.headline)
                Text(psychic.description)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        PsychicListView(store: PsychicStore())
    }
}

