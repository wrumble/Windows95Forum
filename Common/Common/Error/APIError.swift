public enum APIError: Error {
  case server(String)
  case parsing(String)

  public var title: String {
    switch self {
    case .server:
      return "Server error:"
    case .parsing:
      return "Parsing error:"
    }
  }

  public var message: String {
    switch self {
    case .server(let message):
      return message
    case .parsing(let message):
      return message
    }
  }
}
