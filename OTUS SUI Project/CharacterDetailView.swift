import SwiftUI

struct CharacterDetailView: View {
    let character: RMCharacter

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 280, maxHeight: 320)
                            .background(Color(.systemBackground))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit() // без искажения, возможны поля
                            .frame(maxWidth: .infinity, minHeight: 280, maxHeight: 320)
                            .background(Color(.systemBackground))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, minHeight: 280, maxHeight: 320)
                            .foregroundStyle(.secondary)
                            .background(Color(.systemBackground))
                    default:
                        EmptyView()
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("\(character.species) • \(character.status)")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    if !character.type.isEmpty {
                        HStack {
                            Text("Тип:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(character.type)
                        }
                    }

                    HStack(alignment: .top) {
                        Text("Пол:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(character.gender)
                    }

                    HStack(alignment: .top) {
                        Text("Происхождение:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(character.origin.name)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack(alignment: .top) {
                        Text("Последняя локация:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(character.location.name)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Эпизодов:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(character.episode.count)")
                    }

                    HStack {
                        Text("В API с:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(formattedCreatedDate)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var formattedCreatedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = isoFormatter.date(from: character.created) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        } else {
            return character.created
        }
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(
            character: RMCharacter(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                url: "https://rickandmortyapi.com/api/character/1",
                created: "2017-11-04T18:48:46.250Z",
                episode: [],
                origin: .init(name: "Earth (C-137)"),
                location: .init(name: "Citadel of Ricks")
            )
        )
    }
}

