import Combine

private struct Constants {
  static let host = "jsonplaceholder.typicode.com"
  static let scheme = "https"
  static let rootPath = "/"
  static let retriesOnError = 1
}

public protocol ForumClientProtocol {
  func execute<T: Codable>(_ endpoint: Endpoint) -> AnyPublisher<[T], APIError>
}

public class ForumClient: ForumClientProtocol {

  private let session: URLSession

  public init(session: URLSession = URLSession.shared) {
    self.session = session
  }

  public func execute<T: Codable>(_ endpoint: Endpoint) -> AnyPublisher<[T], APIError> {
    let urlRequest = request(for: endpoint)

    return session.dataTaskPublisher(for: urlRequest)
      .mapError { APIError.server($0.localizedDescription) }
      .map { $0.data }
      .decode(type: [T].self, decoder: JSONDecoder())
      .mapError {  APIError.parsing($0.localizedDescription) }
      .retry(Constants.retriesOnError)
      .eraseToAnyPublisher()
  }
}

// MARK: Private

private extension ForumClient {
  func request(for endpoint: Endpoint) -> URLRequest {

    let components = components(for: endpoint)

    guard let url = components.url else {
      preconditionFailure(PreconditionFailure.url)
    }

    return URLRequest(url: url)
  }

  func components(for endpoint: Endpoint) -> URLComponents {
    var components = URLComponents()
    components.scheme = Constants.scheme
    components.host = Constants.host
    components.path = "\(Constants.rootPath)\(endpoint.path)"

    return components
  }
}

