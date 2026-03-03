import Foundation

struct TokenResponseDTO: Decodable {
    let data: TokenDataDTO
}

struct TokenDataDTO: Decodable {
    let accessToken: String
    let user: UserDTO

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case user
    }
}

struct UserDTO: Decodable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let role: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case role
    }

    func toDomain() -> UserEntity {
        UserEntity(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            role: role
        )
    }
}
