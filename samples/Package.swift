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
            dependencies: ["sdk"],
            path: "Sources"),
        .testTarget(
            name: "samplesTests",
            dependencies: ["samples"],
            path: "Tests"),
    ]
)
