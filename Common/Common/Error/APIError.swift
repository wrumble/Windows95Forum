public enum APIError: Error, Equatable {
  case server(String)
  case parsing(String)

  public var title: String {
    switch self {
    case .server:
      return .serverError + ":"
    case .parsing:
      return .parsingError + ":"
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
