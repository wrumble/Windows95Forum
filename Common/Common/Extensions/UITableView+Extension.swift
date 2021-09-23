import GlovoUtilities

public typealias ReusableTableViewCell = UITableViewCell & ReuseIdentifiable

// MARK: - Registering

public extension UITableView {

  func register<T: ReusableTableViewCell>(_ cellClass: T.Type) {
    self.register(cellClass.self, forCellReuseIdentifier: cellClass.identifier)
  }

}

// MARK: - Dequeuing

public extension UITableView {

  func dequeue<T: ReusableTableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError(
        "Failed to dequeue a cell with identifier \(T.identifier) matching type \(T.self) for indexPath: \(indexPath).")
    }
    return cell
  }

}
