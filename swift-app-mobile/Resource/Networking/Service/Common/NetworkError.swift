import Foundation

enum NetworkError: LocalizedError {
    case missingURL
    case noConnection
    case invalidData
    case requestFailed(statusCode: Int)
    case encodingError
    case decodingError
    case invalidResponse
    case unauthorized
    case serverError(String)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .missingURL:
            return "The URL is missing or invalid."
        case .noConnection:
            return "No internet connection. Please check your network settings."
        case .invalidData:
            return "The data received from the server is invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .encodingError:
            return "Failed to encode the request data."
        case .decodingError:
            return "Failed to decode the server response."
        case .invalidResponse:
            return "The server response is invalid."
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .serverError(let message):
            return "Server error: \(message)"
        case .unknown(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}
