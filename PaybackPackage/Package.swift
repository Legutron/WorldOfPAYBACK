// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaybackPackage",
    products: [
        .library(
            name: "PaybackPackage",
            targets: ["PaybackPackage"]),
    ],
    targets: [
        .target(
            name: "PaybackPackage"),
        .testTarget(
            name: "PaybackPackageTests",
            dependencies: ["PaybackPackage"]),
    ]
)
