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
}
