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
			name: "CoreLogic",
			targets: ["CoreLogic"]
		),
		.library(
			name: "Common",
			targets: ["Common"]
		),
		.library(
			name: "Theme",
			targets: ["Theme"]
		),
		.library(
			name: "TransactionFeature",
			targets: ["TransactionFeature"]
		),
		.library(
			name: "SplashFeature",
			targets: ["SplashFeature"]
		),
		.library(
			name: "FeedFeature",
			targets: ["FeedFeature"]
		),
		.library(
			name: "OnlineShoppingFeature",
			targets: ["OnlineShoppingFeature"]
		),
		.library(
			name: "SettingsFeature",
			targets: ["SettingsFeature"]
		),
	],
	dependencies: [
		.package(
			url: "https://github.com/pointfreeco/swift-composable-architecture",
			from: "1.8.0"
		),
		.package(
			url: "https://github.com/SwiftGen/SwiftGenPlugin",
			from: "6.6.0"
		)
	],
	targets: [
		.target(
			name: "PaybackPackage",
			dependencies: [
				"Common",
				"Theme",
				"TransactionFeature",
				"SplashFeature",
				"CoreLogic",
				"FeedFeature",
				"OnlineShoppingFeature",
				"SettingsFeature",
			]
		),
		.testTarget(
			name: "PaybackPackageTests",
			dependencies: [
				"PaybackPackage"
			]
		),
		.target(
			name: "CoreLogic",
			dependencies: [
				"Common",
			],
			resources: [
				.process("Resources"),
			]
		),
		.testTarget(
			name: "CoreLogicTests",
			dependencies: [
				"CoreLogic"
			]
		),
		.target(
			name: "Common",
			dependencies: [
				"Theme",
				.product(
					name: "ComposableArchitecture",
					package: "swift-composable-architecture"
				),
			]
		),
		.target(
			name: "Theme",
			dependencies: [],
			resources: [
				.process("Resources"),
			],
			plugins: [
				.plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
			]
		),
		.target(
			name: "TransactionFeature",
			dependencies: [
				"Common",
				.product(
					name: "ComposableArchitecture",
					package: "swift-composable-architecture"
				),
			]
		),
		.testTarget(
			name: "TransactionFeatureTests",
			dependencies: [
				"TransactionFeature"
			]
		),
		.target(
			name: "SplashFeature",
			dependencies: [
				"Common",
				"Theme",
				.product(
					name: "ComposableArchitecture",
					package: "swift-composable-architecture"
				),
			]
		),
		.testTarget(
			name: "SplashFeatureTests",
			dependencies: [
				"SplashFeature"
			]
		),
		.target(
			name: "FeedFeature",
			dependencies: [
				"Common",
				"Theme",
				.product(
					name: "ComposableArchitecture",
					package: "swift-composable-architecture"
				),
			]
		),
		.testTarget(
			name: "FeedFeatureTests",
			dependencies: [
				"FeedFeature"
			]
		),
		.target(
			name: "OnlineShoppingFeature",
			dependencies: [
				"Common",
				"Theme",
				.product(
					name: "ComposableArchitecture",
					package: "swift-composable-architecture"
				),
			]
		),
		.testTarget(
			name: "OnlineShoppingFeatureTests",
			dependencies: [
				"OnlineShoppingFeature"
			]
		),
		.target(
			name: "SettingsFeature",
			dependencies: [
				"Common",
				"Theme",
				.product(
					name: "ComposableArchitecture",
					package: "swift-composable-architecture"
				),
			]
		),
		.testTarget(
			name: "SettingsFeatureTests",
			dependencies: [
				"SettingsFeature"
			]
		),
	]
)
