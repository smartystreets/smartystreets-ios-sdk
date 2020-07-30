// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "samples",
    dependencies: [
        .package(path: ".."),
    ],
    targets: [
        .target(
            name: "swiftExamples",
            dependencies: ["sdk"]),
        .target(
            name: "objcExamples",
            dependencies: ["sdk"]),
        .testTarget(
            name: "samplesTests",
            dependencies: ["swiftExamples"],
            path: "Tests"),
    ]
)
