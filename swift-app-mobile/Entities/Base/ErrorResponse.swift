import Foundation

struct ErrorDetail: Codable {
    let code: String
    let detail: String
}

struct ErrorResponse: Codable, Error {
    let errors: [ErrorDetail]

    var firstMessage: String {
        errors.first?.detail ?? "An unknown error occurred"
    }
}
