import SwiftUI

struct UserListView: View {
    private let allUsers = User.sampleUsers
    @State private var displayedUsers: [User] = []
    @State private var nextIndex: Int = 0

    var body: some View {
        List(displayedUsers) { user in
            NavigationLink {
                UserDetailView(user: user)
            } label: {
                UserRowView(user: user)
            }
            .onAppear {
                loadMoreIfNeeded(currentUser: user)
            }
        }
        .navigationTitle("Пользователи")
        .onAppear {
            if displayedUsers.isEmpty {
                loadInitial()
            }
        }
    }

    private func loadInitial() {
        let batchSize = 2
        let upperBound = min(batchSize, allUsers.count)
        displayedUsers = Array(allUsers.prefix(upperBound))
        nextIndex = upperBound
    }

    private func loadMoreIfNeeded(currentUser: User) {
        guard let last = displayedUsers.last, last.id == currentUser.id else { return }
        guard nextIndex < allUsers.count else { return }

        let batchSize = 1
        let endIndex = min(nextIndex + batchSize, allUsers.count)
        let newUsers = allUsers[nextIndex..<endIndex]

        withAnimation {
            displayedUsers.append(contentsOf: newUsers)
        }

        nextIndex = endIndex
    }
}

struct UserRowView: View {
    let user: User

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.blue)

            VStack(alignment: .leading, spacing: 4) {
                Text(user.firstName)
                    .font(.headline)
                Text(user.position)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        UserListView()
    }
}

