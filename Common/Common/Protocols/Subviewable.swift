import Foundation

@objc public protocol Subviewable {
    func setHierarchy()
    func setUI()
    func setLayout()
}

extension Subviewable {
    public func setup() {
      setHierarchy()
      setUI()
      setLayout()
    }
}
