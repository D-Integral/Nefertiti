// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Nefertiti",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Nefertiti",
            targets: ["Nefertiti"]),
    ],
    dependencies: [
        .package(url: "https://github.com/D-Integral/NefertitiFile", from: "1.0.4"),
        .package(url: "https://github.com/D-Integral/NefertitiFontSizeCalculator", from: "1.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Nefertiti", dependencies: [
                "NefertitiFile",
                "NefertitiFontSizeCalculator"
            ]),
        .testTarget(
            name: "NefertitiTests",
            dependencies: ["Nefertiti"]),
    ]
)
