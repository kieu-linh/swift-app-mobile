import Foundation

enum Either<S, E: Error> {
    case success(S)
    case failure(E)

    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }

    var isFailure: Bool {
        return !isSuccess
    }

    var value: S? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }

    var error: E? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}
