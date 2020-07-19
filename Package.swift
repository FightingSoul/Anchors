// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Anchors",
    platforms: [
        .iOS(.v11), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        .library(
            name: "Anchors",
            targets: ["Anchors"])
    ],
    targets: [
        .target(
            name: "Anchors",
            dependencies: [])
    ]
)
