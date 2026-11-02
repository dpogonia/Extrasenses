import Foundation

struct CharacterResponse: Decodable {
    let info: PageInfo
    let results: [RMCharacter]
}

struct PageInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct RMCharacter: Identifiable, Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let created: String
    let episode: [String]
    let origin: LocationInfo
    let location: LocationInfo

    struct LocationInfo: Decodable {
        let name: String
    }
}

