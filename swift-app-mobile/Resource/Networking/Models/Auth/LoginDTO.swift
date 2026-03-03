import Foundation

struct LoginRequestDTO: Encodable {
    let username: String
    let password: String
}

struct RegisterRequestDTO: Encodable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String

    enum CodingKeys: String, CodingKey {
        case email
        case password
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct ForgotPasswordRequestDTO: Encodable {
    let email: String
}
