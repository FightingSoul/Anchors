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

    public func pinToSuperview(excluding axis: Axis.X, offset: CGFloat) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        switch axis {
        case .leading:
            pin(.trailing, to: superview, constant: -offset)
            pin(.top, to: superview, constant: offset)
            pin(.bottom, to: superview, constant: -offset)
        case .trailing:
            pin(.leading, to: superview, constant: offset)
            pin(.top, to: superview, constant: offset)
            pin(.bottom, to: superview, constant: -offset)
        default:
            assertionFailure()
        }
    }

    public func pinToSuperview(excluding axis: Axis.Y, offset: CGFloat) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        switch axis {
        case .bottom:
            pin(.leading, to: superview, constant: offset)
            pin(.trailing, to: superview, constant: -offset)
            pin(.top, to: superview, constant: offset)
        case .top:
            pin(.leading, to: superview, constant: offset)
            pin(.trailing, to: superview, constant: -offset)
            pin(.bottom, to: superview, constant: -offset)
        default:
            assertionFailure()
        }
    }

    public func pinToSuperview(excluding axis: Axis.X, insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        switch axis {
        case .leading:
            pin(.trailing, to: superview, constant: insets.right)
            pin(.top, to: superview, constant: insets.top)
            pin(.bottom, to: superview, constant: insets.bottom)
        case .trailing:
            pin(.leading, to: superview, constant: insets.left)
            pin(.top, to: superview, constant: insets.top)
            pin(.bottom, to: superview, constant: insets.bottom)
        default:
            assertionFailure()
        }
    }

    public func pinToSuperview(excluding axis: Axis.Y, insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            assertionFailure()
            return
        }

        switch axis {
        case .bottom:
            pin(.leading, to: superview, constant: insets.left)
            pin(.trailing, to: superview, constant: insets.right)
            pin(.top, to: superview, constant: insets.top)
        case .top:
            pin(.leading, to: superview, constant: insets.left)
            pin(.trailing, to: superview, constant: insets.right)
            pin(.bottom, to: superview, constant: insets.bottom)
        default:
            assertionFailure()
        }
    }
}
