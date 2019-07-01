// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "smartystreets-ios-sdk",
    dependencies: [],
    targets: [
        .target(
            name: "smartystreets-ios-sdk",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "smartystreets-ios-sdkTests",
            dependencies: ["smartystreets-ios-sdk"],
            path: "Tests"),
    ]
)
