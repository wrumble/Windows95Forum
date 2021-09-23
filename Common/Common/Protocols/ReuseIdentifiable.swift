public protocol ReuseIdentifiable {
  static var identifier: String { get }
}

public extension ReuseIdentifiable {

  static var identifier: String {
    String(describing: self)
  }
}
