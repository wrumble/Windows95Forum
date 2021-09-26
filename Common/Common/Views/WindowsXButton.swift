import UIKit

public class WindowsXButton: UIButton {

  private let contentView = UIView()
  private let shadeView = UIView()

  public required init() {

      super.init(frame: .zero)

      setup()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  public override func draw(_ rect: CGRect) {
    super.draw(rect)

    applyWindows95Style(rect: rect, contentView: contentView, shadeView: shadeView)
  }
}

extension WindowsXButton: Subviewable {
  public func setHierarchy() { }

  public func setUI() {
    backgroundColor = .windowsGrey
    setImage(.windowsX , for: .normal)
  }

  public func setLayout() { }
}
