import UIKit

public protocol DimensionProviding {
    var heightAnchor: NSLayoutDimension { get }
    var widthAnchor: NSLayoutDimension { get }
}

extension UIView: DimensionProviding {}
extension UILayoutGuide: DimensionProviding {}

extension AnchorSettable where Self: DimensionProviding {
    @discardableResult
    public func set(
        _ d1: Dimension,
        equalTo d2: Dimension,
        multiplier m: CGFloat = 1,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        set(d1, .equal, to: d2, multiplier: m, constant: c, isActive: isActive)
    }

    @discardableResult
    public func set(
        _ d1: Dimension,
        _ equality: Equality,
        to d2: Dimension,
        multiplier m: CGFloat = 1,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a1 = self[keyPath: d1.anchor]
        let a2 = self[keyPath: d2.anchor]
        let constraint: NSLayoutConstraint

        switch equality {
        case .lessThanOrEqual:
            constraint = a1.constraint(lessThanOrEqualTo: a2, multiplier: m, constant: c)
        case .equal:
            constraint = a1.constraint(equalTo: a2, multiplier: m, constant: c)
        case .greaterThanOrEqual:
            constraint = a1.constraint(greaterThanOrEqualTo: a2, multiplier: m, constant: c)
        }

        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    public func set(
        _ d1: Dimension,
        equalTo d2: Dimension,
        of v2: DimensionProviding,
        multiplier m: CGFloat = 1,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        set(d1, .equal, to: d2, of: v2, multiplier: m, constant: c, isActive: isActive)
    }

    @discardableResult
    public func set(
        _ d1: Dimension,
        _ equality: Equality,
        to d2: Dimension,
        of v2: DimensionProviding,
        multiplier m: CGFloat = 1,
        constant c: CGFloat = 0,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a1 = self[keyPath: d1.anchor]
        let a2 = v2[keyPath: d2.anchor]
        let constraint: NSLayoutConstraint

        switch equality {
        case .lessThanOrEqual:
            constraint = a1.constraint(lessThanOrEqualTo: a2, multiplier: m, constant: c)
        case .equal:
            constraint = a1.constraint(equalTo: a2, multiplier: m, constant: c)
        case .greaterThanOrEqual:
            constraint = a1.constraint(greaterThanOrEqualTo: a2, multiplier: m, constant: c)
        }

        constraint.isActive = isActive
        return constraint
    }

    @discardableResult
    public func set(
        _ d1: Dimension,
        equalTo c: CGFloat,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        set(d1, .equal, to: c, isActive: isActive)
    }

    @discardableResult
    public func set(
        _ d1: Dimension,
        _ equality: Equality,
        to c: CGFloat,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        let a1 = self[keyPath: d1.anchor]
        let constraint: NSLayoutConstraint

        switch equality {
        case .lessThanOrEqual:
            constraint = a1.constraint(lessThanOrEqualToConstant: c)
        case .equal:
            constraint = a1.constraint(equalToConstant: c)
        case .greaterThanOrEqual:
            constraint = a1.constraint(greaterThanOrEqualToConstant: c)
        }

        constraint.isActive = isActive
        return constraint
    }
}
