// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmartyStreets",
    products: [
        .library(
            name: "SmartyStreets",
            targets: ["SmartyStreets"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SmartyStreets",
            dependencies: [],
            path: "Sources/SmartyStreets"),
        .testTarget(
            name: "SmartyStreetsTests",
            dependencies: ["SmartyStreets"],
            path: "Tests/SmartyStreetsTests"),
    ]
)
