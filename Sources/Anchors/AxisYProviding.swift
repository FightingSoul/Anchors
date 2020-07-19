import UIKit

public protocol AxisYProviding {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: AxisYProviding {}
extension UILayoutGuide: AxisYProviding {}

extension AnchorSettable where Self: AxisYProviding {
    @discardableResult
    public func pin(
        _ a1: Axis.Y,
        equalTo a2: Axis.Y,
        of v2: AxisYProviding,
        constant c: CGFloat = 0,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        pin(a1, .equal, to: a2, of: v2, priority: priority, constant: c, isActive: isActive)
    }

    @discardableResult
    public func pin(
        _ a1: Axis.Y,
        _ equality: Equality,
        to a2: Axis.Y,
        of v2: AxisYProviding,
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
        _ a1: Axis.Y,
        _ equality: Equality,
        toSystemSpacingBelow a2: Axis.Y,
        of v2: AxisYProviding,
        priority: UILayoutPriority = .required,
        multiplier m: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a1 = self[keyPath: a1.anchor]
        let a2 = v2[keyPath: a2.anchor]
        let constraint: NSLayoutConstraint

        switch equality {
        case .lessThanOrEqual:
            constraint = a1.constraint(lessThanOrEqualToSystemSpacingBelow: a2, multiplier: m)
        case .equal:
            constraint = a1.constraint(equalToSystemSpacingBelow: a2, multiplier: m)
        case .greaterThanOrEqual:
            constraint = a1.constraint(greaterThanOrEqualToSystemSpacingBelow: a2, multiplier: m)
        }

        constraint.priority = priority
        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    public func pin(
        _ a1: Axis.Y,
        _ equality: Equality = .equal,
        to v2: AxisYProviding,
        priority: UILayoutPriority = .required,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a2 = v2[keyPath: a1.anchor]
        let a1 = self[keyPath: a1.anchor]
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
}
