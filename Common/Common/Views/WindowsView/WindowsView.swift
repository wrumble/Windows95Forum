import UIKit
import Combine

private struct Constants {
  static let titleLabelLeadingMargin: CGFloat = 4
  static let topBarLeadingMargin: CGFloat = 3
  static let topBarTrailingMargin: CGFloat = -5
  static let topBarTopMargin: CGFloat = 3
  static let topBarHeight: CGFloat = 30
  static let windowsXButtonTrailingMargin: CGFloat = -4
  static let windowsXLength: CGFloat = 20
}

public final class WindowsView: UIView {

  private let viewModel: WindowsViewModelProtocol

  let testButton = UIButton()

  private let windowsXButton = WindowsXButton()
  private let titleLabel = UILabel()
  private let topBar = UIView()
  private let contentView = UIView()
  private let shadeView = UIView()

  private var publishers = [AnyCancellable]()
  private var xButtonTapped = PassthroughSubject<Void, Never>()

  public required init(viewModel: WindowsViewModelProtocol) {
    self.viewModel = viewModel

    super.init(frame: .zero)

    setup()
    bindViewModel()
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

private extension WindowsView {
  func bindViewModel() {
    xButtonTapped
      .sink(receiveValue: { [weak self] _ in
        guard let self = self else {
          return
        }
        self.viewModel.xButtonTapped.send()
      })
      .store(in: &publishers)

    viewModel.titleText
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] text in
        guard let self = self else {
          return
        }
        self.titleLabel.text = text
      })
      .store(in: &publishers)

    viewModel.hideXButton
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] shouldHideButton in
        guard let self = self else {
          return
        }
        self.windowsXButton.isHidden = shouldHideButton
      })
      .store(in: &publishers)
  }
}

extension WindowsView: Subviewable {
  public func setHierarchy() {
    addSubview(contentView)
    addSubview(shadeView)
    addSubview(topBar)
    addSubview(titleLabel)
    addSubview(windowsXButton)
  }

  public func setUI() {
    isOpaque = false

    contentView.isUserInteractionEnabled = false
    contentView.backgroundColor = .windowsGrey

    shadeView.backgroundColor = .white.withAlphaComponent(0.1)
    shadeView.isHidden = true

    topBar.backgroundColor = .windowsBlue

    titleLabel.font = .topBarTitle
    titleLabel.textColor = .windowsFontWhite
    titleLabel.numberOfLines = 1

    windowsXButton.addTarget(self, action: #selector(windowsXButtonTapped), for: .touchUpInside)

  }

  public func setLayout() {
    setTopBarLayout()
    setTitleLabelLayout()
    setWindowsXButtonLayout()
  }
}

private extension WindowsView {
  @objc func windowsXButtonTapped() {
    xButtonTapped.send()
  }

  func setTopBarLayout() {
    topBar.translatesAutoresizingMaskIntoConstraints = false

    topBar.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constants.topBarLeadingMargin).isActive = true
    topBar.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: Constants.topBarTrailingMargin).isActive = true
    topBar.topAnchor.constraint(
      equalTo: topAnchor,
      constant: Constants.topBarTopMargin).isActive = true
    topBar.setHeight(to: Constants.topBarHeight)
  }

  func setTitleLabelLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    titleLabel.leadingAnchor.constraint(
      equalTo: topBar.leadingAnchor,
      constant: Constants.titleLabelLeadingMargin).isActive = true
    titleLabel.trailingAnchor.constraint(
      equalTo: windowsXButton.leadingAnchor).isActive = true
    titleLabel.topAnchor.constraint(
      equalTo: topBar.topAnchor).isActive = true
    titleLabel.bottomAnchor.constraint(
      equalTo: topBar.bottomAnchor).isActive = true
  }

  func setWindowsXButtonLayout() {
    windowsXButton.translatesAutoresizingMaskIntoConstraints = false

    windowsXButton.leadingAnchor.constraint(
      equalTo: titleLabel.trailingAnchor).isActive = true
    windowsXButton.trailingAnchor.constraint(
      equalTo: topBar.trailingAnchor,
      constant: Constants.windowsXButtonTrailingMargin).isActive = true
    windowsXButton.centerYAnchor.constraint(
      equalTo: topBar.centerYAnchor).isActive = true
    windowsXButton.setWidth(to: Constants.windowsXLength)
    windowsXButton.setHeight(to: Constants.windowsXLength)
  }
}
