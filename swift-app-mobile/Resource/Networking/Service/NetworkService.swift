import Foundation

final class NetworkService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let keychainService: KeychainService
    private let baseURL: String

    init(keychainService: KeychainService, baseURL: String = AppConfig.shared.baseURL) {
        self.keychainService = keychainService
        self.baseURL = baseURL
    }

    // MARK: - Request without response body

    func request(with config: NetworkConfig, useToken: Bool = false) async throws {
        let (_, response) = try await makeRequest(config: config, useToken: useToken)
        try handleResponse(response)
    }

    // MARK: - Request with decodable response

    func request<Model: Decodable>(
        with config: NetworkConfig,
        useToken: Bool = false
    ) async throws -> Model {
        let (data, response) = try await makeRequest(config: config, useToken: useToken)
        try handleResponse(response, data)

        do {
            let model = try decoder.decode(Model.self, from: data)
            return model
        } catch {
            let urlString = baseURL + config.path + config.endPoint
            logError("Decoding error: \(error)")
            logAPI(urlString, method: config.method.rawValue)
            logDebug("Response data: \(String(data: data, encoding: .utf8) ?? "N/A")")
            throw NetworkError.decodingError
        }
    }

    // MARK: - Encode helper

    func encode<Value: Encodable>(_ value: Value) throws -> Data {
        guard let encoded = try? encoder.encode(value) else {
            throw NetworkError.encodingError
        }
        return encoded
    }
}

// MARK: - Private

private extension NetworkService {

    func makeRequest(config: NetworkConfig, useToken: Bool) async throws -> (Data, URLResponse) {
        let urlString = baseURL + config.path + config.endPoint
        guard let url = URL(string: urlString) else {
            throw NetworkError.missingURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = config.method.rawValue

        // Token injection
        if useToken {
            if let token = keychainService.getTokenValue() {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }

        // Build request based on task type
        request = try buildRequest(request, with: config.task)

        logAPI(urlString, method: config.method.rawValue)

        let (data, response) = try await URLSession.shared.data(for: request)
        return (data, response)
    }

    func buildRequest(_ request: URLRequest, with task: HTTPTask) throws -> URLRequest {
        var request = request

        switch task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        case .requestBody(let data):
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data

        case .requestUrlParameters(let parameters):
            let encoder = URLParameterEncoder()
            try encoder.encode(urlRequest: &request, with: parameters)

        case .uploadFile(let params):
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createMultipartBody(params: params, boundary: boundary)

        case .uploadListFile(let params):
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createListMultipartBody(params: params, boundary: boundary)
        }

        return request
    }

    func handleResponse(_ response: URLResponse, _ data: Data? = nil) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        logAPI("Response", statusCode: httpResponse.statusCode)

        switch httpResponse.statusCode {
        case 200...299:
            return
        case 401:
            throw NetworkError.unauthorized
        case 400...499:
            if let data = data,
               let errorMessage = String(data: data, encoding: .utf8) {
                throw NetworkError.serverError(errorMessage)
            }
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        case 500...599:
            throw NetworkError.serverError("Internal server error")
        default:
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }

    func createMultipartBody(params: UploadFileParams, boundary: String) -> Data {
        var body = Data()
        let lineBreak = "\r\n"

        // Add parameters
        if let parameters = params.parameters {
            for (key, value) in parameters {
                body.append("--\(boundary)\(lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak)\(lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }

        // Add file
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(params.fieldName)\"; filename=\"\(params.fileName)\"\(lineBreak)")
        body.append("Content-Type: \(params.mimeType)\(lineBreak)\(lineBreak)")
        body.append(params.data)
        body.append(lineBreak)
        body.append("--\(boundary)--\(lineBreak)")

        return body
    }

    func createListMultipartBody(params: UploadListFileParams, boundary: String) -> Data {
        var body = Data()
        let lineBreak = "\r\n"

        // Add parameters
        if let parameters = params.parameters {
            for (key, value) in parameters {
                body.append("--\(boundary)\(lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak)\(lineBreak)")
                body.append("\(value)\(lineBreak)")
            }
        }

        // Add files
        for file in params.files {
            body.append("--\(boundary)\(lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(file.fieldName)\"; filename=\"\(file.fileName)\"\(lineBreak)")
            body.append("Content-Type: \(file.mimeType)\(lineBreak)\(lineBreak)")
            body.append(file.data)
            body.append(lineBreak)
        }

        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}

// MARK: - Data Extension for Multipart

private extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
