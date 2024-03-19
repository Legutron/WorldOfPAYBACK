//
//  SplashEnvironment.swift
//
//
//  Created by Jakub Legut on 16/03/2024.
//

import Common
import ComposableArchitecture

public struct SplashEnvironment {
	var checkConnection: () async throws -> Void
	
	public init(
		checkConnection: @escaping () async throws -> Void
	) {
		self.checkConnection = checkConnection
	}
}

public extension SplashEnvironment {
	static let unimplemented: Self = .init(
		checkConnection: XCTUnimplemented("checkConnection")
	)
}

public extension DependencyValues {
	var splash: SplashEnvironment {
		get { self[SplashEnvironmentKey.self] }
		set { self[SplashEnvironmentKey.self] = newValue }
	}

	enum SplashEnvironmentKey: TestDependencyKey {
		public static var testValue: SplashEnvironment = .unimplemented
	}
}
