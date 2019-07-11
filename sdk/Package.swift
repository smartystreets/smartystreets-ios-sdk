// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sdk",
    products: [
        .library(
            name: "sdk",
            targets: ["sdk"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "sdk",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "sdkTests",
            dependencies: ["sdk"],
            path: "Tests"),
    ]
)
