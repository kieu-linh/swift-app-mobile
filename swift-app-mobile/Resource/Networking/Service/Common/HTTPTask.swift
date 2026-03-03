import Foundation

typealias Parameters = [String: Any]

struct UploadFileParams {
    let data: Data
    let fileName: String
    let mimeType: String
    let fieldName: String
    let parameters: Parameters?

    init(data: Data, fileName: String, mimeType: String, fieldName: String = "file", parameters: Parameters? = nil) {
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
        self.fieldName = fieldName
        self.parameters = parameters
    }
}

struct UploadListFileParams {
    let files: [(data: Data, fileName: String, mimeType: String, fieldName: String)]
    let parameters: Parameters?
}

enum HTTPTask {
    case request
    case requestBody(Data)
    case requestUrlParameters(Parameters)
    case uploadFile(params: UploadFileParams)
    case uploadListFile(params: UploadListFileParams)
}
