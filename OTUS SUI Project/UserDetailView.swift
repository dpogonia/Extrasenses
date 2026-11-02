import SwiftUI
import UIKit

struct UserDetailView: View {
    let user: User

    @State private var showFullName = true
    @State private var copyMessageVisible = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(.blue)
                    .padding(.top, 24)

                Text(showFullName ? user.fullName : user.firstName)
                    .font(.title)
                    .fontWeight(.semibold)

                Button(showFullName ? "Показать только имя" : "Показать полное ФИО") {
                    withAnimation {
                        showFullName.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Информация")
                        .font(.headline)

                    HStack {
                        Text("Должность:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(user.position)
                    }

                    HStack(alignment: .top) {
                        Text("Адрес:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(user.address)
                            .multilineTextAlignment(.trailing)
                    }

                    Button {
                        UIPasteboard.general.string = user.address
                        withAnimation {
                            copyMessageVisible = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                copyMessageVisible = false
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "doc.on.doc")
                            Text("Скопировать адрес")
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                if copyMessageVisible {
                    Text("Адрес скопирован в буфер обмена")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                }

                Spacer(minLength: 24)
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(user.firstName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        UserDetailView(user: User.sampleUsers.first!)
    }
}

