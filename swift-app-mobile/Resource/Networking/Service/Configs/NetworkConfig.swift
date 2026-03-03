import Foundation

protocol NetworkConfig {
    var path: String { get }
    var endPoint: String { get }
    var task: HTTPTask { get }
    var method: HTTPMethod { get }
}
