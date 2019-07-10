// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "smartystreetsiOSSDKExecutable",
    dependencies: [
        .package(path: "../smartystreetsiOSSDKCore"),
    ],
    targets: [
        .target(
            name: "smartystreetsiOSSDKExecutable",
            dependencies: ["smartystreetsiOSSDKCore"]),
        .testTarget(
            name: "smartystreetsiOSSDKExecutableTests",
            dependencies: ["smartystreetsiOSSDKExecutable"]),
    ]
)
