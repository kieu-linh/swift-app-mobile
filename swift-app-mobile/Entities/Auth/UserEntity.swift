import Foundation

struct UserEntity {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let role: String?

    var fullName: String {
        "\(firstName) \(lastName)".trimmed
    }
}
