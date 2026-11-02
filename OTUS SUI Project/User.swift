import Foundation

struct User: Identifiable {
    let id = UUID()
    let fullName: String
    let position: String
    let address: String

    var firstName: String {
        fullName.split(separator: " ").first.map(String.init) ?? fullName
    }
}

extension User {
    static let sampleUsers: [User] = [
        User(
            fullName: "Рик Санчес",
            position: "Безумный ученый",
            address: "Гараж, дом семьи Смитов, Земля C-137"
        ),
        User(
            fullName: "Морти Смит",
            position: "Школьник",
            address: "Гараж, дом семьи Смитов, Земля C-137"
        ),
        User(
            fullName: "Саммер Смит",
            position: "Старшеклассница",
            address: "Гараж, дом семьи Смитов, Земля C-137"
        ),
        User(
            fullName: "Бет Смит",
            position: "Ветеринар-хирург",
            address: "Гараж, дом семьи Смитов, Земля C-137"
        )
    ]
}

