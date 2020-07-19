import UIKit

public protocol AnchorSettable {
    var superview: UIView? { get }
}

extension UIView: AnchorSettable {}
extension UILayoutGuide: AnchorSettable {
    public var superview: UIView? {
        owningView
    }
}

extension AnchorSettable where Self: AxisXProviding & AxisYProviding {
    public func pinToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        pin(to: superview, insets: insets)
    }

    public func pinToSuperview(offset: CGFloat) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        pin(to: superview, offset: offset)
    }

    public func pinToSafeArea(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        pin(to: superview.safeAreaLayoutGuide, insets: insets)
    }

    public func pinToSafeArea(offset: CGFloat) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        pin(to: superview.safeAreaLayoutGuide, offset: offset)
    }

    public func pin(to v2: AxisXProviding & AxisYProviding, insets: UIEdgeInsets = .zero) {
        pin(.leading, to: v2, constant: insets.left)
        pin(.trailing, to: v2, constant: insets.right)
        pin(.top, to: v2, constant: insets.top)
        pin(.bottom, to: v2, constant: insets.bottom)
    }

    public func pin(to v2: AxisXProviding & AxisYProviding, offset: CGFloat) {
        pin(.leading, to: v2, constant: offset)
        pin(.trailing, to: v2, constant: -offset)
        pin(.top, to: v2, constant: offset)
        pin(.bottom, to: v2, constant: -offset)
    }
}
