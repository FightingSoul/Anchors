import UIKit

public protocol AxisXProviding {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
}

extension UIView: AxisXProviding {}
extension UILayoutGuide: AxisXProviding {}

extension AnchorSettable where Self: AxisXProviding {
    @discardableResult
    public func pin(
        _ a1: Axis.X,
        equalTo a2: Axis.X,
        of v2: AxisXProviding,
        priority: UILayoutPriority = .required,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        pin(a1, .equal, to: a2, of: v2, priority: priority, constant: c, isActive: isActive)
    }

    @discardableResult
    public func pin(
        _ a1: Axis.X,
        _ equality: Equality,
        to a2: Axis.X,
        of v2: AxisXProviding,
        priority: UILayoutPriority = .required,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a1 = self[keyPath: a1.anchor]
        let a2 = v2[keyPath: a2.anchor]
        let constraint: NSLayoutConstraint

        switch equality {
        case .lessThanOrEqual:
            constraint = a1.constraint(lessThanOrEqualTo: a2, constant: c)
        case .equal:
            constraint = a1.constraint(equalTo: a2, constant: c)
        case .greaterThanOrEqual:
            constraint = a1.constraint(greaterThanOrEqualTo: a2, constant: c)
        }

        constraint.priority = priority
        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    public func pin(
        _ a1: Axis.X,
        _ equality: Equality,
        toSystemSpacingAfter a2: Axis.X,
        of v2: AxisXProviding,
        priority: UILayoutPriority = .required,
        multiplier m: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a1 = self[keyPath: a1.anchor]
        let a2 = v2[keyPath: a2.anchor]
        let constraint: NSLayoutConstraint

        switch equality {
        case .lessThanOrEqual:
            constraint = a1.constraint(lessThanOrEqualToSystemSpacingAfter: a2, multiplier: m)
        case .equal:
            constraint = a1.constraint(equalToSystemSpacingAfter: a2, multiplier: m)
        case .greaterThanOrEqual:
            constraint = a1.constraint(greaterThanOrEqualToSystemSpacingAfter: a2, multiplier: m)
        }

        constraint.priority = priority
        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    public func pin(
        _ a1: Axis.X,
        to v2: AxisXProviding,
        priority: UILayoutPriority = .required,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a2 = v2[keyPath: a1.anchor]
        let a1 = self[keyPath: a1.anchor]

        let constraint = a1.constraint(equalTo: a2, constant: c)
        constraint.priority = priority
        constraint.isActive = isActive
        return constraint
    }
}
