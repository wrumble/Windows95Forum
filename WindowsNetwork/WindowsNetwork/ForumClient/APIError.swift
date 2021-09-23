public enum APIError: Error {
  case server(String)
  case parsing(String)

  public var message: String {
    switch self {
    case .server(let message):
      return "Server error: \(message)"
    case .parsing(let message):
      return "Parsing error: \(message)"
    }
  }
}
