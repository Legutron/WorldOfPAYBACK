// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PaybackPackage",
	defaultLocalization: "en",
	platforms: [
		.iOS("17.0"),
	],
	products: [
		.library(
			name: "PaybackPackage",
			targets: ["PaybackPackage"]),
	],
	dependencies: [
		.package(
			url: "https://github.com/pointfreeco/swift-composable-architecture",
			from: "1.8.0"
		)
	],
	targets: [
		.target(
			name: "PaybackPackage"),
		.testTarget(
			name: "PaybackPackageTests",
			dependencies: ["PaybackPackage"]),
	]
)
