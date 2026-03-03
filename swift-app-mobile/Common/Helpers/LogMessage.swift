import Foundation

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
    case api = "API"
}

func logDebug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(LogLevel.debug.rawValue)] [\(fileName):\(line)] \(function) → \(message)")
    #endif
}

func logInfo(_ message: String) {
    #if DEBUG
    print("[\(LogLevel.info.rawValue)] \(message)")
    #endif
}

func logWarning(_ message: String, file: String = #file, line: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(LogLevel.warning.rawValue)] [\(fileName):\(line)] \(message)")
    #endif
}

func logError(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(LogLevel.error.rawValue)] [\(fileName):\(line)] \(function) → \(message)")
    #endif
}

func logAPI(_ url: String, method: String = "", statusCode: Int? = nil) {
    #if DEBUG
    if let code = statusCode {
        print("[\(LogLevel.api.rawValue)] \(method) \(url) → \(code)")
    } else {
        print("[\(LogLevel.api.rawValue)] \(method) \(url)")
    }
    #endif
}
