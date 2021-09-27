import UIKit

extension UIView {
  public func setHeight(to height: CGFloat) {
    let heightConstraint = NSLayoutConstraint(item: self,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .height,
                                              multiplier: 0,
                                              constant: 0)
    heightConstraint.constant = height
    heightConstraint.isActive = true
  }

  public func setWidth(to width: CGFloat) {
    let widthConstraint = NSLayoutConstraint(item: self,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .width,
                                              multiplier: 0,
                                              constant: 0)
    widthConstraint.constant = width
    widthConstraint.isActive = true
  }

  public func applyExternalWindows95Style(rect: CGRect, contentView: UIView, shadeView: UIView) {
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

  public func applyInternalWindows95Style() {
    let outerBottom = UIBezierPath()
    let innerBottom = UIBezierPath()
    let innerTop = UIBezierPath()
    let outerTop = UIBezierPath()
    let lineWidth: CGFloat = 1

    outerBottom.lineWidth = lineWidth
    outerBottom.move(to: CGPoint(x: 0, y: bounds.height - safeAreaInsets.bottom - lineWidth * 1.5))
    outerBottom.addLine(to: CGPoint(x: bounds.width, y: bounds.height - safeAreaInsets.bottom - lineWidth * 1.5))
    UIColor(white: 0, alpha: 0.3).set()
    outerBottom.stroke()

    innerBottom.lineWidth = lineWidth
    innerBottom.move(to: CGPoint(x: 0, y: bounds.height - safeAreaInsets.bottom - lineWidth * 0.5))
    innerBottom.addLine(to: CGPoint(x: bounds.width, y: bounds.height - safeAreaInsets.bottom - lineWidth * 0.5))
    UIColor(white: 1, alpha: 0.5).set()
    innerBottom.stroke()

    outerTop.lineWidth = lineWidth
    outerTop.move(to: CGPoint(x: 0, y: lineWidth * 0.5 + safeAreaInsets.top))
    outerTop.addLine(to: CGPoint(x: bounds.width, y: lineWidth * 0.5 + safeAreaInsets.top))
    UIColor(white: 0, alpha: 0.3).set()
    outerTop.stroke()

    innerTop.lineWidth = lineWidth
    innerTop.move(to: CGPoint(x: 0, y: lineWidth * 1.5 + safeAreaInsets.top))
    innerTop.addLine(to: CGPoint(x: bounds.width, y: lineWidth * 1.5 + safeAreaInsets.top))
    UIColor(white: 1, alpha: 0.5).set()
    innerTop.stroke()
  }
}
