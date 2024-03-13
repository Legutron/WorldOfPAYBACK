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
			targets: ["PaybackPackage"]
		),
		.library(
			name: "Common",
			targets: ["Common"]
		),
		.library(
			name: "Localization",
			targets: ["Localization"]
		),
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
			dependencies: ["PaybackPackage"]
		),
		.target(
			name: "Common",
			dependencies: [
				.product(
					name: "ComposableArchitecture",
					package: "swift-composable-architecture"
				),
			],
			resources: [
				.process("Resources"),
			]
		),
		.target(
			name: "Localization",
			dependencies: [],
			resources: [
				.process("Resources"),
			]
		),
	]
)
