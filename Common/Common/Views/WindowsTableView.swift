import UIKit

public class WindowsTableView: UITableView {

  public override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func draw(_ rect: CGRect) {
    super.draw(rect)

    applyInternalWindows95Style()
  }
}

// MARK: Private

extension WindowsTableView: Subviewable {
  public func setHierarchy() { }

  public func setUI() {
    backgroundColor = .windowsWhite
  }

  public func setLayout() { }
}
