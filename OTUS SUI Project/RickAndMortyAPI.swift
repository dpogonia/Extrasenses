import Foundation

enum RickAndMortyAPIError: Error {
    case invalidURL
    case invalidResponse
}

final class RickAndMortyAPI {
    static let shared = RickAndMortyAPI()

    private init() {}

    func fetchCharacters(page: Int) async throws -> CharacterResponse {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(page)") else {
            throw RickAndMortyAPIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw RickAndMortyAPIError.invalidResponse
        }

        return try JSONDecoder().decode(CharacterResponse.self, from: data)
    }

    func fetchAllCharacters(progress: ((Double) -> Void)? = nil) async throws -> [RMCharacter] {
        var allCharacters: [RMCharacter] = []
        var currentPage = 1
        var totalCount: Int?

        while true {
            let response = try await fetchCharacters(page: currentPage)
            allCharacters.append(contentsOf: response.results)

            if totalCount == nil {
                totalCount = response.info.count
            }

            if let totalCount, totalCount > 0 {
                let progressValue = Double(allCharacters.count) / Double(totalCount)
                progress?(min(progressValue, 1.0))
            }

            guard response.info.next != nil else {
                break
            }

            currentPage += 1
        }

        return allCharacters
    }
}

