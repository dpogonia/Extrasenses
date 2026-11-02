import SwiftUI

struct PsychicDetailView: View {
    let psychic: Psychic

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image(psychic.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, minHeight: 320, maxHeight: 360)
                    .clipped()

                VStack(alignment: .leading, spacing: 12) {
                    Text(psychic.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .allowsTightening(true)

                    Text(psychic.description)
                        .font(.body)

                    HStack(alignment: .top, spacing: 8) {
                        Text("Суперсила:")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.accentColor)
                        Text(psychic.superpower)
                            .font(.body)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(psychic.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PsychicDetailView(psychic: Psychic.all.first!)
    }
}

