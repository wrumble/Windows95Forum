import UIKit

private struct Constants {
  static let titleLabelLeadingMargin: CGFloat = 4
  static let topBarLeadingMargin: CGFloat = 1
  static let topBarTrailingMargin: CGFloat = -3
  static let topBarTopMargin: CGFloat = 2
  static let topBarHeight: CGFloat = 40
}

public final class WindowsView: UIView {
  private let titleText: String

  private let titleLabel = UILabel()
  private let topBar = UIView()
  private let contentView = UIView()
  private let shadeView = UIView()

  public required init(titleText: String) {
    self.titleText = titleText
    super.init(frame: .zero)

    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func draw(_ rect: CGRect) {
    super.draw(rect)

    let outerBottom = UIBezierPath()
    let innerBottom = UIBezierPath()
    let innerTop = UIBezierPath()
    let outerTop = UIBezierPath()
    let lineWidth: CGFloat = 1
    let halfLineWidth: CGFloat = lineWidth/2

    outerBottom.lineWidth = lineWidth
    outerBottom.move(to: CGPoint(x: 0, y: bounds.height - halfLineWidth))
    outerBottom.addLine(to: CGPoint(x: bounds.width - halfLineWidth, y: bounds.height - halfLineWidth))
    outerBottom.addLine(to: CGPoint(x: bounds.width - halfLineWidth, y: 0))
    UIColor.black.set()
    outerBottom.stroke()

    innerBottom.lineWidth = lineWidth
    innerBottom.move(to: CGPoint(x: lineWidth, y: bounds.height - lineWidth * 1.5))
    innerBottom.addLine(to: CGPoint(x: bounds.width - lineWidth * 1.5, y: bounds.height - lineWidth * 1.5))
    innerBottom.addLine(to: CGPoint(x: bounds.width - lineWidth * 1.5, y: lineWidth))

    innerBottom.stroke()

    outerTop.lineWidth = lineWidth
    outerTop.move(to: CGPoint(x: halfLineWidth, y: bounds.height - lineWidth))
    outerTop.addLine(to: CGPoint(x: halfLineWidth, y: halfLineWidth))
    outerTop.addLine(to: CGPoint(x: bounds.width - lineWidth, y: halfLineWidth))
    UIColor.white.set()
    outerTop.stroke()

    innerTop.lineWidth = lineWidth
    innerTop.move(to: CGPoint(x: lineWidth * 1.5, y: bounds.height - lineWidth * 2))
    innerTop.addLine(to: CGPoint(x: lineWidth * 1.5, y: lineWidth * 1.5))
    innerTop.addLine(to: CGPoint(x: bounds.width - lineWidth * 2, y: lineWidth * 1.5))
    UIColor.white.set()
    innerTop.stroke()

    var contentFrame = CGRect()
    contentFrame.origin.x = lineWidth * 2
    contentFrame.origin.y = lineWidth * 2
    contentFrame.size.height = rect.size.height - lineWidth * 4
    contentFrame.size.width = rect.size.width - lineWidth * 4

    contentView.frame = contentFrame
    shadeView.frame = contentFrame
  }
}

extension WindowsView: Subviewable {
  public func setHierarchy() {
    addSubview(contentView)
    addSubview(shadeView)
    addSubview(topBar)
    addSubview(titleLabel)
  }

  public func setUI() {
    isOpaque = false

    contentView.isUserInteractionEnabled = false
    contentView.backgroundColor = .windowsGrey

    shadeView.backgroundColor = .white.withAlphaComponent(0.1)
    shadeView.isHidden = true

    topBar.backgroundColor = .windowsBlue

    titleLabel.text = titleText
    titleLabel.font = .topBarTitle
    titleLabel.textColor = .windowsFontWhite
  }

  public func setLayout() {
    setTopBarLayout()
    setTitleLabelLayout()
  }
}

private extension WindowsView {
  func setTopBarLayout() {
    topBar.translatesAutoresizingMaskIntoConstraints = false

    topBar.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor,
      constant: Constants.topBarLeadingMargin).isActive = true
    topBar.trailingAnchor.constraint(
      equalTo: contentView.trailingAnchor,
      constant: Constants.topBarTrailingMargin).isActive = true
    topBar.topAnchor.constraint(
      equalTo: contentView.topAnchor,
      constant: Constants.topBarTopMargin).isActive = true
    topBar.setHeight(to: Constants.topBarHeight)
  }

  func setTitleLabelLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    titleLabel.leadingAnchor.constraint(
      equalTo: topBar.leadingAnchor,
      constant: Constants.titleLabelLeadingMargin).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: topBar.trailingAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: topBar.topAnchor).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
  }
}