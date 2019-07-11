// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "samples",
    dependencies: [
        .package(path: "../sdk"),
    ],
    targets: [
        .target(
            name: "samples",
            dependencies: ["sdk"]),
        .testTarget(
            name: "samplesTests",
            dependencies: ["samples"]),
    ]
)
