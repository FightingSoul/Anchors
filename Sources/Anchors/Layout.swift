import UIKit

public enum Equality {
    case lessThanOrEqual
    case equal
    case greaterThanOrEqual
}

public enum Dimension {
    case width
    case height

    public var anchor: KeyPath<DimensionProviding, NSLayoutDimension> {
        switch self {
        case .height:
            return \.heightAnchor
        case .width:
            return \.widthAnchor
        }
    }
}

public struct Axis {
    public enum X {
        case leading
        case trailing
        case centerX

        public var anchor: KeyPath<AxisXProviding, NSLayoutXAxisAnchor> {
            switch self {
            case .leading:
                return \.leadingAnchor
            case .trailing:
                return \.trailingAnchor
            case .centerX:
                return \.centerXAnchor
            }
        }
    }
}

extension Axis {
    public enum Y {
        case top
        case bottom
        case centerY

        public var anchor: KeyPath<AxisYProviding, NSLayoutYAxisAnchor> {
            switch self {
            case .top:
                return \.topAnchor
            case .bottom:
                return \.bottomAnchor
            case .centerY:
                return \.centerYAnchor
            }
        }
    }
}
